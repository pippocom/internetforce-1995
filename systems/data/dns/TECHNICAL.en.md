[🇮🇹 Italiano](TECHNICAL.md) · 🇬🇧 **English**

# Technical DNS: how Internet Force worked

> **Internet Force 1995--1996 Historical Archive**\
> Historical reconstruction and technical documentation based on
> original Internet Force materials preserved by **Marco Iannacone**.\
> Author and archive curator: **Marco Iannacone** · https://pippo.com

Internet Force ran its DNS on the **DATA** server (`206.20.95.3`), with
**USERS** (`206.20.95.4`) as the secondary. This page explains how the service
was configured by reading the recovered files directly: the BIND boot file, the
root hints, the `internetforce.com` and `pippo.com` zones, the reverse zone and
the relationship with domain registration.

## 1. DATA and the authoritative DNS

DATA was Internet Force's primary nameserver; USERS acted as the secondary and
was also reachable as `dns2.internetforce.com`. In the zones the two servers
appear as `dns` (`206.20.95.3`) and `dns2` (`206.20.95.4`).

In the recovered DATA configuration, `named` was started by `rc.local` as the
primary server, with the boot file passed explicitly:

``` text
if [ -d /usr/local/etc/named ]
then
	echo -n "PRIMARY NAME SERVER: "
	/usr/etc/named -b /usr/local/etc/named/named.boot
	echo done
elif [ -s /etc/named.boot ]
then
	echo -n "SECONDARY NAME SERVER: "
	/usr/etc/named
	echo done
fi
```

The `PRIMARY NAME SERVER` branch is the one DATA ran; the `elif` branch covers
the case of a secondary server, not used on DATA. The configuration file read by
`named` is [`named.boot`](named.boot).

## 2. `named.boot`: the BIND configuration

In the BIND generation used at the time the server was configured with a textual
boot file, `named.boot`; the block-structured `named.conf` belongs to later
versions and does not appear in this archive. The recovered file declares the
working directory, the root hints and the list of zones:

``` text
directory /usr/local/etc/named/named-data

; type	  domain			source host/file	backup file
cache	  .				root.cache
primary   internetforce.com  			primary/internetforce.com
primary   intf.com       			primary/intf.com
primary   pippo.com                 primary/pippo.com
primary	  internetforce.it 			primary/internetforce.it
```

and, further down the same file, the zones obtained from another server and the
main reverse zone:

``` text
secondary cnn.it			206.20.228.70 secondary/cnn.it
secondary 228.20.206.IN-ADDR.ARPA       206.20.228.70 secondary/db.206.20.228
primary   95.20.206.IN-ADDR.ARPA	primary/db.206.20.95
```

Meaning of the directives, according to the BIND documentation and the RFC
documents of the period:

- **`directory`** — the base directory used to resolve relative file names; here
  it is `/usr/local/etc/named/named-data`, so paths such as
  `primary/internetforce.com` or `root.cache` are meant relative to that
  directory.
- **`cache . root.cache`** — loads the *root hints*: the file from which `named`
  obtains the initial list of root servers (`cache` for the `.` zone).
- **`primary <zone> <file>`** — declares that this server is authoritative
  (primary/master) for the given zone and reads its data from the given file. In
  the recovered file these are `primary` `internetforce.com`, `intf.com`,
  `pippo.com`, `internetforce.it` and many other customer zones, plus the reverse
  zones `95.20.206.IN-ADDR.ARPA` and similar.
- **`secondary <zone> <master-address> <file>`** — declares a zone for which
  this server is not the master: the copy is obtained periodically from the
  indicated master server by zone transfer and kept in the backup file. In the
  recovered file this applies to `cnn.it` and its reverse zone, obtained from the
  master `206.20.228.70`.

The same pattern appears in [`named.boot.save`](named.boot.save), an earlier
variant of the boot file: it contains the same `directory`, `cache` and `primary`
directives for a partly different set of zones and without the two `secondary`
entries. It is not the active configuration but documents the evolution of the
zone list.

## 3. Root hints: how the resolver found the root

