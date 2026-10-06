[🇮🇹 Italiano](13-network-growth-1995-1996.md) · 🇬🇧 **English**

# Network growth 1995 → 1996

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

The initial 1995 architecture had four POPs. Through 1996 Internet Force
expanded its coverage with additional POPs and new address blocks, and the
firmware and some access-server models changed as the network grew. This
page documents that second phase separately from the initial design.

## New POPs

| POP | Router | Access server | Address block | Notes |
|---|---|---|---|---|
| Seregno | — | — | 206.20.226.0/24 | reserved; block appears in the firewall's network list |
| Tera | 2501 at `10.0.7.1` | Cisco **2509** at `206.20.227.65` | 206.20.227.0/24 | domain `tera-it.com` |
| CNN | 2501 at `10.0.8.1` | 2511 at `206.20.228.65` | 206.20.228.0/24 | domain `cnn.it`; local DNS/auth initially |
| Fano | 2501 at `206.20.115.66` | 2511 at `206.20.230.65` | 206.20.230.0/24 | Pesaro sub-POP, 4 lines |
| INDI | 2501 at `10.0.10.1` | (frame-relay attached) | 206.20.231.0/24 | domestic link to Albacom |

The functional pattern stays the same as 1995: a **router** for the backbone
link and an **access server** for the modem bank, with centralised
authentication. Two details are specific to this phase:

- **Tera** used a Cisco **2509** access server rather than a 2511. The 2509
  is the smaller async router of the same family; it plays exactly the
  access-server role.
- **CNN** was intended to run more locally, and its router initially pointed
  authentication at a local address with a last-resort password and later
  used a local Windows NT DNS server - a departure from the centralised
  model, allowed thanks to Marco's consultancies in a phase
  in which Internet Force was heading towards closure.

## New address blocks

The firewall's `/etc/networks` and `/etc/netmasks` gained:

| Network | Name | POP |
|---|---|---|
| 206.20.226.0/24 | intf-seregno | Seregno |
| 206.20.227.0/24 | intf-tera | Tera |
| 206.20.228.0/24 | intf-cnn | CNN |
| 206.20.230.0/24 | intf-fano | Fano |
| 206.20.231.0/24 | intf-indi | INDI |

Corresponding reverse zones were added to DNS, and the new customer domains
(`tera-it.com`, and the secondary `cnn.it`) were served alongside the
existing ones.

## Regional links

Rather than connecting every new POP directly to the Milan backbone, the
domestic POPs were linked in a small tree:

- **Fano** hung off Pesaro over the serial link `10.0.9.128/25`, with Pesaro
  routing the Fano network `206.20.230.0/24` on to the backbone.
- **INDI** was reached over a **frame-relay** link between Milan/Pesaro and
  the INDI site, using the `10.0.10.0/24` range on the serial links
  (`POP_albacom-CISCO_configuration.txt` records the frame-relay maps for
  the Milan and Pesaro ends).

This is the same hub-and-spoke approach used in 1995, extended one level
deeper so that a small town POP could be served through a larger neighbour.

## Static routing and the planned evolution

With a single upstream connection, static routing was a natural choice: traffic
leaving Internet Force essentially had a single exit path, so a default route
toward the connectivity provider was sufficient. Introducing a dynamic routing
protocol would have added complexity without a corresponding operational
benefit.

Xpert had indicated that introducing a dynamic routing protocol would make sense
as part of a later architectural evolution: adding a second connection to an
Italian carrier and moving toward an Autonomous System of Internet Force's own.
With multiple independent links, potentially terminating at different geographic
locations, it would instead become necessary to manage internal paths dynamically
toward the different exit points.

In that design, IGRP would have handled internal routing. IGRP is an internal
routing protocol and does not itself create or define an Autonomous System: the
Autonomous System status and the multiple links concerned the external routing
architecture. These were technically different functions, but components of the
same planned evolution.

Internet Force closed before this evolution was implemented.

## Firmware and service evolution in 1996

Alongside the new POPs, 1996 brought the installation of:

- Cisco IOS **11.0** on the new routers (the 1995 routers ran 10.2/10.3);
- a **CERN httpd 3.0** caching proxy on the central network;
- the migration from **NCSA HTTPd to Apache**;
- **SSH/SCP** for secure administration, replacing telnet/rlogin/rsh and FTP;
- expanded modem capacity, particularly at Milano.

The initial 1995 four-POP network and this 1996 growth are deliberately
documented as two phases so that later configuration is not read back into
the launch architecture.

The operational procedure actually followed to add and configure a POP is
preserved in the original HOWTO
[`systems/pops/CISCO-add_new_pop-HOWTO.txt`](../systems/pops/CISCO-add_new_pop-HOWTO.txt).

---

See also: [Architecture overview](01-architecture.en.md) ·
[The POPs](../systems/pops/README.en.md) ·
[Historical notes](09-historical-notes.en.md)
