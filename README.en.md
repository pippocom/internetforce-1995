[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# Internet Force 1995–1996 — a technical reconstruction by Marco Iannacone

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](LICENSE)
> **Repository:** https://github.com/pippocom/internetforce-1995

Internet Force was an Italian Internet Service Provider built in Milan in
1995. It was designed from the ground up as an ISP - not as a bulletin-board
system that grew into one - with a private backbone, four regional Points of
Presence, a central Sun UNIX service platform, a Check Point FireWall-1
security gateway and a dedicated international link to IDT in New York.

This repository reconstructs how the service actually worked, using the
recovered configuration archive and the recollection of Marco Iannacone, who
built and ran the infrastructure as its sole system and network
administrator. The documentation is written for someone who wants to
understand the architecture and the day-to-day operation, not just admire the
hardware.

## Explore Internet Force

Two principal routes to explore the archive:

- **Build an Internet Force POP** — the technical walkthrough showing how the
  1995 infrastructure was assembled, from Unix host preparation through
  routing, dial-up, authentication, DNS, mail, Web, security, monitoring and
  operations.
  → [Build a POP, step by step](docs/00-build-an-isp.en.md)
- **Explore the network** — three interactive historical maps to browse the
  1995 infrastructure visually and open real system pages
  and surviving configurations.
  → [Explore Internet Force](site/index.en.html)

## The system at a glance (1995)

- **International edge** — a Cisco 2501 at the central site, connected to
  IDT/NYC, initially at 128 kbit/s and upgraded to 2 Mbit/s about six months
  after launch.
- **Backbone** — a private `10.0.0.0/8` network joining the central site, the
  firewall and the POP routers.
- **Security** — a Sun SPARCstation 5 running Check Point FireWall-1 2.0a,
  with separate interfaces for the DATA and USERS servers, the office LAN and
  the world/backbone side.
- **Central services** — a Sun SPARCstation 5 pair: DATA (DNS, FTP, news,
  mailing lists, web/VIF) and USERS (authentication, mail, customer homes,
  personal web, secondary DNS).
- **POPs** — Milano (co-located with the central site, where the central/world
  Cisco 2501 serves as the router and the local 2511 as the access server),
  Pesaro, Palermo and Gorgonzola, each with a Cisco 2501 POP router and a
  Cisco 2511 access server feeding a bank of 16 US Robotics 28.8 kbit/s
  modems.
- **Authentication** — XTACACS on USERS, used by every access server.
- **Development** — a separate SPARCstation 4 build host on the office LAN.

## How to read this repository

The repository has two complementary entry points and a short cultural context.

### 1. Build the ISP — narrative path

[**Building an ISP like Internet Force, step by step**](docs/00-build-an-isp.en.md)
guides the reader starting from freshly installed operating systems and
following the actual configuration steps that turn a set of Unix machines,
routers, modem banks and network links into a working provider.

No practical prior knowledge of Unix or Linux is required: every Unix concept
(`/etc`, `/dev`, `root`, a daemon, `inetd`, `chmod`, `chroot`, …) is explained
where it is needed. The dial-up session is **one chapter** of this larger path,
not the whole path.

1. [Building an ISP, step by step](docs/00-build-an-isp.en.md) — the complete
   educational sequence.
2. [The dial-up session](docs/02-dialup-session.en.md) — from a customer PC and
   the telephone hunt group, through the modem bank and the Cisco access
   server, through XTACACS authentication, and out to the Internet.
3. [Authentication (XTACACS)](docs/10-authentication-tacacs.en.md) — how each
   access server validated users against USERS.
4. [DNS](docs/03-dns.en.md) — how names resolved once the session was up.
5. [Email](docs/04-email.en.md) — SMTP, POP3 and IMAP for customers.
6. [Web, FTP, news and mailing lists](docs/05-web-news-ftp.en.md) — the public
   services a customer reached.
7. [The customer Welcome Kit](artifacts/customer-welcome-kit/README.en.md) — the
   manual, the Easy! customer program and the installation floppies shipped to
   new customers.