The `cache . root.cache` directive names the root-hints file. The recovered file
is [`named-data/root.cache`](named-data/root.cache):

``` text
.               99999999        IN	NS	A.ROOT-SERVERS.NET.
.		99999999	IN	NS	B.ROOT-SERVERS.NET.
.               99999999        IN	NS	C.ROOT-SERVERS.NET.
.               99999999        IN	NS	D.ROOT-SERVERS.NET.
.               99999999        IN	NS	E.ROOT-SERVERS.NET.
.               99999999        IN	NS	F.ROOT-SERVERS.NET.
A.ROOT-SERVERS.NET.	99999999	IN	A        198.41.0.4
B.ROOT-SERVERS.NET.	99999999	IN	A        128.9.0.107  ; BIND
```

The `NS` records with owner `.` list the root servers; the `A` records with the
same name give their addresses, needed so the resolver can contact those servers
without first resolving another name (the so-called *glue records*).

The TTL is a very high value, `99999999` seconds: this data only bootstrapped
resolution and was then replaced by the current root-server list obtained by
querying the root, so it was meant to stay in cache for a long time. According to
the documentation of the period, a record without an explicit TTL inherits the
zone `SOA` *minimum*, but here the TTL is given explicitly.

These are the **historical** root hints of the period: names, addresses and TTL
must be read as such and must not be updated to today's root servers. The archive
also preserves [`named-data/root.cache.orig`](named-data/root.cache.orig), an
earlier variant with the old root-server names (`ns.nic.ddn.mil.`,
`kava.nisc.sri.com.`, `aos.brl.mil.` and others), useful to show how this list
changed over time.

## 4. The `internetforce.com` zone

The main zone is [`named-data/primary/internetforce.com`](named-data/primary/internetforce.com).
It begins with `SOA` and `NS`:

``` text
@  IN	SOA	dns dnsmaster.internetforce.com. (
		1996091101	 ; Serial
		10800		 ; Refresh 3 hours
		3600		 ; Retry 1 hour
		604800		 ; Expire after a week
		86400 )	 ; Minimum ttl 1 day
				NS	styx.ios.com.
				NS	noc.ios.com.
				NS	harley.ios.com.
```

The `SOA` (*Start Of Authority*) opens the zone and defines its authoritative
parameters. According to the terminology of the documents of the period:

- **owner** `@` — the current zone (`internetforce.com.`).
- **origin / primary master** `dns` — the name of the host on which the master
  file resides; relative to the zone it means `dns.internetforce.com.`.
- **person / responsible party** `dnsmaster.internetforce.com.` — the mailbox of
  the person responsible for the zone, written with a dot instead of the at sign
  (`dnsmaster@internetforce.com`).
- **serial** `1996091101` — the zone version number, to be incremented on every
  change; the form used here is `YYYYMMDDnn`.
- **refresh** `10800` — how often, in seconds, a secondary must check with the
  primary whether the zone has changed (3 hours).
- **retry** `3600` — how long before retrying if the check fails (1 hour).
- **expire** `604800` — after how long, without managing to refresh, the
  secondary's copy must be considered expired (one week).
- **minimum** `86400` — the minimum TTL applied to records without an explicit
  TTL (one day).

The `NS` records list the authoritative nameservers for the zone. The primary
server `dns.internetforce.com` is the local master, while `styx.ios.com`,
`noc.ios.com` and `harley.ios.com` belong to the IDT upstream: they are the
authoritative nameservers declared for the zone and correspond, in part, to the
servers indicated to the registry during registration.

Below the authoritative part, the zone contains the service records:

``` text
mailhost     CNAME  users.internetforce.com.
mail     CNAME  users.internetforce.com.
loghost     CNAME  dvlp.internetforce.com.
ftp     CNAME  data.internetforce.com.
www     CNAME  users.internetforce.com.
news     CNAME  news.ios.com.
proxy     CNAME  data.internetforce.com.
dns      A  206.20.95.3
dns2      A  206.20.95.4
internetforce.com.      MX  0  users.internetforce.com.
        MX  1  data.internetforce.com.
        A  206.20.95.4
```

