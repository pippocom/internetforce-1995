[🇮🇹 Italiano](03-dns.md) · 🇬🇧 **English**

# DNS

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

Users did not want to remember `206.20.95.3`: they wanted to use names such as
`www.internetforce.com`. The **Domain Name System (DNS)** solves this problem
with a hierarchical, distributed database in which each level delegates
authority to the next and no single node knows the whole tree. Internet Force ran
its own name service with **BIND**. The **DATA** server (`206.20.95.3`) was the
primary nameserver; the **USERS** server (`206.20.95.4`) was the secondary.
Both ran BIND 4, the version of the time, configured through `/etc/named.boot`
rather than the newer `named.conf` format.

The exact BIND release (for example `4.x.y`) is not attested in the recovered
files: the archive documents the **style** of the configuration - the BIND 4
`cache`, `primary` and `secondary` directives - but not the release number.
This is a stated gap, not a value to be invented.

The recovered configuration and zone files live in
[`systems/data/dns/`](../systems/data/dns/README.en.md).

## The resolver and authoritative servers

Two distinct roles explain how names became addresses:

- the **resolver** (or *stub resolver*) is the client side: a library on every
  machine that, when a program asks for `www.internetforce.com`, sends the
  question to the configured nameservers;
- the **authoritative server** is the side that holds a zone's data and answers
  with authority, guaranteeing that the answer comes from the source of the
  domain.

BIND can play both roles. At Internet Force, DATA and USERS were the
authoritative servers for the Internet Force and customer zones; every host on
the network instead had its own resolver configured to query them.

## Server roles

The primary carried authoritative data for the Internet Force domains and for
the hosted customer domains. The secondary transferred the zones from the
primary and could answer queries if the primary was unavailable. Every
server on the network pointed at both:

```
domain internetforce.com
nameserver 206.20.95.3
nameserver 206.20.95.4
```

The firewall, DATA, USERS and the office machines used the same resolver
configuration, with `host.conf` ordering `bind,hosts` on the servers (resolve
through DNS first, then the local hosts file) and `hosts,bind` on the
firewall.

## `named.boot`

`named` had to know where to find its data and for which zones it was
authoritative. In BIND 4 this was declared in `named.boot`, the service's boot
file. The main directives are:

- `directory`: the base directory for the DNS files.
- `cache .`: the root-hints file, the starting point for reaching the root
  name servers.
- `primary`: this machine is the authoritative master for the zone and loads it
  from a local file.
- `secondary`: this machine keeps an authoritative copy obtained from the
  master through a zone transfer.

The recovered `named.boot` is
[`systems/data/dns/named.boot`](../systems/data/dns/named.boot). Its opening
lines show the real structure:

```
directory /usr/local/etc/named/named-data

; type    domain                    source host/file    backup file
cache     .                         root.cache
primary   internetforce.com         primary/internetforce.com
primary   intf.com                  primary/intf.com
primary   pippo.com                 primary/pippo.com
primary   internetforce.it          primary/internetforce.it
...
primary   95.20.206.IN-ADDR.ARPA    primary/db.206.20.95
```

## Root servers and the cache file

DNS is hierarchical: the root `.` sits at the top, first-level domains such as
`com` and `it` sit beneath it, and domains such as `pippo.com` or
`internetforce.it` sit below those.

```
                    .
               root servers
                    │
          ┌─────────┴─────────┐
         com                 it
          │                   │
      pippo.com       internetforce.it
```

The file named by `cache .` is not the ordinary query cache: it holds the
**root hints**, the names and addresses from which `named` begins to reach the
DNS root. The Internet Force original is
[`systems/data/dns/named-data/root.cache`](../systems/data/dns/named-data/root.cache),
derived from `nic.ddn.mil` and updated into the early 1990s. It lists nine root
servers, from `A.ROOT-SERVERS.NET` to `I.ROOT-SERVERS.NET`, with their `A`
records (for example `A` → `198.41.0.4`, `B` → `128.9.0.107`). It is a
historical list: it must not be replaced with the modern one, because its value
is documenting **which** root hints the server had in 1995–1996.

