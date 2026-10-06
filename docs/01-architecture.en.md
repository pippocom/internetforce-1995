[🇮🇹 Italiano](01-architecture.md) · 🇬🇧 **English**

# Architecture overview

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

Internet Force was organized around one central site in Milan and a small
number of regional Points of Presence. Central services, authentication and
the international connection lived in Milan; the POPs provided local
telephone access and modem banks. This document describes the 1995 initial
architecture. The 1996 additions are covered in
[Network growth 1995 → 1996](13-network-growth-1995-1996.en.md).

The document proceeds in two movements. First the physical and logical
topology - backbone, central site, Internet edge, firewall, POPs, office LAN
and addressing conventions. Then the concrete way a single Unix machine
joined that network, from the first interface configuration to the
host-specific routes of the firewall. This second part is also written for a
reader who has never administered Unix or Linux: the concepts (`/etc`,
`/dev`, `root`, daemons, `ifconfig`, `route`, startup scripts) are explained
the first time they are relied on.

## The private backbone

The internal backbone was a private `10.0.0.0/8` network. An Ethernet hub
(back then ethernet switches were not available - yet) known as the **World Hub**
(`10.0.0.254`) joined everything on that side of the firewall:

- the central Cisco 2501 Internet uplink router (`10.0.1.1`);
- the firewall's world interface (`10.0.0.1`);
- the POP routers;
- the UPS.

The World Hub was the meeting point of the routing domain, not a customer
segment. Network names such as `intf-world` and `intfnet` in `/etc/networks`
identify it.

A *backbone* is the core network that interconnects sites and routers. An
Ethernet *hub* is the device that physically connects several hosts on the
same cable, forming a single collision domain. The World Hub did not serve
customers: it was where routers exchanged traffic destined for other
networks.

## The central site (Milan)

Because the central site and the Milano POP share the same physical
location, Milan appears twice in the topology: as the home of the central
UNIX service platform and the international edge, and as the Milano dial-up
POP. There is therefore **no separate Milano POP router**: the central/world
Cisco 2501 provides the Internet uplink, and the Milano Cisco 2511 provides
dial-up access.

The central UNIX machines sat behind the firewall on dedicated segments:

| Host | Address | Role |
|---|---|---|
| `firewall` | 206.20.95.129 (office), 10.0.0.1 (world) | Check Point FireWall-1 gateway |
| `data` | 206.20.95.3 | primary DNS, anonymous FTP, news, Majordomo, web/VIF |
| `users` | 206.20.95.4 | XTACACS, mail, POP3/IMAP, customer homes, secondary DNS |
| `dvlp` | 206.20.95.130 | development/build host (office LAN) |
| `marco` | 206.20.95.140 | administrator workstation (office LAN) |
| `shell` | 206.20.95.5 | planned customer shell host — never deployed |

The two production servers were Sun SPARCstation 5 systems running SunOS
4.1.4 with 64 MB of RAM. DVLP was a SPARCstation 4 with 32 MB.

DATA and USERS were *headless servers*: they had no monitor or graphical
console and were administered from a terminal. This matters for the second
part of the document, where it becomes clear that all of their configuration
lived in text files and scripts.

## The Internet edge: the Cisco 2501

The point where the private Internet Force network met the public Internet was
the central Cisco 2501, at the Milan site. The recovered configuration carries
the hostname `2501internet`.

**Evidence** — [`systems/cisco-2501-uplink/config/2501.cfg`](../systems/cisco-2501-uplink/config/2501.cfg):

```text
interface Ethernet0
 ip address 10.0.1.1 255.255.255.0
interface Serial0
 ip address 206.20.64.30 255.255.255.252
 encapsulation frame-relay
 bandwidth 128
ip default-gateway 206.20.64.29
ip route 10.0.0.0 255.0.0.0 10.0.0.1
ip route 206.20.95.0 255.255.255.0 10.0.0.1
```

- `Ethernet0` is the internal side, on the `10.0.0.0/8` backbone: `10.0.1.1/24`,
  known in `/etc/hosts` as `intf-idt`.
- `Serial0` is the link to IDT, with `ip address 206.20.64.30/30` and
  `frame-relay` encapsulation. The `bandwidth 128` field reflects the initial
  **128 kbit/s** link, later raised to about **2 Mbit/s** six months after
  launch.
- `ip default-gateway 206.20.64.29` sends everything that is not an
  Internet Force network towards IDT.
