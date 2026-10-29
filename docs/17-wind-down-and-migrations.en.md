[🇮🇹 Italiano](17-wind-down-and-migrations.md) · 🇬🇧 **English**

# The closure of Internet Force and the later evolutions

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

Internet Force operated in 1995–1996 and closed while the Italian Internet-access
market was still very small. The surviving configurations and documents allow
this handover, and the later evolutions, to be followed.

Internet Force was not simply switched off. The infrastructure wind-down was
**designed and organised by Marco Iannacone** to minimise service interruption,
allow POPs that intended to continue operating to become independent, and
preserve continuity for customers whose services were still active.

The sequence was deliberately progressive. The remote POPs were separated first.
Only after those POPs had become independent did the final migration of the Milan
customers and central services to Enter take place.

This distinction matters: Internet Force was not moved wholesale to another
provider. Its infrastructure was **decomposed into several independent networks**,
with new links, new IP address space, local services and user accounts separated
by POP. Enter received only the remaining Milan operation.

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

**My retrospective reading** is that **Internet Force closed too early**: the partners judged the economics of
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
Internet Force operating
        |
        +--> POPs progressively made independent
        |        |
        |        +--> new COMM 2000 link
        |        +--> new public IP space
        |        +--> equipment renumbering
        |        +--> local services
        |        +--> customer accounts copied to the POP
        |        |
        |        +--> Pesaro Point
        |        +--> Pointest / Gorgonzola
        |        +--> Infosfera / Bergamo
        |        +--> other environments documented in the repository
        |
        +--> Milan + central services remain
                 |
                 +--> `marco` reinstalled with Linux
                 +--> USERS + DATA content copied beforehand
                 +--> Milan customers told the new Enter numbers
                 |
                 +--> final Internet Force shutdown
                 +--> physical transport of `marco` to Enter
                 +--> new IP 194.20.50.14
                 +--> Web virtual IPs
                 +--> DNS updated
                 +--> services restarted
                 |
                 +--> ~2 hours total downtime
