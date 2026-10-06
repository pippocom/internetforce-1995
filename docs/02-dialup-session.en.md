[🇮🇹 Italiano](02-dialup-session.md) · 🇬🇧 **English**

# The dial-up session

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

This is the central story of the service: what happened when a customer's
computer dialed one of the Internet Force access numbers. The path runs from
the customer's PC, through the telephone network and a modem bank, into a
Cisco access server, through centralised XTACACS authentication, and finally
across the Internet Force backbone and the IDT link to the Internet.

```
customer PC
   │  analog call
   ▼
telephone network / hunt group
   ▼
US Robotics Courier 28.8 modem bank
   ▼
Cisco 2511 access server (POP) ───────────┐
   │  PPP                                  │  XTACACS request
   ▼                                       ▼
POP Cisco 2501 router              FireWall-1 protected path
   │                                       ▼
   ▼                               USERS (XTACACS, 206.20.95.4)
private backbone (10.0.0.0/8)              │  result
   ▼                                       ▼
central Cisco 2501 (10.0.1.1)      back to the access server
   ▼
IDT / New York → Internet
```

The data path is the left-hand column: from the 2511 to the POP router, over
the backbone and then to the central 2501 toward IDT. For the remote POPs
(Pesaro, Palermo, Gorgonzola) the POP router is a dedicated Cisco 2501; for
Milano the central/world 2501 plays that role, with no separate POP 2501.

The right-hand branch is authentication: the 2511 queries XTACACS on USERS
over the FireWall-1 protected path and receives the result. It is not a hop in
the customer's data path to the Internet.

## 1. The call

The customer configured a dial-up connection with the access number of the
nearest POP. Several telephone lines were published per POP; the telecom
network's hunt group (also called a rotary group) routed each call to a free
line, so customers did not need to know which modem would answer. The
recovered numbers are listed in
[Telephone access to the POPs](../systems/pops/telephone-numbers.en.md).

Pesaro, for example, published a block of lines and a main voice number;
Palermo, Gorgonzola and Milano each had their own local numbers. The number
itself was the only POP-specific setting in the customer's software.

## 2. The modem bank

Each POP had a bank of **16 US Robotics Courier 28.8 kbit/s modems**. A modem
answered the call and completed the analog handshake. The modems were
initialised with an AT string that set 115200 bit/s between the modem and the
access server (DTE) and 28800 bit/s over the telephone line (DCE):

```
ate0q1\q3\n3\j0&c1\d2&d2s0=1$b115200%b28800&w
```

The settings include echo off, result codes, hardware flow control, DCD
handling and DTR drop, plus auto-answer after one ring.

## 3. Two devices, two jobs

The initial remote POPs at Pesaro, Palermo and Gorgonzola used two Cisco
devices with distinct roles:

- **Cisco 2511 — access server.** An access server is a concentrator of
  asynchronous lines: it terminates the 16 serial ports wired to the modems,
  establishes a PPP session on each line, and authenticates callers centrally
  through XTACACS. The 2511 is the point where the customer enters the IP
  network.
- **Cisco 2501 — POP router.** A router connects the POP to the Internet Force
  backbone and decides where to forward packets once they are in: the networks
  reachable through that POP are described by its routes.

In short: the 2511 brought the customer onto the IP network; the 2501 knew
where to forward the packets after that. The separation explains why each POP
has two surviving configurations: they are not redundant, they are two roles.
The overall picture of the POPs is in [The POPs](../systems/pops/README.en.md).

Milan was different: it had its own Cisco 2511 for dial-up access, but the
routing role toward the world was played by the **central/world Cisco 2501**.
There was no second dedicated Milan 2501.

### Why a POP has a serial subnet between 2501 and 2511

