[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# The POPs

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../LICENSE)

Internet Force served customers through regional Points of Presence. A POP
was defined by two functional roles:

- a **router** — a Cisco 2501 that carried the POP's traffic onto the private
  backbone and toward Milan;
- a **dial-up access server (or terminal server)** — a Cisco 2511 (or, at Tera, a Cisco 2509)
  whose asynchronous lines were cabled to the modem bank and which
  authenticated every caller against USERS/XTACACS.

This split is the key to reading the POP configurations. The 2501 is the
routing device; the 2511/2509 is the access device. The initial POPs each
had a bank of **16 US Robotics Courier 28.8 kbit/s modems**.

## POP map

| POP | Router (2501) | Access server | Dial network | Customer pool |
|---|---|---|---|---|
| [Milano](milano/README.en.md) | central/world 2501 (uplink) | 2511 at `10.0.2.1` | 206.20.95.64/26 | 206.20.95.70–85 |
| [Pesaro](pesaro/README.en.md) | `10.0.3.1` | 2511 at `206.20.115.65` | 206.20.115.0/24 | 206.20.115.2–17 |
| [Palermo](palermo/README.en.md) | `10.0.4.1` | 2511 at `206.20.224.65` | 206.20.224.0/24 | 206.20.224.2–17 |
| [Gorgonzola](gorgonzola/README.en.md) | `10.0.5.1` | 2511 at `206.20.225.65` | 206.20.225.0/24 | 206.20.225.2–17 |
| [Later POPs](later-pops/README.en.md) | Tera `10.0.7.1`, CNN `10.0.8.1`, INDI `10.0.10.1` | 2509/2511 | 206.20.227/228/230/231.0/24 | per POP |

Milano is the special case: the central site and the Milano POP share the
same premises, so the central/world Cisco 2501 *is* the POP's router and
there is no separate Milano 2501.

## The common POP design

Every remote POP followed the same addressing pattern:

- a private `/26` on the router's Ethernet side and a `/25` serial link
  between the router and the access server;
- a public `/24` dial network, with the access server's Ethernet in the
  `.64/27` and the customer pool starting at `.2` in that `/27`;
- a default route on the router toward the world/backbone gateway
  (`10.0.0.1`) at the central site, so POP traffic left over the backbone
  toward the Internet;
- `tacacs-server host 206.20.95.4` on the access server, so every caller
  authenticated centrally.

Each dial-up terminal had a forward and reverse DNS name (`ppp1-16-<pop>`),
which kept connection logs readable.

## Geographic links and capacity planning

The remote POPs of Pesaro, Palermo and Gorgonzola reached Milan through
dedicated **CDA/CDN circuits at 64 kbit/s**. Milan remains the special case: the
Milano POP shared the central site premises and had no dedicated geographic
link.

Modem-bank sizing followed an **empirical rule used by Xpert**: the geographic
link capacity, multiplied by eight, had to be at least equal to the aggregate
nominal capacity of the modems.

```text
64 kbit/s × 8   = 512 kbit/s
16 × 28.8 kbit/s = 460.8 kbit/s
```

With 16 modems at 28.8 kbit/s, the theoretical aggregate was 460.8 kbit/s,
while 64 × 8 gave 512 kbit/s: therefore a 64 kbit/s POP link could comfortably
support 16 modems. The rule assumed statistically that not all users were
transferring data simultaneously at the maximum speed.

For the number of lines, Xpert used a reference of about **8-16 subscribers per
modem**, so as to keep a reasonable probability of finding a free line. A group
of 16 modems therefore corresponded to an indicative commercial capacity of
about **128-256 subscribers**. This is a planning ratio, not the number of
simultaneous sessions, and it should not be used to recalculate the overall
number of Internet Force subscribers.

## Adding a new POP

The operational procedure for adding and configuring a new POP is preserved in
the original HOWTO [`CISCO-add_new_pop-HOWTO.txt`](CISCO-add_new_pop-HOWTO.txt)
(**sanitized original**: the device enable credential was replaced). It
describes the flow actually followed: copy the known-good 2511/2501
configurations, run the Cisco setup dialogue, set the gateway and load the
configuration from the TFTP staging host, then update `netmasks`, `networks`,
`rc.route`, the FireWall-1 policy objects and the accounting configuration. The
same steps are summarised in
[Network growth 1995 → 1996](../../docs/13-network-growth-1995-1996.en.md).

## The customer session

The end-to-end path is described in
[The dial-up session](../../docs/02-dialup-session.en.md); the authentication
model is in [Authentication (XTACACS)](../../docs/10-authentication-tacacs.en.md).

---

See also: [Network growth 1995 → 1996](../../docs/13-network-growth-1995-1996.en.md)