```

## Making the POPs independent

The first phase of the wind-down was to make the POPs that wanted to continue
operating independent.

During the Internet Force period, the POPs depended on the central infrastructure
for essential functions, including address space supplied in the context of the
IDT connection and centralised authentication on USERS. Turning a POP into an
independent ISP therefore required much more than leaving it with routers, modems
and telephone lines.

Each POP first needed:

- a new Internet link;
- new public IPv4 address space;
- autonomous router and access-server configuration;
- local services, including authentication;
- the accounts belonging only to that POP's customers.

The carrier used for the links and address space during this phase was **COMM
2000**.

Waiting for the new link and addresses was a real migration constraint. The
equipment could not simply be detached from Internet Force while retaining the
`206.20.*` addresses used under IDT. Once moved into the new carrier's network, it
had to be renumbered and its configuration adapted.

When the local infrastructure was ready, Marco Iannacone copied the accounts
belonging to that POP's users onto its new systems. Each POP therefore took its
own customer base with it rather than continuing to depend on the central account
database.

The surviving configurations make the separation visible:

- Pesaro Point later uses `195.120.225.*`;
- Pointest, built from the former Gorgonzola POP, uses `194.133.145.*`, with
  `shelley.pointest.com` documented at `194.133.145.2`;
- Infosfera/Bergamo uses `194.235.140.*`, and its surviving Cisco 2511
  configuration contains `async default ip address 194.235.140.230`.

These addresses are not incidental configuration details. They are traces of the
point at which networks formerly belonging to Internet Force began to operate
independently.

For the full analysis of addressing and renumbering see
[IP addressing: public space, private backbone and carrier
dependency](24-ip-addressing-and-provider-space.en.md).

## The role of COMM 2000

COMM 2000 was a Milan telecommunications operator founded in 1985 and one of the
early Italian private telecommunications companies operating outside the
incumbent monopoly. During the 1990s it also developed into an Internet Service
Provider focused particularly on business customers.

In the Internet Force wind-down its role was specific: **it supplied the new
carrier links and public address space needed by POPs becoming independent**.
This allowed them to leave the Internet Force/IDT network and be configured as
autonomous infrastructures.

The source for COMM 2000's role in the migration is Marco Iannacone's direct
testimony as the engineer who designed and managed the technical wind-down. The
surviving configurations independently document the result through the new and
distinct address spaces used after separation.

COMM 2000 was acquired by KPNQwest in 2000 and renamed KPNQwest Italia. Messagenet
had been created from the COMM2000 group in 1999.

## Milan was the final stage

The migration of customers and central services to Enter took place **after** the
POPs had been made independent.

Enter therefore did not receive the entire Internet Force customer base. Users
belonging to already detached POPs had been transferred to their respective
independent infrastructures. **Only the Milan customers moved to Enter.**

The remaining central infrastructure still had to preserve services that had
previously been distributed mainly between USERS and DATA.

In preparation, Marco Iannacone reformatted his Linux workstation `marco`,
reinstalled Linux and configured it as a transition system capable of absorbing
the required central services. While Internet Force was still operating, he
copied the necessary data from USERS and DATA onto `marco`.

At the same time, Milan customers were informed by email of the new Enter dial-up
telephone numbers.

The system was therefore prepared before shutdown. What remained was the cutover
itself.

## The roughly two-hour final shutdown

The final move was not a remote migration. It also involved physically moving the
server.

When everything was ready, Marco Iannacone shut down the Internet Force
infrastructure. `marco`, already prepared and holding the necessary data from
USERS and DATA, was disconnected.

The machine was then **personally transported by Marco to Enter**.

In the roughly two hours of the final shutdown:
1. I connected and powered up `marco` on the Enter network;
2. I changed its IP address to fit the new provider's address space;
3. I configured the virtual IP addresses needed by the Web services;
4. I changed the DNS records;
5. I restarted and checked the services.

The documented main address for `marco` on the Enter network is:

`194.20.50.14`

Recovered DNS material subsequently makes names and roles previously distributed
across Internet Force converge on this host, including `users`, `mail`,
`mailhost`, `loghost`, and the MX records for `internetforce.com` and `intf.com`.

**About two hours after the Internet Force shutdown, the services were available
again.**

Milan customers could connect using the new Enter dial-up numbers that had
already been communicated to them.

The operational detail matters because it shows what an ISP migration meant in
1996: preparing data before cutover, renumbering, DNS changes, virtual IPs, and
even physically carrying the machine that would keep the services alive.

## Enter

Internet Force chose **Enter** as the destination for the migration of its
customers and central services. The surviving DNS configurations show Enter
authoritative for `internetforce.com` and `intf.com`, with files dated October
1996; the `news` feed pointed to `news.enter.it`. The Enter environment keeps
Cisco configurations for both Internet Force and Enter; it is described in
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

## Chronology and evidence basis

| Claim | Basis |
|---|---|
| The technical wind-down was designed and organised by Marco Iannacone | RECOLLECTION |
| POPs were made independent before the final Enter migration | RECOLLECTION + DOCUMENTED |
| COMM 2000 supplied new links and public IP space to the independent POPs | RECOLLECTION; resulting renumbering DOCUMENTED in later configurations |
| User accounts were separated by POP and copied to the respective systems | RECOLLECTION |
| Only Milan customers were migrated to Enter | RECOLLECTION |
| `marco` was reformatted/reinstalled and prepared before shutdown to absorb USERS and DATA content and services | RECOLLECTION + final result DOCUMENTED |
| Milan customers were emailed the new Enter dial-up numbers before cutover | RECOLLECTION |
| `marco` was physically moved from Internet Force to Enter during cutover | RECOLLECTION |
| `marco` had address `194.20.50.14` on the Enter network | DOCUMENTED |
| The final cutover included a new IP, Web virtual IPs and DNS changes | RECOLLECTION + IP/DNS DOCUMENTED |
| Total final-cutover downtime was about two hours | RECOLLECTION |

Methodological note: `RECOLLECTION` is a **primary source**, not a synonym for
unreliable information. The label distinguishes evidence provenance; it does not
automatically establish a hierarchy of evidential value.

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
[IP addressing](24-ip-addressing-and-provider-space.en.md) ·
[Archive provenance](archive-provenance.en.md)