The two devices were connected directly by a serial link (`Serial0` on both,
`encapsulation ppp`, 64 kbit/s). A point-to-point link still needs IP addresses
at both ends, so each POP used a small private subnet for this transit: not a
customer network, just the connection between access server and router. At
Pesaro it was `10.0.3.128/25`, with the 2501 on `10.0.3.129` and the 2511 on
`10.0.3.130`. The 2501 routed the dial-up networks (`206.20.115.0/27` and
`206.20.115.64/27`) toward the access server; the 2511 had a default route
toward the 2501 (`10.0.3.129`) and the 2501 a default route toward the
world/backbone gateway (`10.0.0.1`). Palermo (`10.0.4.128/25`) and Gorgonzola
(`10.0.5.128/25`) followed the same scheme.

## 4. Running IOS without a GUI

Cisco IOS, in this deployment, had no graphical interface: it was administered
from a command line. Initial setup used the serial console; once an IP address
was assigned and the device was reachable, it could also be administered
through Telnet. The AUI/10Base-T transceiver belonged to Ethernet connectivity,
not the serial console.

A typical IOS session went through:

```
Router> enable
Password:
Router# configure terminal
Router(config)#
```

The three prompts indicate three privilege levels: `>` is unprivileged EXEC
mode, with read-only commands; `#` is privileged EXEC mode, reached with
`enable`, from which the device can be changed; `(config)#` is global
configuration mode, reached with `configure terminal`, where parameters are
actually modified. Console and Telnet led to the same set of prompts.

## 5. The access server and its lines

The modem bank was cabled to a Cisco 2511 access server. Each modem maps to
one asynchronous line; the initial POPs used `line 1 16`, and the
corresponding `interface Async1` … `Async16` blocks configure the lines. The
essential configuration per line was:

- `encapsulation ppp` — the link protocol on the line was PPP;
- `async mode interactive` — the line accepted an incoming interactive call;
- `ip unnumbered Ethernet0` — the asynchronous interface borrowed Ethernet0's
  address instead of consuming a dedicated subnet for every line;
- `async default ip address <addr>` — the address offered to the caller if the
  peer did not negotiate one; it is the address that appears in the customer
  pool;
- `ip tcp header-compression passive` — TCP header compression was offered;
- line speed, flow control, `modem ri-is-cd`, and `stopbits 1`.

Milano's 2511 is a good example: its lines default to `206.20.95.70` through
`206.20.95.85`, within the `206.20.95.64/26` dial-up subnet. The full
configuration is in
[`systems/pops/milano/2511.cfg`](../systems/pops/milano/2511.cfg).

## 6. Authentication with XTACACS

Before the customer got a session, the access server authenticated the call
against the central XTACACS service. XTACACS (*Extended TACACS*) is Cisco's
authentication, authorisation and accounting protocol, the predecessor of
TACACS+: an `xtacacsd` daemon on a Unix host answers the requests of the
access devices, which therefore keep no local user database. Every access
server pointed at USERS:

```
tacacs-server host 206.20.95.4
tacacs-server extended
tacacs-server authenticate connections
tacacs-server authenticate slip always
tacacs-server notify connections
tacacs-server notify enable
tacacs-server notify logout
tacacs-server notify slip
```

USERS ran `xtacacsd` (XTACACS, revision 3.4, 1995) from `/etc/xtacacsd -ls`;
its configuration is in
[`systems/users/tacacs/xtacacsd-conf`](../systems/users/tacacs/xtacacsd-conf),
with the manual and documentation in
[`xtacacsd_man_and_config.txt`](../systems/users/tacacs/xtacacsd_man_and_config.txt).
Once a customer's username and password were verified, the line was authorised
and the accounting records were updated. XTACACS also maintained a per-Cisco
login record so the standard `last` command could produce connection reports,
and a dial-up accounting helper (`xacctd_user`) ran on USERS. Authentication,
authorisation and accounting for every POP were centralised this way.

This exchange is a **side branch** of the path: XTACACS requests crossed the
FireWall-1 protected path to reach USERS, while the customer's ordinary
Internet traffic stayed on the world/backbone side. USERS is not a hop in the
customer's data path to the Internet. Details are in
[Authentication (XTACACS)](10-authentication-tacacs.en.md).

