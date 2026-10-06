[🇮🇹 Italiano](16-router-and-wan.md) · 🇬🇧 **English**

# Router, WAN and network connectivity

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

## What problem this solves

A POP is not an isolated network: it must carry customer traffic to
Internet Force's **private backbone** and from there to the Internet. That needs a
router that knows the POP's routes, the link to the central site and the default
route outward.

## How Internet Force implemented it

Internet Force kept two roles strictly separate (see
[Architecture overview](01-architecture.en.md)):

- a **Cisco 2501** for routing: the central *world/uplink* 2501, and one 2501 in
  each remote POP;
- a **Cisco 2511** (or 2509) access server for the modem bank, connected to the
  2501 by a serial link (covered in the [Dial-up](02-dialup-session.en.md) chapter).

POPs shared one addressing scheme: a private `/26` on the router Ethernet, a
`/25` serial link between router and access server, and the public dial-up `/24`.
Every router had a **default route toward the world/backbone gateway `10.0.0.1`**.
IOS in use: **10.2** on the 2501.

## Components and hosts

- Central/world Cisco **2501** (Internet uplink + IDT edge in New York).
- One Cisco **2501** per POP (`2501pesaro`, `2501gorgonzola`, `2501palermo`, …).
- The serial router ↔ access-server link.
- The private backbone between the POPs and Milan.

## Representative configuration

Example from the recovered Pesaro router configuration
(`systems/pops/pesaro/2501.cfg`):

```text
hostname 2501pesaro
!
interface Ethernet0
ip address 10.0.3.1 255.255.255.192
!
interface Serial0
ip address 10.0.3.129 255.255.255.128
!
ip route 0.0.0.0 0.0.0.0 10.0.0.1
ip route 10.0.0.1 255.255.255.255 Ethernet0
ip route 206.20.115.0 255.255.255.224 10.0.3.130
ip route 206.20.115.64 255.255.255.224 10.0.3.130
```

The default route points at the backbone gateway; the dial-up network routes go
through the access server (`10.0.3.130`). This is what connects the POP to the
rest of the network.

→ Complete configuration: [`systems/pops/pesaro/2501.cfg`](../systems/pops/pesaro/2501.cfg)
→ Others: [`systems/pops/`](../systems/pops/README.en.md) ·
[`systems/cisco-2501-uplink/config/2501.cfg`](../systems/cisco-2501-uplink/config/2501.cfg)

## How it connects to the rest of the POP

The router is the first link: it carries traffic to the backbone; the access
server connects the modems (dial-up chapter); the Unix servers (DATA, USERS)
provide the services. See also the host-side network configuration in
[Unix and networking](01-architecture.en.md).

## Related original material

- [`systems/cisco-2501-uplink/TECHNICAL.en.md`](../systems/cisco-2501-uplink/TECHNICAL.en.md)
- [`systems/cisco-2511-pop/TECHNICAL.en.md`](../systems/cisco-2511-pop/TECHNICAL.en.md)
- [`systems/pops/README.en.md`](../systems/pops/README.en.md)
- [`systems/data/system/rc.route`](../systems/data/system/rc.route) (host-side route)

*Sources: original Cisco configurations. The original operations
manual is at [`artifacts/operations-manuals/manual.md`](../artifacts/operations-manuals/manual.en.md).*

---

← [Build a POP](00-build-an-isp.en.md) ·
Previous: [Unix and host preparation](01-architecture.en.md) ·
Next: [Dial-up](02-dialup-session.en.md) →
