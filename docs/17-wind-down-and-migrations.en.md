[🇮🇹 Italiano](17-wind-down-and-migrations.md) · 🇬🇧 **English**

# The closure of Internet Force and the later evolutions

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

Internet Force operated in 1995–1996 and closed while the Italian Internet-access
market was still very small. Its end was not a sudden shutdown: it was a gradual
handover that moved customers and central services to **Enter** and made the POPs
that wanted to continue operating as independent providers progressively
autonomous. The surviving configurations and documents allow this handover, and
the later evolutions, to be followed.

## Why Internet Force closed

To understand the partners' decision it helps to recall how small the market was
at the time. In the mid-1990s Internet access in Italy counted in the order of
tens of thousands of users: about **50,000 Internet users in 1995**, and still at
an early stage in October 1996. The leading Italian provider, **Video On Line**
(VOL), founded in Cagliari in 1993 and active from 1994, had about **15,000
subscribers** in 1995 - a very large share of the market - and in June **1996**
was acquired by Telecom Italia, merging into the unit that became Tin.it.

During the **1996** expansion phase, Internet Force grew to around **2,000
subscribers**. For a much smaller company with fewer resources, that size was a
promising result. The market's growth came only a few years later: **Tiscali**,
founded in Cagliari in January **1998**, launched its free **FreeNet** service in
**1999** and quickly reached hundreds of thousands of users. This is not a direct
like-for-like comparison - the market, regulation and commercial model had
changed by then - but it shows how quickly the scale of the sector changed.

**Marco Iannacone's** retrospective reading, as author and curator of the archive,
is that **Internet Force closed too early**: the partners judged the economics of
the business while the Italian market was still tiny, and the company left before
the market revealed the scale it would reach shortly afterwards.

## A closure by migration, not a shutdown

The closure produced a technical migration project with two goals: **avoid
interrupting service** for the central customers, and **progressively make the
POPs autonomous** where they wanted to continue as independent providers. The
surviving material shows the process was already under way in the autumn of
**1996** and continued into **1997**.

The surviving company records also include material concerning the
[1996 bankruptcy](../artifacts/company/bankruptcy-1996/README.en.md), which
concerns the legal closure of the company and does not correspond to a single
moment of technical service shutdown.

```text
Internet Force (central)
        |
        +--> customers and services migrated to Enter
        |        |
        |        +--> workstation "marco" reconfigured as transition server
        |
        +--> POPs progressively made autonomous
                 |
                 +--> Pesaro Point
                 +--> Pointest / Gorgonzola
                 +--> Infosfera / Bergamo
```

## Enter

Internet Force chose **Enter** as the destination for the migration of its
customers and central services. The surviving DNS configurations show Enter
authoritative for `internetforce.com` and `intf.com`, with files dated October
1996, and the machine `marco` in the Enter network at `194.20.50.14`. Several
roles that had belonged to the Internet Force environment converged on `marco` -
`mailhost`, `users`, `mail`, `loghost` - together with the MX for
`internetforce.com` and `intf.com`; the `news` feed pointed to `news.enter.it`.

The Linux workstation `marco` was therefore reconfigured as a **transition
server**, to move customers and services while minimising the change perceived by
users. The Enter environment keeps Cisco configurations for both Internet Force
and Enter; it is described in
[`systems/enter/`](../systems/enter/README.en.md).

## Pesaro and Pesaro Point

The **Pesaro Point** material is among the most complete. An acceptance document
dated **22 October 1996**, signed by Gennaro Mascini for Pesaro Point srl,
declares the servers implemented by Marco Iannacone for Pesaro Point fully working
and compliant with the agreed specifications.

The archive also keeps Cisco 2501/2511 configurations, DNS configurations
(including for a Windows NT named), Linux and NT components, routing material and
the later changes of **March 1997**: it thus allows the POP's evolution towards an
autonomous infrastructure to be followed after the first migration. This material
is collected in
[`systems/pops/pesaro/post-internet-force/`](../systems/pops/pesaro/post-internet-force/).

## Gorgonzola and Pointest

The **Pointest** material documents the construction of local services for the
former Gorgonzola POP: components for BIND/DNS, POP3, XTACACS, Cisco 2511
configurations, the Linux filesystem configuration and NT components.