## Domains and zones

The primary served three Internet Force domains plus a portfolio of customer
and virtual domains:

- `internetforce.com`
- `intf.com`
- `internetforce.it`
- customer/virtual domains including `canalemoda.com`, `sicilia.com`,
  `pesaro.com`, `pcpesaro.com`, `art-diary.com`, `creo-mi.com`,
  `boldyoung.com`, `loveisland.com`, `shiseidoit.com`, `calabria.com`,
  `glassonline.com`, `tecnos.com`, `nassetti.com`, `financialreports.com`,
  `net-pool.com`, `promotion.it` and `tera-it.com`.

`intf.com` was an internal zone parallel to `internetforce.com`: it repeated the
same host and service structure and used `MX 0` towards
`users.internetforce.com` and `MX 1` towards `data.internetforce.com` (file
[`intf.com`](../systems/data/dns/named-data/primary/intf.com)).

`cnn.it` was served as a secondary. Reverse zones covered the POP address
blocks `206.20.95`, `206.20.115`, `206.20.224`, `206.20.225`, `206.20.226`
and `206.20.227`.

The `.com` zone was delegated through the IOS nameservers used by the IDT
connection (`styx`, `noc`, `harley`), while the `.it` zone used the Italian
GARR nameservers. These delegations reflect how the domains were registered
rather than something Internet Force configured itself.

## Registering a domain: InterNIC, GARR and delegation

Creating a `pippo.com` zone locally is not enough for the name to resolve from
the Internet. The domain must first be **registered** and **delegated** in the
global hierarchy, and only then can the authoritative nameservers answer for
it. In 1995 generic domains (`com`, `org`, `net`) went through
InterNIC/Network Solutions; for the `.it` domain Internet Force dealt with the
Italian structure connected to GARR/Registro.

The material already recovered for `PIPPO.COM` documents the outcome of the
registration:

```
Record created: 10-May-95
Primary DNS:    DATA.INTERNETFORCE.COM
Secondary DNS:  HARLEY.IOS.COM
```

A later `MODIFY DOMAIN pippo.com` request and an InterNIC acknowledgement are
also present. The path is always the same: domain request →
registry/NIC → declared nameservers → `named.boot` → zone file → domain
resolvable.

### How a `.it` domain was actually registered

In 1996, registering a `.it` domain was a multi-stage process in which
the technical infrastructure had to be prepared before the registration
itself could be completed.

**The DNS came first.** The authoritative nameservers for the new zone
had to be available, with at least a primary and a secondary server.
Internet Force's surviving requests identify both the server names and
their IP addresses. The 21 June 1996 request for `internetforce.it`, for
example, listed `dns.internetforce.it` together with the GARR-NIS
secondary server `dns.nis.garr.it`; later requests for domains hosted by
Internet Force show the same pattern.

**The technical request was then sent by email to GARR-NIS**, at
`domain@nis.garr.it`, with `staff@nis.garr.it` used for correspondence
with the staff. The “form” was effectively a structured database object.
It included the domain and organization names, a description, the
`admin-c`, one or more `tech-c` contacts, `postmaster`, `zone-c`, the
nameservers and their addresses, the associated network, and person
objects containing postal address, telephone, fax and email details.

If the organization was not already present in the GARR-NIS database,
an **organization-registration object** was sent separately to
`ORG-REG@NIS.GARR.IT`. Internet Force's own registration supplied the
company name and address, province, postal code, country, telephone and
fax numbers, associated domain, directory administrator and the
administrative and technical contacts. The same sequence survives for
the later registration of `cnn.it`.

The registry then performed its checks. An automated procedure
identified in the replies as the **GARR NIS Syntax Phase** first
validated the formal structure of the submitted objects. Once the syntax
check had succeeded, the request was passed to the Registration
Authority staff for a **semantic-control phase**, including verification
of the requested domain name and cross-checking against the requesting
organization's documentation.