- `ip route 10.0.0.0 255.0.0.0 10.0.0.1` and
  `ip route 206.20.95.0 255.255.255.0 10.0.0.1` send internal traffic back
  towards the firewall's world interface.

The router therefore sent Internet traffic to IDT and internal traffic to the
firewall. An outbound access list on the serial link permitted only traffic
whose source was an Internet Force network, and a priority group gave
interactive and DNS traffic the highest priority. The canonical uplink
description is in the
[Cisco 2501 README](../systems/cisco-2501-uplink/README.en.md).

## Firewall and segmentation

The security gateway was a Sun SPARCstation 5 running Check Point FireWall-1
2.0a, with five Ethernet interfaces:

| Interface | Name | Address | Netmask | Connects to |
|---|---|---|---|---|
| `qe3` | fw-world | 10.0.0.1 | 255.0.0.0 | backbone / World Hub |
| `qe0` | fw-data | 206.20.95.10 | 255.255.255.192 | DATA segment |
| `qe1` | fw-users | 206.20.95.11 | 255.255.255.192 | USERS segment |
| `qe2` | fw-shell | 206.20.95.12 | 255.255.255.192 | planned SHELL segment |
| `le0` | office | 206.20.95.129 | 255.255.255.128 | office LAN |

DATA and USERS were not two machines sharing a common demilitarized segment.
Each was attached through its own firewall interface, so traffic between them
and the rest of the world was controlled at the host level. This is the
central expression of the design principle that security was built in from
the beginning. The firewall itself is described in
[the firewall README](../systems/firewall/README.en.md), including the recovered
original rule base; its network configuration is in the
[`systems/firewall/network/`](../systems/firewall/network/README.en.md)
directory.

## The Internet path for customers

Dial-up customers were on the world/backbone side of the network. Their
sessions terminated on the POP access servers and their traffic travelled
over the backbone to the central Cisco 2501, which forwarded it to IDT and
the Internet. The firewall was not there to protect those customer sessions -
a dial-up user runs no services and does not need to be protected - but to
guard the central servers and the office LAN.

The firewall was therefore the central security point for the parts of the
system that exposed services: DATA, USERS, the planned SHELL and the office
network. Inbound traffic to published services (DNS, web, mail, FTP, news)
passed through FireWall-1 to reach DATA and USERS, and the same policy
controlled how those servers and the office reached the world.

## POP topology

Each remote POP had two functional roles: a **router** (Cisco 2501) and a
**dial-up access server** (Cisco 2511, or a Cisco 2509 at Tera later). The
router carried POP traffic to the backbone; the access server terminated the
modem lines and authenticated callers.

| POP | Router | Access server | Dial network |
|---|---|---|---|
| Milano | central/world 2501 (uplink) | 2511 at 10.0.2.1 | 206.20.95.64/26 |
| Pesaro | 2501 at 10.0.3.1 | 2511 at 206.20.115.65 | 206.20.115.0/24 |
| Palermo | 2501 at 10.0.4.1 | 2511 at 206.20.224.65 | 206.20.224.0/24 |
| Gorgonzola | 2501 at 10.0.5.1 | 2511 at 206.20.225.65 | 206.20.225.0/24 |

Each POP initially had a bank of 16 US Robotics Courier 28.8 kbit/s modems.
The full detail is in [the POPs README](../systems/pops/README.en.md).

## The office LAN

The Milan office used a separate Ethernet segment, `206.20.95.128/25`, behind
the firewall's office interface. A 3Com LinkBuilder FMS hub
(`206.20.95.254`) was the shared 10Base-T collision domain. DVLP, Marco's
workstation and the office PCs and Macs were attached here. See
[the office LAN README](../systems/office-lan/README.en.md).

## Addressing conventions

- `10.0.0.0/8` — private backbone. Per-POP link subnets were carved from
  `10.0.0.0/8`, typically a `/26` on the router Ethernet and a `/25`
  point-to-point link to the access server.
- `206.20.95.0/24` — the Milan service block, subnetted as `206.20.95.0/26`
  (servers), `206.20.95.64/26` (Milano dial-up) and `206.20.95.128/25`
  (office).
- `206.20.64.0/24` — the IDT international link.
- `206.20.115.0/24`, `206.20.224.0/24`, `206.20.225.0/24` — the remote POP
  dial networks, with the customer pool in a `/27` on the access server.
- `206.20.226.0/24` … `206.20.231.0/24` — 1996 POPs.