`pointest.com` was the domain associated with the Gorgonzola POP; in its initial
phase it was hosted centrally on DATA. The snapshot of the personal site
[`pippo.com` of 1997](../systems/marco/personal-web/pippo.com-1997/README.en.md)
uses CGI served from `pointest.com` for the counter and the contact form. The
Pointest material is collected in
[`systems/pops/gorgonzola/pointest/`](../systems/pops/gorgonzola/pointest/).

## Infosfera / Bergamo

The **Bergamo / Infosfera** material preserves a Cisco 2511 configuration and a
Linux system `sax` on which a process snapshot shows services including `named`,
`xtacacsd` and `sendmail`; an NT machine dedicated to other services is also
present. In this environment XTACACS authentication was active on the **Linux**
server, not on the NT machine - a detail that helps avoid confusing different
environments and phases. See
[`systems/infosfera-bergamo/`](../systems/infosfera-bergamo/README.en.md).

## Consultancy work after the closure

The closure of Internet Force did not end Marco Iannacone's technical work. In the
following months he continued to work as a **consultant** for several providers
that were born from or evolved out of the former POPs, through **separate
engagements tailored to the needs of each environment** and aimed at making its
infrastructure autonomous. It was not a single standardised migration programme:
depending on the context the work could concern DNS, routing, Cisco
configuration, authentication, mail services, Unix/Linux systems, Windows NT
components, and the construction or completion of an autonomous service
infrastructure.

The Pesaro, Pointest/Gorgonzola and Bergamo/Infosfera material should be read as
documentation of these distinct engagements and of the progressive transformation
of centralised POPs into autonomous infrastructures. **Enter** is somewhat
different: it represents the **migration destination** and the transition
environment for the central customers and services, and `marco` became part of
that infrastructure.

## Configurations from different moments

Part of the surviving configurations belongs to moments after Internet Force's
closure. The same POP or machine may appear in several versions, with addressing
or services that change over time: that is normal, and these versions should not
be artificially harmonised. The Internet Force period configurations remain
distinct from those of the later phase - for example the Pesaro POP configurations
from the Internet Force period are kept separate from the post-Internet-Force
material.

## What the archives contain

- **Enter** — Cisco configurations for Internet Force/Enter and a DNS set with the
  `internetforce.com`, `intf.com`, `enter.it` and other zones, plus the reverse
  zones `194.20.50`, `194.185.74`, `194.185.100`, `206.20.95`.
- **Pesaro** — Pesaro Point acceptance (22 October 1996), Cisco 2501/2511
  configurations (including Fano), Linux and Windows NT DNS, routing, and March
  1997 changes.
- **Pointest** — local services for Gorgonzola: XTACACS, POP3, BIND/DNS, Cisco
  2511, Linux filesystem and NT components.
- **Bergamo** — Infosfera/Bergamo: Cisco 2511 configuration, Linux `sax` system
  data and a process snapshot.

Some gaps remain: the exact closure date of Internet Force, the complete list of
migrated POPs and their fate, and the administrative detail of the customer
migration to Enter are not fully documented. No transitions are invented to fill
them.

For the provenance of the recovered material see
[Archive provenance](archive-provenance.en.md); for the reconfiguration of the
`marco` workstation see
[Marco's workstation](../systems/marco/README.en.md).

## Sources and context

Some market figures are used only as context and as an order of magnitude:

- *Video On Line* — founded 1993/1994, about 15,000 subscribers in 1995, acquired
  by Telecom Italia in June 1996:
  <https://it.wikipedia.org/wiki/Video_On_Line>.
- *Tiscali* — founded in January 1998 and launch in 1999 of the free service
  FreeNet: <https://it.wikipedia.org/wiki/Tessellis>, and the FreeNet launch
  reported by *la Repubblica*, 28 January 1999.
- Parliamentary hearing of October 1996 (STET): the Italian Internet market was
  described as still at an early stage.

The Internet Force data (more than 2,000 subscribers during the 1996 expansion phase) and the retrospective reading are
the author/curator's reconstruction and opinion.

---

See also: [Historical notes](09-historical-notes.en.md) ·
[Network growth 1995 → 1996](13-network-growth-1995-1996.en.md) ·
[Archive provenance](archive-provenance.en.md)
