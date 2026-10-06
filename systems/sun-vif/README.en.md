[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# VIF — Virtual Interface for SunOS 4.x

> **Internet Force 1995–1996 Historical Archive**\
> Historical system component used to add multiple IP addresses to Sun machines
> running SunOS 4.1.x. The bundle was supplied to Marco Iannacone by Yahel
> Ben-David / Xpert UNIX Systems during the Internet Force work.

## Why this material is here

Internet Force had to host several Web sites on a single physical machine.

With HTTP/1.0, reliable virtual hosting normally required a different IP for each
site. SunOS 4.1.3/4.1.4 did not natively offer the IP-aliasing model that would
later appear in Solaris 2.x.

The **VIF (Virtual Interface)** package added pseudo network interfaces to the
kernel:

```text
le0      physical Ethernet
vif0     virtual address
vif1     virtual address
vif2     virtual address
...
```

Version 1.10 included in the bundle could be loaded and unloaded dynamically on
SunOS 4.1.3/4.1.4 via `modload`.

The component is not merely a software artifact: it is part of the operational
chain that made Internet Force virtual hosting possible.

## Provenance

The provenance of the Internet Force bundle is as follows:

```text
Yahel Ben-David / Xpert UNIX Systems
             ↓
       Marco Iannacone
             ↓
        Internetforce
```

Inside the package the code documents an earlier genealogy, starting from the
work of John Ioannidis and passing through public contributions on mailing lists,
Usenet and FTP.

See also: [VIF and the evolution of the network](../../docs/09-historical-notes.VIF-NETWORK-EVOLUTION.md).

## Preserved files

The technical files of the bundle are in `source/`:

```text
source/VIF-1_10.GZ
source/VIF-1_01.GZ
source/VIF_MAN.GZ
source/VIF-INFO.TXT
source/IF_VIF.C
source/VIF.RC
source/VIF.HTM
source/NCSA.HTM
source/NCSA_PAT.Z
source/VIRTUAL-.HTM
```

They keep the historical timestamps and formats of 1995.

## Contents of the bundle

### `VIF-1_10.GZ`

VIF 1.10 archive.

Contains:

```text
CHANGES
INSTALL
INSTALL.ultrix
MANIFEST
Makefile.hp
Makefile.sun
README
README.ji
if_vif.c
ifalias_hpux10.c
master.add
vif_exec
vif.h
wrapper.c
```

The README attributes the original code to **John Ioannidis** and the distributed
version to **Steinar Haug**.

1.10 declares support/testing for:

```text
SunOS 4.1.3       sun4c
SunOS 4.1.3_U1    sun4m
SunOS 4.1.4       sun4m
HP-UX 9.05        HP 700
```

and reports ports/contributions for HP-UX and Ultrix as well.

SHA-256 of the internal file:

```text
3046c574766ce06711d2b0c82169efec5663b832eab3dd7620423c0307f65b1e
```

### `VIF-1_01.GZ`

Earlier version of the package, 1.01, dated in the changelog 27 March 1995.

It is useful for following the evolution of the code up to 1.10.

### `VIF_MAN.GZ`

Documentation/technical-history archive containing:

```text
kernel.mods.sunos.txt
mip.txt
mip2.txt
```

It is not a simple man page.

It preserves messages, forwards and technical material documenting how the code
and the associated knowledge circulated on the network.

SHA-256:

```text
cc9e0dd3c7ca0fc98839873d95a0eb5b6dde46bcc380280d270d999e329c7ee2
```

### `VIF-INFO.TXT`

Condensed version of the technical explanation attributed to John Ioannidis, with
corrections for SunOS 4.1.x credited to Chuck Smoko and collected by Bob
Baggerman.

It describes:

- the problem of many IPs on a single interface;
- `vif0`, `vif1`, ... configuration;
- host routes;
- published ARP;
- original integration into the BSD/SunOS kernel.

### `IF_VIF.C`

Snapshot of the C source of the Virtual Interface driver.

It is kernel code, not a user-space utility.

### `VIF.RC`

Operational shell script that automates:

```text
modload of the module
creation of /dev/vif
attach of the VIFs
reading the MAC of le0
ifconfig vifN
route fixes
published ARP
final netstat
```

The recovered file contains placeholder names and must therefore be read as a
configuration/model script, not as the list of Internet Force production
addresses.

SHA-256:

```text
84fba75041cd977009c66863ec234adb0ab93ed430fdbcbdc9e1b0ba1401dcb0
```

### `VIF.HTM`

Practical "VIF for SunOS 4.x" instructions.

It shows a very concrete path:

```text
compile if_vif.c
      ↓
create vif.o
      ↓
adapt vif.rc
      ↓
install vif.o + vif.rc
      ↓
call vif.rc from /etc/rc.local
```

It is especially useful for the narrative documentation because it makes visible
how an administrator actually installed this capability on the system.

### `NCSA.HTM`

Document by A. P. Barrett, 10 November 1994, on the modifications to NCSA HTTPd
1.3 for multiple servers on a multihomed host.

It describes two functions:

```text
BindAddress
VirtualHost
```

and explains how `VirtualHost` chooses the configuration and `DocumentRoot` based
on the local address that received the connection.

### `NCSA_PAT.Z`

Compressed archive containing NCSA HTTPd sources with support for:

```text
APB_BIND_ADDRESS
APB_VIRTUAL_HOST
```

SHA-256:

```text
b9a9a05c9759e2a8d82817914e06e799aacb156fc201b910da5cb83be339cd86
```

### `VIRTUAL-.HTM`

Apache documentation on virtual hosting.

It explains explicitly that, because of HTTP/1.0 limitations, the server needs a
different IP for each virtual host, and cites virtual interfaces as the solution
on operating systems that support them.

This file connects the network problem well to the Web problem.

## SunOS installation documented in the bundle

The 1.10 flow is:

```text
Makefile.sun
    ↓
if_vif.c + wrapper.c
    ↓
vif.o
    ↓
modload
    ↓
/dev/vif
    ↓
attach of the pseudo interfaces
    ↓
ifconfig vifN <IP>
    ↓
host route
    ↓
published ARP
```

The `Makefile.sun` uses:

```make
CFLAGS = -O -DDETACH -DKERNEL -DINET -D`arch -k`
```

and the install target:

```make
modload vif.o -entry _vif_vdcmd -exec `pwd`/vif_exec
```

The driver therefore actually enters the SunOS kernel.

## Relationship with Internet Force

The package explains the missing piece between:

```text
DNS
→ www.pippo.com = 206.20.95.25
```

and:

```text
NCSA HTTPd
→ <VirtualHost 206.20.95.25>
```

VIF allowed the Sun to **actually own** that address despite having a single
physical Ethernet.

The complete chain was:

```text
DNS
 ↓
IP dedicated to the site
 ↓
firewall routing
 ↓
VIF on the Sun
 ↓
NCSA VirtualHost
 ↓
site DocumentRoot
```

## Note

The bundle is historical third-party/Xpert material preserved as part of the
Internet Force technical archive. The files in `source/` are kept as recovered;
any explanations or corrections live in this README.