The firewall applied host-specific routes on the DATA and USERS interfaces
(`/etc/rc.route` deleted the broad connected route and added one route per
server), which enforced the segmented design at layer 3 as well.

---

# Putting a Unix machine on the network

Let us imagine it is 1995 and we have just installed SunOS on a SPARCstation
or Linux on a PC. The machine boots, we have a shell and we can work locally.
From an ISP's point of view, however, **as it stands it is still practically
useless**: the first thing to do is give it an identity on the network and
teach it how to reach the other machines.

Today these details are largely hidden by DHCP, graphical installers,
NetworkManager or cloud-init. In the Unix world of the time they were far
more visible: almost all configuration lived in simple text files and startup
scripts. This is one of the most characteristic aspects of the Unix
philosophy, summed up in the formula *everything is a file*: it does not mean
that everything is literally a text file, but that files, devices and
configuration are exposed through simple, composable interfaces that are easy
to read and automate with small scripts.

Before going further, a few terms that recur constantly:

- **`/etc`** — the directory that collects the system's configuration files:
  `/etc/hosts`, `/etc/netmasks`, `/etc/networks`, `/etc/rc.route` and so on.
  They are normally text files that the administrator reads and edits.
- **`/dev`** — the directory of *device files*, special files through which
  programs talk to hardware (disks, serial ports, network interfaces). It is
  how Unix exposes hardware as a file.
- **`root`** — the administrator account (UID 0), the only one with enough
  privilege to change network and system configuration. The Internet Force
  machines were administered as `root` from a terminal.
- **daemon** — a process that keeps running in the background to provide a
  service, without an interactive terminal; examples are `inetd`, the
  super-server that launches other services on demand, and `named`, the DNS
  name server.
- **`rc` scripts** — the startup scripts run at boot. The name comes from
  *run commands*: they read the configuration files and re-run the commands
  that give the machine its network identity.
- **`ifconfig`** — the historic command to configure a network interface
  (assign address, netmask, broadcast).
- **`route`** — the command to read and modify the kernel's routing table,
  that is, the list of destinations and where to send packets.

## The five pieces of information a machine needs

To connect a host to an IP network, at least five things must be established:

```text
IP address
netmask
network address
broadcast
gateway
```

Take the Linux workstation `marco`, the machine from which the infrastructure
was administered and monitored (a 486-class PC with Linux and X11, at
`206.20.95.140`).

**Evidence** — [`systems/marco/system/rc.inet1`](../systems/marco/system/rc.inet1):

```sh
IPADDR="206.20.95.140"
NETMASK="255.255.255.128"
NETWORK="206.20.95.128"
BROADCAST="206.20.95.255"
GATEWAY="206.20.95.129"
```

This small block already describes, before any command is run, the machine's
position in the network:

- **IP address** (`IPADDR`) — the workstation's address. On a modern LAN it
  would arrive automatically from DHCP; here it is *static*, that is,
  hand-assigned, because `marco` had to be always reachable at the same
  address.
- **netmask** (`NETMASK`) — says which addresses belong to the same local
  network. `255.255.255.128` corresponds to the `/25` notation: the network
  runs from `206.20.95.128` to `206.20.95.255`. The machine can talk directly
  to hosts on this Ethernet segment; to reach other networks it needs a
  router.
- **network address** (`NETWORK`) — identifies the network itself, that is,
  `206.20.95.128/25`.
- **broadcast** (`BROADCAST`) — the address used to send a packet to every
  host on the segment (`206.20.95.255`).
- **gateway** (`GATEWAY`) — the exit towards the rest of the network. For
  `marco` this was `206.20.95.129`, the firewall's office interface on the
  office LAN.

In a picture:

```text
marco
206.20.95.140
      |
      | Ethernet
      |
206.20.95.129
FireWall-1
      |
      +------ rest of Internetforce
```

## Applying the address to the card: `ifconfig`

Writing the address into a variable does not change the machine yet: it has
to be applied to the Ethernet interface. In a Unix shell, `IPADDR="…"`
defines a variable and `$IPADDR` recalls it; `eth0` is the first Ethernet
interface on Linux.

**Evidence** — [`systems/marco/system/rc.inet1`](../systems/marco/system/rc.inet1):

```sh
/sbin/ifconfig eth0 ${IPADDR} broadcast ${BROADCAST} netmask ${NETMASK}
```