The electronic request was not sufficient. The applicant also had to
sign a **Letter of Assumption of Responsibility (LAR)** and, for a
company, provide the required corporate documentation, including the
company-register extract. A surviving email dated 24 June 1996 states
that Internet Force had arranged for both the LAR and the detailed
company information requested for `internetforce.it` to be sent to
GARR-NIS by fax. Contemporary GARR-NIS signatures identify the service
at CNUCE-CNR, via S. Maria 36 in Pisa, with fax number
`+39 50 904052`.

Only after the administrative and technical checks had been completed
could the domain be entered into the GARR-NIS database and
registration/delegation completed. Later registrations preserved in the
archive show the complete cycle. For `cnn.it`, the request sent on
2 September 1996 was followed the same day by `Syntax Check Phase OK`;
on 11 September the system returned `Update OK` and notified Internet
Force that the `cnn.it` object had been created. For `promotion.it`, a
request submitted on 19 September passed the syntax phase and the new
database object was created on 24 September.

The checks were not purely administrative. GARR-NIS also tested
operational requirements: on 1 August 1996 an automated message was sent
to `postmaster@internetforce.it` to verify that the mandatory
`postmaster@<domain>` address was actually reachable.

The surviving correspondence therefore documents a process very
different from today's near-instant registrar workflow:
**DNS prepared in advance → technical request by email → organization
registration when required → automated syntax check → LAR and corporate
documentation by fax → Registration Authority semantic checks →
database insertion and delegation**.

The preserved examples (`internetforce.it`, `cnn.it`, `promotion.it`),
the forms and the postmaster test are held in the GARR-NIS exchanges: see
[`domini_it.en.txt`](../artifacts/domain-registration/domini_it.en.txt), the
[domain registration artifacts](../artifacts/domain-registration/README.en.md)
and the
[`GARR-DOMINI_IT.mailbox`](../artifacts/email-archive/technical/GARR-DOMINI_IT.mailbox).

### Why `.it` was more restrictive than `.com`/`.net`

Compared with generic `.com`/`.net` domains - where registration with InterNIC
essentially meant submitting contacts and nameservers - the 1996 `.it` was much
more restrictive and administratively more complex:

- the general rule was **one `.it` domain per eligible entity**;
- **natural persons** were not yet generally admitted to registration;
- registration was aimed at **organizations or economic subjects** with the
  required legal/fiscal identification;
- allocation followed **chronological priority** among valid requests
  (*first come, first served*);
- both **administrative and technical documentation** were required, and the
  authoritative DNS had to be configured before delegation;
- the **LAR** was part of the administrative process;
- **categories of reserved names** existed, including the Italian geographical
  namespace.

A domain name was first of all a **network identifier**, not a trademark: the
rules of the period did not require the name to match the company name, a
registered trademark or an acronym.

The institutional context was distinct from its roles: the **Registration
Authority** function was exercised at **CNR-CNUCE in Pisa**, where the
**GARR-NIS** service managed the `.it` domain database and the correspondence
with applicants; the rule-making function - the one that would later be formally
constituted as the Italian **Naming Authority** - was separate from the
operational management of the registry. GARR was the network infrastructure in
which the service operated, not a synonym for the registry.

This restrictive framework changed with the **liberalisation that entered into
force on 15 December 1999**: for companies and commercial entities the
one-domain limit was removed; eligibility was broadened; natural persons were
also admitted, initially with a one-domain limit; procedures were simplified.

The Internet Force period coincides with the first rapid expansion of the `.it`
namespace. According to the historical figures reported by Stefano Trumpy,
**new registrations during the year** were about **1,312 in 1995**, **5,243 in
1996**, **14,807 in 1997** and **16,148 in 1998**; `.it` registration remained
free until the end of 1997.

## Reading a zone

A DNS zone is a text file with records of different types. The most important
for reading the Internet Force zones are:

```
SOA     zone authority and parameters
NS      authoritative name servers
A       name → IPv4 address
CNAME   alias → canonical name
MX      mail server, with priority
PTR     address → name, in reverse zones
```

Every record has an *owner* (the name it refers to), a class (always `IN`
here) and a value. The `SOA` defines the zone serial and the
refresh/retry/expire timers; the `NS` records list the authoritative
nameservers; the `A` and `CNAME` records map names to addresses or to other
names; the `MX` records route mail.

## The `internetforce.com` zone

The recovered zone is the best example for showing the provider's
infrastructure. The full file is
[`systems/data/dns/named-data/primary/internetforce.com`](../systems/data/dns/named-data/primary/internetforce.com);
this is the beginning:

```
@  IN  SOA  dns dnsmaster.internetforce.com. (
        1996091101 ; Serial
        10800      ; Refresh 3 hours
        3600       ; Retry 1 hour
        604800     ; Expire after a week
        86400 )    ; Minimum ttl 1 day
              NS  styx.ios.com.
              NS  noc.ios.com.
              NS  harley.ios.com.
```

The `1996091101` serial places this version in September 1996. The same IOS
`NS` entries (`styx`, `noc`, `harley`) also appear in the delegation
description: they are the nameservers with which the domains were registered.
The zone identifies `dns` (206.20.95.3) and `dns2` (206.20.95.4), consistent
with the DATA primary and USERS secondary, and contains both the central hosts
and the office machines, plus `fw-data`, `fw-users`, `fw-shell`, `PcDemo` and
`oracolo`.

## Host and service names

The forward zone listed the central hosts and the office machines:

```
data      A  206.20.95.3
users     A  206.20.95.4
shell     A  206.20.95.5
firewall  A  206.20.95.129
dvlp      A  206.20.95.130
anna      A  206.20.95.131
franz     A  206.20.95.132
maxi      A  206.20.95.133
html      A  206.20.95.134
aps       A  206.20.95.135
cust2     A  206.20.95.136
isa       A  206.20.95.137
marco     A  206.20.95.140
```

Well-known aliases pointed services at the right host:

```
mailhost, mail   CNAME  users.internetforce.com.
loghost          CNAME  dvlp.internetforce.com.
ftp, proxy, www1 CNAME  data.internetforce.com.
www              CNAME  users.internetforce.com.
```

Mail routing used MX records: `internetforce.com` preferred USERS (`MX 0`)
and fell back to DATA (`MX 1`):

```
internetforce.com.  MX  0  users.internetforce.com.
                    MX  1  data.internetforce.com.
```

`loghost` pointed at DVLP because central `syslog` collected on DVLP.

## The `pippo.com` zone

`pippo.com` lets us instead follow a domain hosted by the provider from the act
of registration to the zone served by BIND. The full file is
[`systems/data/dns/named-data/primary/pippo.com`](../systems/data/dns/named-data/primary/pippo.com):

```
@  IN  SOA  pippo.com dnsmaster.internetforce.com. (
        1996092401 ; Serial
        10800      ; Refresh 3 hours
        3600       ; Retry 1 hour
        604800     ; Expire after a week
        86400 )    ; Minimum ttl 1 day
              NS  harley.ios.com.
              NS  dns.internetforce.com.
              NS  dns2.internetforce.com.
pippo.com.    MX  0  internetforce.com.
www           A   206.20.95.25
dns           A   206.20.95.3
```

A few details tie registration and configuration together:

- `harley.ios.com` appears both as the `Secondary DNS` in the 10 May 1995
  InterNIC record and as an `NS` in the zone;
- `dns.internetforce.com` and `dns2.internetforce.com` are DATA and USERS, the
  provider's authoritative nameservers;
- `MX 0 internetforce.com` forwards `pippo.com` mail to the
  `internetforce.com` zone, which then routes it to USERS/DATA;
- `www` resolves to `206.20.95.25`, the same address the reverse zone associates
  with `www.pippo.com`.