- **A** (*Address*) — maps a host name to an IPv4 address. Here `dns` points to
  `206.20.95.3` (DATA) and `dns2` to `206.20.95.4` (USERS). Further down the zone
  also lists the service and infrastructure hosts (`data`, `users`, `shell`,
  `firewall`, `dvlp`, `marco`, `oracolo`, …) and the dial-up pool addresses
  `pppN-<pop>`.
- **CNAME** (*Canonical Name*) — creates an alias toward a canonical name.
  `mailhost`, `mail`, `ftp`, `www`, `proxy` and `www1` are service aliases (`www`
  is an alias of `users.internetforce.com.`), while `loghost` points to `dvlp`.
  `news` is a special case, described below.
- **MX** (*Mail eXchanger*) — indicates where to deliver the domain's mail. The
  numeric value is the preference: lower = preferred. Here mail for
  `internetforce.com.` goes first to `users.internetforce.com.` (preference 0)
  and then, as an alternative, to `data.internetforce.com.` (preference 1). Lines
  without an owner repeat the previous owner (`internetforce.com.`).

A record without an explicit TTL, as in this zone, inherits it from the `SOA`
*minimum*; all names are relative to the zone except those ending with a dot.

### The `internetforce.com` zone in an earlier version

The archive also preserves [`named-data/primary/internetforce.com.old`](named-data/primary/internetforce.com.old),
an earlier version of the same zone. Its serial places it before the current
version: `1995101801` (18 October 1995) against `1996091101` (11 September 1996),
and in this copy the `SOA` gives `dns.internetforce.com.` as origin and the `NS`
records also include `dns.internetforce.com.` and `dns2.internetforce.com.`.

The most visible change concerns the news record:

- in the earlier version (`.old`): `news CNAME data.internetforce.com.` — the
  `news` name was an alias of the local DATA server;
- in the current version: `news CNAME news.ios.com.` — the `news` name points to
  the news server of the IDT upstream.

The two versions must not be merged: they describe two different moments of the
same zone. The value present in the current file is the one associated with
serial `1996091101`; the one in the `.old` file with serial `1995101801`.

### Alternative names in the recovered DNS material

The recovered zones and `/etc/hosts` tables also label some office addresses with
additional or alternative names, including `aps`, `cust2` and `isa`. These are a
**historical naming layer** present in the configuration material; they do not
replace the reader-facing nomenclature of the reconstruction. See the
[office LAN README](../../office-lan/README.en.md) and
[People, machines and workflows](../../../docs/15-people-and-workflows.en.md).

## 5. The `pippo.com` zone

The domain `pippo.com` was hosted on the same DNS. The recovered zone is
[`named-data/primary/pippo.com`](named-data/primary/pippo.com):

``` text
@  IN	SOA	pippo.com dnsmaster.internetforce.com. (
		1996092401	 ; Serial
		10800		 ; Refresh 3 hours
		3600		 ; Retry 1 hour
		604800		 ; Expire after a week
		86400 )	 ; Minimum ttl 1 day
				NS	harley.ios.com.
				NS	dns.internetforce.com.
				NS	dns2.internetforce.com.
pippo.com.      MX  0  internetforce.com.
www      A  206.20.95.25
dns      A  206.20.95.3
```

The same record readings seen for `internetforce.com` apply: `SOA` with serial
`1996092401`, three `NS` (the upstream secondary `harley.ios.com` and the two
Internet Force servers `dns`/`dns2`), an `MX` that forwards the domain's mail to
`internetforce.com.`, and the `A` records for `www` (`206.20.95.25`) and `dns`.

The link with the registration process is direct: `pippo.com` is the domain whose
InterNIC registration and delegation are documented in the preserved exchanges.
The local zone and the registry record are two sides of the same procedure; the
relationship is described in section 8.

## 6. Reverse DNS: `206.20.95.in-addr.arpa`

Reverse resolution (from address to name) is handled by the zone
[`named-data/primary/db.206.20.95`](named-data/primary/db.206.20.95), declared in
`named.boot` as `primary 95.20.206.IN-ADDR.ARPA`. After `SOA` and `NS`, the zone
contains `PTR` records:

``` text
3      PTR  data.internetforce.com.
4      PTR  users.internetforce.com.
5      PTR  shell.internetforce.com.
129      PTR  firewall.internetforce.com.
130      PTR  dvlp.internetforce.com.
```

- **`in-addr.arpa`** is the special domain used for reverse resolution of IPv4
  addresses. The address octets are reversed: the address `206.20.95.3` becomes
  the name `3.95.20.206.in-addr.arpa`, and the zone `206.20.95.in-addr.arpa`
  covers the network `206.20.95.0/24`. That is why the records have short owners
  (`3`, `4`, `129`): they are relative to the reverse zone.
- **PTR** (*Pointer*) — points from the reverse name to the host's canonical name.
  Here `3` → `data.internetforce.com.`, `4` → `users.internetforce.com.`, and so
  on.

The relationship with forward DNS is complementary: an `A` record translates a
name into an address, a `PTR` record translates that address into a name. The
recovered reverse zone covers the service and infrastructure hosts; other
sections of the same file also contain the `PTR` records of the virtual sites
(`www.canalemoda.com.`, `www.pippo.com.`, …) and of the dial-up pools. Not every
`A` record in the forward zones necessarily has a matching `PTR`: the
correspondence must be read case by case in the recovered files.

## 7. Primary and secondary

A domain is served by more than one nameserver to guarantee reachability. The
**primary** (master) keeps the reference copy of the zone; the **secondary**
(slave) keeps a copy that it refreshes periodically by asking the master (the
*zone transfer*, `AXFR`). The `SOA` `refresh`, `retry` and `expire` parameters
govern exactly this mechanism: how often the secondary checks, how long before
retrying, and after how long its copy expires if it cannot refresh.

In DATA's `named.boot` the master role is declared with `primary` for the
Internet Force zones and for the hosted ones, while two zones are obtained from
another server with `secondary`:

``` text
secondary cnn.it			206.20.228.70 secondary/cnn.it
secondary 228.20.206.IN-ADDR.ARPA       206.20.228.70 secondary/db.206.20.228
```

Here `cnn.it` and its reverse zone are not mastered by DATA: the copy is
transferred from the server `206.20.228.70` (`cnn-server.cnn.it`) and kept under
`named-data/secondary/`. This is the evidence, in the recovered file, of
secondary behaviour according to the BIND syntax of the period.

As for USERS as Internet Force's secondary, the surviving documentation
identifies it as `dns2.internetforce.com` and the `NS` records list it as an
authoritative nameserver; however, **no `named.boot` configuration for USERS was
recovered**, and the `named` startup block in USERS' `rc.local` is commented out.
The secondary role is therefore documented by the zones and the `NS` references,
but USERS' complete secondary configuration is not available in the archive, and
none is reconstructed here. Likewise, for the recovered `secondary` zones no
configuration with zone-transfer parameters or restrictions survives: the
preserved material shows the boot file's `secondary` syntax, not any transfer
ACLs.

## 8. From registration to DNS delegation

The local zone configuration and domain registration were two parts of the same
operational process. For a domain to resolve, the registry had to delegate it to
the authoritative nameservers, and those nameservers had to be configured and
working. The archive preserves both sides.

### `.com` / `.net` domains — InterNIC and IDT

For international domains the request went to **InterNIC/Network Solutions**; the
procedure and templates are documented in
[Domain registration — `.com`/`.net`](../../../artifacts/domain-registration/domini_com_net.txt)
and in the preserved exchanges. The role of the **IDT** upstream (Internet Online
Services) is that of secondary nameserver: in the preserved emails IDT provided
the secondary `harley.ios.com`, which indeed appears among the `NS` records of
the `internetforce.com` and `pippo.com` zones.

Related original material:

- [Domain registration (index)](../../../artifacts/domain-registration/README.md);
- [`DOMAIN.mailbox`](../../../artifacts/email-archive/technical/DOMAIN.mailbox) — InterNIC notifications and templates (`pippo.com`, `shiseidoit.com`);
- [`DOMAIN-IDT.mailbox`](../../../artifacts/email-archive/technical/DOMAIN-IDT.mailbox) — `.com` registrations and requests to IDT for the secondary;
- [`IDT.mailbox`](../../../artifacts/email-archive/technical/IDT.mailbox) — further exchanges with IDT.

### `.it` domains — GARR / Registry

For Italian domains the request followed the route of **GARR-NIS**, the service
that managed the `.it` registry at the time. The procedure and the data required
are documented in
[Registration of `.it` domains](../../../artifacts/domain-registration/domini_it.txt);
the GARR exchanges document the submission of the request, the checks and the
registration.

Related original material:

- [`GARR-DOMINI_IT.mailbox`](../../../artifacts/email-archive/technical/GARR-DOMINI_IT.mailbox) — `.it` registrations with GARR-NIS;
- [`ITALIAN_POSTMAST.mailbox`](../../../artifacts/email-archive/technical/ITALIAN_POSTMAST.mailbox) — GARR postmaster list.

The overall path, top to bottom, was:

``` text
domain request
      ↓
registration / delegation correspondence (InterNIC or GARR)
      ↓
declaration of the authoritative nameservers
      ↓
local BIND configuration (named.boot + zones)
      ↓
zone records (SOA, NS, A, MX, CNAME, PTR)
```

This is where the administrative procedure and the technical DNS implementation
met: the same pair of nameservers indicated to the registry appears as `NS`
records in the local zone.

## 9. Complete original configurations

Recovered configuration files and zones:

- boot file: [`named.boot`](named.boot) and the variant [`named.boot.save`](named.boot.save);
- main `internetforce.com` zone: [`named-data/primary/internetforce.com`](named-data/primary/internetforce.com) and the earlier version [`named-data/primary/internetforce.com.old`](named-data/primary/internetforce.com.old);
- `pippo.com` zone: [`named-data/primary/pippo.com`](named-data/primary/pippo.com);
- main reverse zone: [`named-data/primary/db.206.20.95`](named-data/primary/db.206.20.95);
- root hints: [`named-data/root.cache`](named-data/root.cache) and the variant [`named-data/root.cache.orig`](named-data/root.cache.orig);
- secondary-zone material: [`named-data/secondary/`](named-data/secondary/) (`cnn.it`, `db.206.20.227`, `db.206.20.228`, `tera-it.com`);
- primary-zone directory: [`named-data/primary/`](named-data/primary/).

No `named.boot` configuration for USERS is available: the secondary role is
documented by the zones and the `NS` records, not by a surviving configuration
file.

## 10. Historical technical references

For the meaning of the BIND directives and DNS records this page refers to the
historical documentation of the period:

- **RFC 1033**, *Domain Administrators Operations Guide* (M. Lottor, November
  1987), <https://www.rfc-editor.org/rfc/rfc1033.txt> — BIND boot-file format
  (`cache`, `primary`), root-hints file, and the semantics of the `SOA`, `NS`,
  `A`, `CNAME`, `MX`, `PTR` records and of the `IN-ADDR.ARPA` domain.
- **RFC 1034**, *Domain Names — Concepts and Facilities* (P. Mockapetris,
  November 1987), <https://www.rfc-editor.org/rfc/rfc1034.txt> — zones,
  authority, delegation, primary/secondary nameservers and zone transfer.
- **RFC 1035**, *Domain Names — Implementation and Specification* (P.
  Mockapetris, November 1987), <https://www.rfc-editor.org/rfc/rfc1035.txt> —
  record definitions and the DNS message format.

The Internet Force configuration files and zones remain the primary source for
what the provider actually configured; the documents above serve to explain the
meaning of the directives and records.

## Continue exploring

-   [DNS](README.en.md) and [the DNS narrative](../../../docs/03-dns.en.md)
-   [Domain registration InterNIC/GARR](../../../artifacts/domain-registration/README.en.md)
-   [Unix and host configuration](../../../docs/01-architecture.en.md)