`ifconfig` assigns `eth0` the address `206.20.95.140`, with the given netmask
and broadcast. After this step `marco` can talk to the other hosts on its own
LAN, but it still does not know how to reach other networks.

## Building the routing table

An IP machine must know where to send packets. The first route says that the
local network is directly reachable over Ethernet:

**Evidence** — [`systems/marco/system/rc.inet1`](../systems/marco/system/rc.inet1):

```sh
/sbin/route add -net ${NETWORK} netmask ${NETMASK}
/sbin/route add default gw ${GATEWAY} metric 1
```

The first line adds the route for the local network:

```text
destination 206.20.95.128/25
        ↓
is local
        ↓
use eth0
```

The second is the **default route**, the most important rule:

> if you do not know a more specific route towards the destination, hand the
> packet to gateway `206.20.95.129`.

A packet's path therefore becomes:

```text
destination on the LAN?
      |
     yes ------> send directly over Ethernet
      |
     no
      |
      v
gateway 206.20.95.129
      |
      v
FireWall-1 / other networks
```

This is the fundamental principle of IP routing. Internet Force's network was
more articulated, but the concept does not change.

## The `rc` scripts: the same configuration at every boot

The five variables and the `ifconfig`/`route` commands were not typed by hand
at every restart. They lived in the file `rc.inet1`, which the system ran
automatically at boot - in the Slackware of the time, the `rc.*` scripts in
`/etc/rc.d/` are launched in a fixed order. The essential point is this: the
boot of a Unix machine **re-runs the same sequence of commands** we have just
read, restoring the interface and the routing table to the intended state
every time. Configuration is not a one-off event: it is a script that repeats
at every power-on.

The complete `rc.inet1` script, with its original comment and the exact order
of commands, is public:
[`systems/marco/system/rc.inet1`](../systems/marco/system/rc.inet1).
The workstation is described in
[the Marco workstation README](../systems/marco/README.en.md).

## On SunOS: hostname, `/etc/hosts` and `le0` interfaces

The Suns used a different convention from Linux, but the logic was identical.
The main Ethernet interface of the SPARCstations was called `le0`: `le` is
the AMD LANCE Ethernet driver used by those machines.

On SunOS the interface's identity lived in one file per interface, for
example `/etc/hostname.le0`, which contained the *name* of the host (not the
address):

**Evidence** — SunOS startup (`rc.boot`), reproduced from the technical notes:

```sh
hostname="`shcat /etc/hostname.??0 2>/dev/null`"
interface_names="`shcat /etc/hostname.* 2>/dev/null`"
ifconfig $1 "`shcat /etc/hostname\.$1`" netmask + -trailers up
```

- `shcat` prints the contents of a file; backquotes (`` `…` ``) run the
  command and insert its result into the line.
- The first line derives the host name from `/etc/hostname.le0` (or
  equivalent).
- The last line configures the interface by passing it that name; `netmask +`
  tells `ifconfig` to take the netmask from the `/etc/netmasks` table instead
  of a value written inline; `-trailers` disables the era's trailer
  encapsulation, and `up` activates the interface.

Why pass a *name* and not an address? Because `/etc/hosts` relates names to
IP addresses. A machine could be referred to simply as `data` and the system
would derive the corresponding address from `/etc/hosts`. The chain was:

```text
configuration file
      ↓
host name
      ↓
resolution in /etc/hosts
      ↓
ifconfig
      ↓
interface up
```

The firewall's `/etc/hosts` file is public and shows exactly this scheme, with
`data`, `users`, `shell`, the `fw-*` interfaces, the `intf-idt` router and the
office network names:
[`systems/firewall/network/hosts`](../systems/firewall/network/hosts).
The same idea - network identity entrusted to readable, composable text
files - is at the heart of the Unix philosophy described at the start of this
section.

> The network-identity files of DATA and USERS (`/etc/hosts`, `/etc/netmasks`,
> `/etc/networks`, `rc.route`) are published alongside their components:
> [`systems/data/system`](../systems/data/system/README.en.md) and
> [`systems/users/system`](../systems/users/system/README.en.md).

## DATA and USERS: the firewall as sole gateway

For a workstation like `marco`, a single default route is enough. The two
central servers had a more particular situation: DATA and USERS did not sit
on a normal shared LAN, but each had a dedicated Ethernet segment towards a
specific FireWall-1 interface. Their `rc.route` file built a correspondingly
particular routing table:

**Evidence** — DATA `rc.route` ([`systems/data/system/rc.route`](../systems/data/system/rc.route)) and USERS `rc.route` ([`systems/users/system/rc.route`](../systems/users/system/rc.route)); the two versions differ only in the comments:

```sh
hostname=`hostname`
route delete intfnet $hostname
route add $hostname $hostname 0
route add default fw-$hostname 1
```

- The first line puts the machine's current name into the `hostname` variable
  (for DATA it is `data`, for USERS it is `users`).
- `route delete intfnet $hostname` deletes the connected, broad route for the
  whole `206.20.95` network on that interface.
- `route add $hostname $hostname 0` adds a route for itself only.
- `route add default fw-$hostname 1` sets the corresponding firewall
  interface as the default gateway: for DATA it becomes `fw-data`, for USERS
  `fw-users`.

Therefore:

```text
DATA  -------- fw-data
                 |
              FIREWALL

USERS -------- fw-users
                 |
              FIREWALL
```

There was no large Ethernet on which all servers saw each other directly: the
firewall was an integral part of the topology, and each server saw the rest
of the infrastructure only through its own firewall interface.

The same pattern applies to the role-specific `rc.local` startup scripts:
[`systems/data/system/rc.local`](../systems/data/system/rc.local),
[`systems/users/system/rc.local`](../systems/users/system/rc.local) and
[`systems/firewall/network/rc.local`](../systems/firewall/network/rc.local).

## The firewall: five interfaces, several networks

FireWall-1 ran on a Sun with **five Ethernet interfaces** (the full table is
in the "Firewall and segmentation" section). This changes the problem: a
normal machine must know its own IP, whereas the firewall must know which
networks are connected to each of its interfaces and where to forward
traffic. Its `rc.route` is one of the most instructive pieces of evidence in
the archive.

**Evidence** — [`systems/firewall/network/rc.route`](../systems/firewall/network/rc.route):

```sh
ifconfig le0 netmask 255.255.255.128
ifconfig qe3 fw-world netmask 255.0.0.0
route add net 206.20.95.64 ts1 1
route add net 206.20.115.0 10.0.3.1 1
route add net 206.20.224.0 10.0.4.1 1
route add net 206.20.225.0 10.0.5.1 1
route add net default intf-idt 1
```

- `ifconfig le0 netmask 255.255.255.128` configures the office interface
  (`le0`) on the upper half `206.20.95.128/25`.
- `ifconfig qe3 fw-world netmask 255.0.0.0` configures the world interface
  (`qe3`) on the `10.0.0.0/8` backbone, with address `10.0.0.1`.
- `route add net 206.20.95.64 ts1 1` sends the Milano dial-up network to the
  access server `ts1` (`10.0.2.1`).
- The next three lines send the Pesaro, Palermo and Gorgonzola dial-up
  networks to their respective routers (`10.0.3.1`, `10.0.4.1`, `10.0.5.1`).
- `route add net default intf-idt 1` is the default route: everything that is
  not an Internet Force network goes to the central Cisco 2501 (`intf-idt`,
  `10.0.1.1`) and from there to the Internet.

This is the point where the provider's small network connects to the rest of
the Internet.

## Host-specific routing: why delete a route

The most interesting block is the one that configures the DATA segment:

**Evidence** — [`systems/firewall/network/rc.route`](../systems/firewall/network/rc.route):

```sh
ifconfig qe0 fw-data netmask 255.255.255.192
route delete intfnet fw-data
route add host data fw-data 0
route add host 206.20.95.20 fw-data 0
```

Why configure an interface and immediately delete the route to its network?
Because that segment was not to be treated as a normal LAN where any address
in the subnet is automatically reachable. The broad route - "the whole
network behind `fw-data`" - is removed and replaced by explicit destinations:
the host `data` and individual addresses.

On the USERS side the scheme is identical:

```sh
ifconfig qe1 fw-users netmask 255.255.255.192
route delete intfnet fw-users
route add host users fw-users 0
route add host 206.20.95.21 fw-users 0
```

The addresses `.20`–`.35` are the virtual interface addresses used by the
hosted web sites, described in [Web, news and FTP](05-web-news-ftp.en.md).
This way the firewall knows **only the addresses that must really exist on
that segment**: routing was not merely connectivity, it was already part of
the security architecture. The complete file is
[`systems/firewall/network/rc.route`](../systems/firewall/network/rc.route);
the firewall's network configuration, with its tables, is in
[`systems/firewall/network/`](../systems/firewall/network/README.en.md).

## The temporal layer of `rc.route`

