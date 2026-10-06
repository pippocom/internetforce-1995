[🇮🇹 Italiano](09-historical-notes.md) · 🇬🇧 **English**

# Historical notes

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

Internet Force was an Italian ISP built in Milan in 1995. This page collects
the organisational and historical context that sits around the technical
documentation: where the design came from, who built it, and how the service
evolved.

## Xpert UNIX Systems and the Tel Aviv training period

The technical design of Internet Force was developed with **Xpert UNIX
Systems**, an Israeli UNIX consultancy company; a particular role was played by **Yahel
Ben-David**, who acted as Marco Iannacone's principal technical mentor
during the build and training period. Marco spent roughly six months in Tel
Aviv while the Italian infrastructure, the international link and the Sun
hardware were being prepared.

A substantial body of reference material survives from that period. It was
copied at Xpert and brought back as reference, and it shows the kind of
environment Internet Force was modelled on: Linux and SunOS boot scripts, a
BIND-4 `named.boot` with Xpert's own domains, a Sendmail configuration, an
early Apache 1.1 configuration tree, FTP and accounting tools. The archive
keeps this material separate from Internet Force's own production
configuration; it is reference provenance, not Internet Force configuration.

The Xpert relationship continued after launch: the firewall's original rule
base allows `xpert.com` talk and remote-login access to DVLP and Marco's
workstation, which is the support path used during the early build.

## IDT and the international link

The upstream provider was **IDT**, reachable in New York. The initial
connection ran at **128 kbit/s**; roughly six months after launch the
international capacity was upgraded to **2 Mbit/s**. The IDT connection
defined the edge of the network: the central Cisco 2501 carried the IDT
default network on its serial link, addressed from `206.20.64.0/24`.

## Naming and addressing

Internet Force used names as documentation. Hosts were named for their role
(`data`, `users`, `firewall`, `dvlp`), the access servers were named `ts1`
and so on, and the dial-up terminals were numbered `ppp1` … `ppp16` per POP.
The well-known aliases (`mailhost`, `www`, `ftp`, `news`, `loghost`) mapped
services onto hosts so that services could be moved without changing the
public names. The customer/virtual domains hosted on DATA followed the same
principle.

## The people

Internet Force was built and operated by a very small team. **Marco
Iannacone** was the sole system and network administrator: he designed the
network with Xpert, built the central UNIX platform, ran the Cisco and
firewall infrastructure, wrote the monitoring and provisioning tools, and
handled day-to-day operations. The office also included web content and
administrative staff, whose accounts and role aliases appear in the recovered
configuration.

## The contemporary press

The reconstruction relies mainly on recovered technical material. An **external**
source helps frame Internet Force while it was active: an article in *Internet &
Musica* (the *Prova il provider* column, by Andrea Maffini), kept in
[`artifacts/press/`](../artifacts/press/README.en.md). It describes the POP
network, the services, Web hosting and the mail technologies, and documents an
early VRML (3D Web) experiment of the period.

## Timeline

- **Early 1995** — training and build in Tel Aviv and Milan; Sun hardware,
  private backbone and IDT link prepared; Xpert reference material collected.
- **1995** — launch. Central FireWall-1, DATA and USERS; four POPs (Milano,
  Pesaro, Palermo, Gorgonzola) with 16 modems each; NCSA HTTPd, BIND 4,
  Sendmail 8.6.12, XTACACS; international link at 128 kbit/s.
- **Late 1995 / early 1996** — international link upgraded to 2 Mbit/s;
  additional POPs and modem capacity; CERN caching proxy.
- **1996** — Tera, CNN, Fano, INDI and Seregno; migration from NCSA HTTPd to
  Apache; SSH/SCP introduced; an Oracle-on-Windows-NT web experiment.

## The recovered archive

The reconstruction rests on surviving pieces of a configuration archive saved by Marco:
Cisco IOS configurations for the uplink and every POP, the full
`/etc` trees of the firewall and the central servers, the BIND-4 zone set,
Sendmail configurations, the XTACACS daemon and its configuration, the
tkined map, the FireWall-1 rule base screenshot, and operational scripts and
procedures. The account given here combines these materials with the direct
recollection of Marco Iannacone, who built and ran the infrastructure.

---

See also: [Architecture overview](01-architecture.en.md) ·
[Network growth 1995 → 1996](13-network-growth-1995-1996.en.md) ·
[Xpert reference material](../systems/marco/reference-material/xpert/README.en.md) ·
[Learning the Internet: competence, autonomy and RTFM](23-learning-internet-culture.en.md)