Note that the materials are **different temporal layers**: the InterNIC
registration is from May 1995, while this zone's serial is `1996092401`, from
September 1996. They are two snapshots of the same domain at distinct moments,
not a single instant.

## Reverse DNS

DNS also resolves in the opposite direction, through the `in-addr.arpa` domain
and `PTR` records:

```
name → IP       forward DNS
IP   → name     reverse DNS
```

The reverse zone covered the `206.20.95` block and its file is
[`systems/data/dns/named-data/primary/db.206.20.95`](../systems/data/dns/named-data/primary/db.206.20.95).
Besides the central hosts (`3 PTR data`, `4 PTR users`, `5 PTR shell`, etc.),
the zone reserves addresses `.20`–`.35` for the customers' virtual web sites:

```
20  PTR  www.canalemoda.com.
21  PTR  www.sicilia.com.
22  PTR  www.pesaro.com.
...
25  PTR  www.pippo.com.
...
35  PTR  www.financialreports.com.
```

Having a matching `PTR` record for every name made connection logs readable and
gave the address pools a clean naming scheme.

## Dial-up and customer records

Every dial-up terminal had a forward name and a matching PTR record:

- `ppp1-milano` … `ppp16-milano` → 206.20.95.70–85
- `ppp1-pesaro` … `ppp16-pesaro` → 206.20.115.2–17
- `ppp1-palermo` … `ppp16-palermo` → 206.20.224.2–17
- `ppp1-gorgonzola` … `ppp16-gorgonzola` → 206.20.225.2–17

## Virtual web hosts (VIF)

The reverse and forward zones reserved addresses for virtual web sites: the
`www.20` … `www.35` names mapped the customer virtual hosts that DATA served
through the VIF (virtual interface) scheme. This let many customer domains
share the DATA web server while keeping distinct addresses.

## Zone management

Zones were generated from master source files by a script (`makezones`,
version 0.10), driven by a `Makefile` that also reloaded the nameserver. A
new customer domain was added by copying an existing `.source` master,
editing it, adding a `primary` line to `named.boot`, running `makezones` and
signalling `named`. This is described in the recovered `new_dns-HOWTO`, which
also records the procedure for registering a new domain and its `le0` MAC
address with the upstream registry.

The directory also preserves a `named.boot.save`, an earlier version of the
boot file: comparing it with the current one shows how the zone portfolio
evolved, without having to fuse the two snapshots.

## The full path of `pippo.com`

Putting the steps together, the story of a hosted domain is this:

```
registration request
        │
        ▼
InterNIC / delegation
        │
        ▼
authoritative nameservers (harley.ios.com, dns/dns2.internetforce.com)
        │
        ▼
named.boot on DATA
        │
        ▼
pippo.com zone
        │
        ├── SOA
        ├── NS
        ├── MX
        └── A / CNAME
        │
        ▼
query from the Internet
```

This is the important point: DNS was not a centralized directory. Each level
delegated authority to the next, and Internet Force's local zone became part of
the Internet only after registration and delegation.

## Further reading

- [Adding a new customer domain: workflow](../systems/data/dns/DOMAIN-PROVISIONING-WORKFLOW.en.md)
  — the modern operational sequence, with the [original HOWTO](../systems/data/dns/new_dns-HOWTO.txt).
- [BIND on DATA: technical guide](../systems/data/dns/TECHNICAL.en.md) — a more
  detailed technical reference on the configurations.
- [Domain registration: InterNIC and GARR artifacts](../artifacts/domain-registration/README.en.md)
- [DNS configuration and zones (DATA)](../systems/data/dns/README.en.md)
- [DATA server](../systems/data/README.en.md)
- [Security: services and hardening](06-security.en.md)

---

See also: [Architecture overview](01-architecture.en.md) ·
[Mail](04-email.en.md) ·
[Web, FTP, news and mailing lists](05-web-news-ftp.en.md)

---

→ [Build an Internet Force POP, step by step](00-build-an-isp.en.md)