The firewall's recovered `rc.route` does not belong to a single moment: it
also contains networks added during the 1996 expansion.

```text
206.20.226.0
206.20.227.0
206.20.228.0
206.20.230.0
206.20.231.0
```

These lines must be read as a **later layer**, not back-dated to 1995: they
describe the POPs added the following year. It is a general reminder: the
recovered artifacts may come from different moments and must be placed in
time, not treated as a single snapshot.

## The supporting files of the network configuration

Around the scripts were a few text files worth knowing, all public in the
[`systems/firewall/network/`](../systems/firewall/network/README.en.md)
directory:

- [`hosts`](../systems/firewall/network/hosts) — the name ↔ address table,
  used before (and alongside) DNS.
- [`netmasks`](../systems/firewall/network/netmasks) — the netmask associated
  with each network; this is the file that `ifconfig ... netmask +` consulted.
- [`networks`](../systems/firewall/network/networks) — the symbolic names of
  the networks (`intf-world`, `intf-office`, `intf-dialup`, `intf-servers`,
  `intfnet`), which also appear in the firewall routes.
- [`defaultrouter`](../systems/firewall/network/defaultrouter) — contains a
  single line, `intf-idt`, the default gateway for hosts that use only one.
- [`resolv.conf`](../systems/firewall/network/resolv.conf) — the DNS resolver
  configuration: domain `internetforce.com` and name servers
  `206.20.95.3`/`206.20.95.4` (DATA and USERS).
- [`inetd.conf`](../systems/firewall/network/inetd.conf) — the few services
  managed by the `inetd` super-server on the firewall; the analysis of
  hardening and `inetd` is in [Security](06-security.en.md).

## What the reader should take away

Configuring a Unix machine's network essentially meant answering four
questions:

```text
Who am I?
→ hostname + IP

Which hosts can I reach directly?
→ netmask + local network

Where do I send everything else?
→ default gateway

Are there destinations that need special paths?
→ specific routes
```

On a workstation a few lines sufficed; on a multihomed firewall the same ideas
became a real network topology. Only after these steps did it make sense to
talk about services:

```text
it has an address
      ↓
it knows its own network
      ↓
it knows where to send external traffic
      ↓
it is reachable by the other authorised systems
```

A perfectly configured web server with no IP address and correct routes is,
technically, an excellent way to serve web pages to nobody. This is why, in
this archive's path, network configuration comes before the individual
services.

## Unix philosophy and network identity

Behind the configurations just read is the Unix model on which the
Internet Force servers were built. The SunOS servers were administered mainly
through **command lines, text files and processes**: DATA and USERS were
headless and were not configured by opening graphical panels. The underlying
idea is that the system's state should be readable and reproducible - read a
file, run a command, chain actions with a script - rather than depending on a
single manual action.

A Unix host's **network identity** was made of exactly these elements:
`/etc/hosts` provided local name/address mappings, while the startup scripts
(`rc.route`, `rc.inet1`, `rc.boot`) configured interfaces and routing. On the
firewall, for example, the configuration distinguishes the five interfaces
already seen:

```text
le0  → office       206.20.95.129/25
qe0  → fw-data      206.20.95.10
qe1  → fw-users     206.20.95.11
qe2  → fw-shell     206.20.95.12
qe3  → fw-world     10.0.0.1/8
```

Internet Force **deliberately did not use NIS or NFS** in production: each
server kept its own data and authenticated locally, with XTACACS as the only
shared credential service. The comment in the `networks` file - "this file is
never consulted when NIS is running" - is a reminder that the artifacts also
contain standard preparatory fragments that do not reflect operational use.
The full analysis is in [Security](06-security.en.md).

Between a host's identity and the services it exposes there is one last step:
an IP address identifies the host, while protocol and port distinguish the
individual services (SMTP, POP3, IMAP, XTACACS on USERS). But "which sources
may reach which services" is a security question, not an addressing one: it
is addressed in [Security](06-security.en.md) and in the
[FireWall-1 technical guide](../systems/firewall/TECHNICAL.en.md).

---

## Continue

- [The dial-up session](02-dialup-session.en.md) — how a telephone call became
  an IP session.
- [Security](06-security.en.md) — the firewall, hardening and confinement.
- [Network growth 1995 → 1996](13-network-growth-1995-1996.en.md) — the POPs
  and networks added the following year.

---

→ [Build an Internet Force POP, step by step](00-build-an-isp.en.md)