## 7. The session

After authentication, the dial-up session was dynamically assigned an IP
address from the pool managed directly by access server (CISCO 2511). The address therefore
belonged to the connection session rather than to a permanent IP configuration
for that subscriber. Dynamic address assignment to subscribers should not be
confused with network routing: Internet Force routing was static. Routing on
the access server used the PPP peer and the server's default route toward the
backbone.

Customers could then use the full range of TCP/IP services: web browsing,
email, Usenet news, FTP and the rest. On Windows 3.1/95 machines the usual
TCP/IP stack of the period was **Trumpet Winsock**; Internet Force shipped it
on the customer
[Welcome Kit](../artifacts/customer-welcome-kit/README.en.md) together with a
printed user manual and the client programs for the main services.

## 8. Routing to the Internet

The session traffic left the access server toward the POP's Cisco 2501
router, which carried it onto the private backbone toward the central site.
There the central Cisco 2501 (`10.0.1.1`) sent it over the IDT link to New
York and into the Internet. Return traffic followed the reverse path.

Customer sessions stayed on the world/backbone side of the network; they did
not depend on the firewall for Internet access. FireWall-1 protected the
central servers and the office LAN - the parts of the system that actually
exposed services - with a separate policy for each server interface.

## 9. Dial-in reference

| POP | Access server | Router (2501) | Customer address pool | Modems |
|---|---|---|---|---|
| Milano | 2511 `10.0.2.1` | central/world 2501 | 206.20.95.70–85 | 16 |
| Pesaro | 2511 `206.20.115.65` | `10.0.3.1` | 206.20.115.2–17 | 16 |
| Palermo | 2511 `206.20.224.65` | `10.0.4.1` | 206.20.224.2–17 | 16 |
| Gorgonzola | 2511 `206.20.225.65` | `10.0.5.1` | 206.20.225.2–17 | 16 |

Each customer address had a matching reverse-DNS entry (`ppp1-16-<pop>`).
Later POPs added dial-up capacity in 1996 and are covered in
[Network growth 1995 → 1996](13-network-growth-1995-1996.en.md).

The geographic link of the remote POPs (Pesaro, Palermo, Gorgonzola) toward
Milan was a dedicated **CDA/CDN circuit at 64 kbit/s**; how the modem bank was
sized against that capacity is described in
[The POPs](../systems/pops/README.en.md).

## Recovered sources

- Central/world router: [`systems/cisco-2501-uplink/config/2501.cfg`](../systems/cisco-2501-uplink/config/2501.cfg)
- Pesaro: [`2501.cfg`](../systems/pops/pesaro/2501.cfg), [`2511.cfg`](../systems/pops/pesaro/2511.cfg)
- Palermo: [`2501.cfg`](../systems/pops/palermo/2501.cfg), [`2511.cfg`](../systems/pops/palermo/2511.cfg)
- Gorgonzola: [`2501.cfg`](../systems/pops/gorgonzola/2501.cfg), [`2511.cfg`](../systems/pops/gorgonzola/2511.cfg)
- Milano: [`2511.cfg`](../systems/pops/milano/2511.cfg)
- XTACACS on USERS: [`xtacacsd-conf`](../systems/users/tacacs/xtacacsd-conf),
  [`xtacacsd_man_and_config.txt`](../systems/users/tacacs/xtacacsd_man_and_config.txt)
- POPs and numbers: [The POPs](../systems/pops/README.en.md),
  [telephone numbers](../systems/pops/telephone-numbers.en.md)

These files are different temporal layers: they were recovered at different
times and may not match each other perfectly.

---

Follow-on flows: [DNS](03-dns.en.md) · [Email](04-email.en.md) ·
[Web, FTP, news and mailing lists](05-web-news-ftp.en.md) ·
[Authentication (XTACACS)](10-authentication-tacacs.en.md)

---

→ [Build an Internet Force POP, step by step](00-build-an-isp.en.md)