### 2. Explore by system and infrastructure

Best for understanding the architecture component by component:

- [Architecture overview](docs/01-architecture.en.md) — topology, addressing,
  host configuration and segmentation.
- [Network growth 1995 → 1996](docs/13-network-growth-1995-1996.en.md) — the
  later POPs and expansions.
- [The closure of Internet Force and the later evolutions](docs/17-wind-down-and-migrations.en.md)
  — Enter, Pesaro Point, Pointest/Gorgonzola and Infosfera/Bergamo.
- [The Internet uplink](systems/cisco-2501-uplink/README.en.md) — the central
  Cisco 2501.
- [The POPs](systems/pops/README.en.md) — Milano, Pesaro, Palermo, Gorgonzola
  and the later POPs.
- [The firewall](systems/firewall/README.en.md) — FireWall-1 and the real rule
  base.
- [DATA](systems/data/README.en.md) and [USERS](systems/users/README.en.md) — the
  central service hosts.
- [DVLP](systems/dvlp/README.en.md) — development and build.
- [The office LAN](systems/office-lan/README.en.md) — the Milan office network.
- [VIF on SunOS](systems/sun-vif/README.en.md) — virtual interfaces for virtual
  hosting.
- [Monitoring](docs/08-monitoring.en.md) — tkined and SNMP.
- [Software inventory](docs/11-software-inventory.en.md) — versions and origins.
- [Operations and backup](docs/14-operations-and-backup.en.md) — routine tasks.
- [Historical notes](docs/09-historical-notes.en.md) — Xpert UNIX Systems, the
  Tel Aviv training period and the organisational context.
- [Archive provenance](docs/archive-provenance.en.md) — how the materials were
  recovered.

### Historical and cultural context

Internet Force was born inside a precise technical culture. How skills were
acquired and shared on that network - manuals, RFCs, `man` pages, FAQs, mailing
lists and Usenet, and the expectation of researching before asking - is told in
[Learning the Internet: competence, autonomy and RTFM](docs/23-learning-internet-culture.en.md).

## Timeline

- **1995 — design and launch.** Xpert UNIX Systems (Israel) assists with the
  design; Marco trains in Tel Aviv; the Sun hardware, the private backbone
  and the IDT link are built. NCSA HTTPd, BIND 4, Sendmail 8.6.12, XTACACS.
  Four POPs. The international link starts at 128 kbit/s and is later
  upgraded to 2 Mbit/s.
- **1996 — growth.** Additional POPs (Tera, CNN, Fano, INDI, Seregno),
  expanded modem capacity, a CERN caching proxy, migration from NCSA HTTPd
  to Apache, and SSH/SCP for secure administration.
- **1996–1997 — closure and migration.** Internet Force closes; customers and
  central services migrate to **Enter**, while the POPs that continue operating
  are progressively made autonomous (Pesaro Point, Pointest/Gorgonzola,
  Infosfera/Bergamo). See
  [The closure of Internet Force and the later evolutions](docs/17-wind-down-and-migrations.en.md).

## Repository layout

```
docs/          narrative documentation (architecture, services, operations)
systems/       per-system reference: uplink, pops, firewall, data, users,
               dvlp, office-lan, marco, oracolo, enter, infosfera-bergamo
artifacts/     historical materials: welcome kit, inventories, manuals,
               photographs, email archive, Usenet, tools
site/          static web presentation
```

The per-system reference also includes the historical areas `systems/marco/`,
`systems/oracolo/`, `systems/data/proxy-server/`, `systems/pops/cnn/`,
`systems/pops/gorgonzola/pointest/`, `systems/pops/pesaro/post-internet-force/`,
`systems/enter/` and `systems/infosfera-bergamo/`.

The repository also contains the **recovered configuration files**, next to the
system they belong to or under `artifacts/`. Each directory has a short note
explaining what the files are and how credentials and personal data were
handled; see [`artifacts/README.md`](artifacts/README.en.md).

---

Marco Iannacone built and operated this infrastructure. Corrections and
additions based on the recovered archive are welcome.
