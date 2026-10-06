[🇮🇹 Italiano](05-web-news-ftp.md) · 🇬🇧 **English**

# Web, FTP, news and mailing lists

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

This page covers the public information services of the provider. The main split was:
**DATA** hosted the public, mostly read-only services (anonymous FTP, Usenet
news, mailing lists and customer virtual web sites), while **USERS** hosted
per-customer web space and mail. Both are described in their system READMEs.

As well as reconstructing what ran on which host, this page explains the
mechanisms for which in 1995 I wanted to create the documentation by hand that would explain them: what a daemon is, how a
service listens on a port, why a web server drops its privileges, and how a
single Ethernet card could serve dozens of different domains. The centrepiece
is **VIF-based virtual hosting**, the point where the network and the Web meet.

## World Wide Web

### What a web server actually does

A **daemon** is a program that runs in the background, with no terminal
attached, waiting to do a job. A web server is a daemon that waits for network
connections. In practice it repeats the same cycle forever:

```text
listen on a TCP port
      ↓
receive an HTTP request
      ↓
find the requested file
      ↓
return it to the browser
```

A **TCP port** is a number that identifies a service on a machine: the browser
knows that for the Web it must talk to port 80. NCSA HTTPd's main configuration
file described exactly this:

### ORIGINAL RECOVERED — USERS `httpd.conf`

```conf
ServerType standalone

Port 80

User nobody
Group #-1

ServerRoot /usr/local/etc/httpd

ErrorLog logs/error_log
TransferLog logs/access_log

ServerName www.internetforce.com
```

(DATA's `httpd.conf` is almost identical, with `Group nogroup` and
`ServerName www1.intf.com`.)

- **`ServerType standalone`** says HTTPd stays running on its own. A service can
  instead be **launched by `inetd`** only when a connection arrives: the same
  program, two different execution models. The Web was `standalone`; FTP, as we
  shall see, was `inetd`.
- **`Port 80`** is the TCP port on which the HTTP request arrives.
- **`User nobody` / `Group #-1`** (or `nogroup`) say to drop privileges.
  Opening a port below 1024 requires starting as `root`, but the ordinary work
  is then done under an almost powerless account. It is a fundamental rule: a
  service exposed to the Internet must not have more privileges than strictly
  necessary.
- **`ServerRoot`** is the base directory of the installation; **`ErrorLog`** and
  **`TransferLog`** record errors and received requests respectively. Even today,
  running a web server means living in these two logs.

Files: [`systems/data/web/httpd.conf`](../systems/data/web/httpd.conf) ·
[`systems/users/system/httpd/httpd.conf`](../systems/users/system/httpd/httpd.conf)

### DocumentRoot and CGI

A second file, `srm.conf`, defined the content structure:

### ORIGINAL RECOVERED — DATA `srm.conf`

```conf
DocumentRoot /usr/local/etc/httpd/htdocs
UserDir public_html
DirectoryIndex welcome.html index.html

Alias /icons/ /usr/local/etc/httpd/icons/
ScriptAlias /cgi-bin/ /usr/local/etc/httpd/cgi-bin/
```

- **`DocumentRoot`** is the directory that corresponds to the site root: a
  request for `/manual.html` is looked up as
  `/usr/local/etc/httpd/htdocs/manual.html`.
- **`UserDir public_html`** enables each account's personal space (`/~user/`).
- **`DirectoryIndex`** lists the names tried automatically when a directory is
  requested.
- **`Alias`** maps part of the URL onto a different directory.
- **`ScriptAlias`** identifies the **CGI** directory: programs there are not
  returned as files but **executed** by the server to generate the response
  dynamically. In 1995 much of the dynamic Web worked exactly like this.

The rest of the configuration completed the picture: `access.conf` governed
directory permissions (with `allow`/`deny`), `mime.types` mapped filename
extensions to MIME types, `defa_srm.conf` served a custom error page
(`ErrorDocument 404 /errore.html`) and `imagemap.conf` listed clickable-image
maps. Besides CGI, NCSA HTTPd could serve files with **server-side includes**
(`.shtml`).

Files: [`systems/data/web/srm.conf`](../systems/data/web/srm.conf) ·
[`systems/data/web/access.conf`](../systems/data/web/access.conf) ·
[`systems/data/web/mime.types`](../systems/data/web/mime.types) ·
[`systems/users/system/httpd/srm.conf`](../systems/users/system/httpd/srm.conf) ·
[`systems/users/system/httpd/access.conf`](../systems/users/system/httpd/access.conf) ·
[`systems/users/system/httpd/defa_srm.conf`](../systems/users/system/httpd/defa_srm.conf) ·
[`systems/users/system/httpd/imagemap.conf`](../systems/users/system/httpd/imagemap.conf)

### The launch server, and the move to Apache

At launch the web server was **NCSA HTTPd** (version 1.4/1.5), the reference
Unix web server before Apache. It ran on two hosts:

- **USERS** — the main `www.internetforce.com` site and customer personal
  pages, in each account's `public_html` directory. A `/tools/` CGI area
  provided common functions such as a page counter and advertising banners.
- **DATA** — `www1.intf.com` and some of the customer virtual sites.

As the web grew, **Marco replaced NCSA HTTPd with Apache**, which had emerged
as the new reference Unix web server. The Xpert reference material in the
archive includes an early Apache configuration tree (Apache 1.1), which was one
of the references used at the time. The migration is part of the 1996
evolution.

### Web experimentation: VRML

Internet Force's Web work was not limited to conventional page creation and
hosting. It also included experiments with then-emerging technologies: a
contemporary *Internet & Musica* article shows a section implemented in
**VRML** (Virtual Reality Modeling Language), one of the early Italian
experiments with three-dimensional Web environments.

This was **1995-96**, almost a decade before Second Life: a small but telling
example of the technical curiosity and expertise Internet Force applied not only
to network infrastructure, but also to exploring new forms of Web experience.

→ Context and artifact:
[`artifacts/press/internet-e-musica-provider-review/`](../artifacts/press/internet-e-musica-provider-review/README.en.md)
([original scan](../artifacts/press/internet-e-musica-provider-review/internet-e-musica-internet-force.pdf)).

## Virtual web hosting (VIF)

### The problem: one machine, many domains

Internet Force hosted many customer domains on a small number of machines. Today
it is normal for dozens of sites to point at the same IP address; in 1995 it
was not. The early HTTP implementations could not know for certain **which DNS
name the browser had used** to reach the server, so the reliable method was to
give each site its own IP address, even if all those addresses physically ended
up on the same Sun.

The Apache documentation preserved in the Xpert bundle states it directly:

```text
Due to limitations in the HTTP/1.0 protocol, the web server must have a
different IP address for each virtual host.
```

Hence a chain of problems that had to be solved one after another.

### First step: DNS

For `pippo.com` the DNS had to say:

```dns
www      A  206.20.95.25
```

Each site had its own address. The archive preserves the complete sequence:

```text
206.20.95.20  www.canalemoda.com
206.20.95.21  www.sicilia.com
...
206.20.95.25  www.pippo.com
...
206.20.95.35  www.financialreports.com
```

DNS thus solves the **name** problem, but not yet the machine problem: does the
Sun really own all those addresses?

Files: [`pippo.com`](../systems/data/dns/named-data/primary/pippo.com) ·
[`db.206.20.95`](../systems/data/dns/named-data/primary/db.206.20.95)

### Second step: VIF gives the Sun many addresses

The machine had a **single physical Ethernet interface, `le0`**, but had to
answer as if it had many. On **SunOS 4.1.3/4.1.4** there was no native IP-aliasing
model of the kind that would later appear in Solaris 2.x.

The solution that **Yahel Ben-David of Xpert UNIX Systems** passed to Marco was
a package called **VIF, Virtual Interface**: kernel code that added new logical
interfaces to the networking stack.

```text
le0      ← physical Ethernet (a single MAC address)

vif0     ← virtual IP interface
vif1     ← virtual IP interface
vif2     ← virtual IP interface
...
```

From the point of view of the IP protocols, `vif0` and `vif1` behaved like real
interfaces, to which an address could be assigned with `ifconfig`. Version 1.10
preserved in the bundle sums it up like this:

```text
This code lets you have multiple IP addresses for a single interface.
```

The bundle is **original**; its full description, provenance and contents are in
[`systems/sun-vif/README.md`](../systems/sun-vif/README.en.md), which is the
authoritative source. Here we take only the minimum needed to understand the
web hosting.

### What a loadable kernel module is, and what `modload` does

A **loadable kernel module** is compiled code that can be inserted into an
already-running kernel, without rebuilding and reinstalling the whole operating
system. The command that loads it is `modload`.

John Ioannidis's original code, in its first form, instead required modifying
the kernel configuration (`pseudo-device vif4`) and rebuilding the kernel. The
version that reached Internet Force, cleaned up by Steinar Haug, compiled into a
module `vif.o` and was loaded dynamically:

### ORIGINAL RECOVERED — `Makefile.sun` (VIF bundle)

```make
CFLAGS = -O -DDETACH -DKERNEL -DINET -D`arch -k`

all:	vif.o

vif.o:	if_vif.o wrapper.o
        ld -o vif.o -r if_vif.o wrapper.o

install: vif.o
        modload vif.o -entry _vif_vdcmd -exec `pwd`/vif_exec
```

The decisive part is `-DKERNEL`: we are compiling **code intended for the
kernel**, not an ordinary program. The `install` target loads the module and
immediately afterwards runs `vif_exec`.

### `/dev/vif` and the `vifN` interfaces

### ORIGINAL RECOVERED — `vif_exec` (VIF bundle)

```sh
rm -f /dev/vif
mknod /dev/vif c $4 0
echo > /dev/vif
netstat -ian
```

- **`/dev/vif`** is a **device file**: the contact point between user space and
  the driver just loaded into the kernel.
- **`mknod`** creates that device; writing to it (`echo > /dev/vif`) opens the
  driver and **attaches** the virtual interfaces.
- After the attach, `netstat -ian` shows `le0`, `lo0` and the new `vif0`,
  `vif1`, `vif2`… The VIFs exist, but they do not have an address yet.

### `ifconfig`, host route and published ARP

Addresses are assigned with the ordinary `ifconfig`. The recovered `VIF.RC`
script automates the whole operation:

### ORIGINAL RECOVERED — `VIF.RC` (VIF bundle)

```sh
ETH_ADDR=`ifconfig le0 | awk '/ether/ { print $2 }'`
N=0; export N
for VIF_HOST in $VIF_HOSTS; do
        ifconfig vif$N $VIF_HOST up
        for BAD_ROUTE in `netstat -r | awk '/vif'$N'/ { print $1 }'`; do
                route delete $BAD_ROUTE $VIF_HOST
        done
        route add host $VIF_HOST $VIF_HOST 0
        arp -s $VIF_HOST $ETH_ADDR pub
        N=`expr $N + 1`
done
```

- **`ifconfig vifN <IP> up`** assigns the address to the virtual interface and
  brings it up.
- **`route add host ...`** is the **host route**. A VIF does not represent a new
  Ethernet cable: we only want to say "this single address belongs to this
  machine", not "the whole network of that address is reachable through
  `vif0`". `ifconfig` tends to create a spurious network route as well, which
  the script deletes.
- **ARP** is the protocol by which, on Ethernet, one asks "who owns IP address
  X?" and receives a **MAC address** in reply. The problem is that only `le0`
  physically exists on the network, with a single MAC. The script reads that
  MAC and then publishes a **static** ARP association for every virtual address
  (`arp -s ... pub`): thus the Sun answers ARP requests for all its IPs while
  having a single card.

```text
206.20.95.25 ─┐
206.20.95.26 ─┤
206.20.95.27 ─┼──> same MAC address as le0
...           ─┘
```

The recovered `VIF.RC` contains placeholder names (`myhost-vif0`,
`myhost-vif1`): it is the package's original script, not the Internet Force
operational list of the `.20–.35` addresses.

### Surviving a reboot: `rc.local`

Configuring the VIFs by hand would have lasted only until the next reboot. The
bundle's `VIF.HTM` document shows the practical procedure for SunOS 4.x:

```sh
install -m 0755 vif.o vif.rc /etc
echo /etc/vif.rc >> /etc/rc.local
```

`/etc/rc.local` is the startup script SunOS runs at the end of boot. By adding
`vif.rc` to it, every reboot repeats the whole sequence: `modload`, creation of
`/dev/vif`, attach of the `vifN`, `ifconfig` of the IPs, host routes, published
ARP. At that point the machine is ready once more to answer on all its virtual
addresses.

### The network side: the firewall

It is not enough for the Sun to know how to answer: the router/firewall must
also know **where** to send traffic directed at those addresses. The `rc.route`
file assigns each virtual IP to the right segment:

### ORIGINAL RECOVERED — `rc.route`

```sh
route add host data fw-data 0
route add host 206.20.95.20 fw-data 0
route add host 206.20.95.29 fw-data 0
route add host 206.20.95.32 fw-data 0
route add host 206.20.95.33 fw-data 0
...
route add host users fw-users 0
route add host 206.20.95.25 fw-users 0
...
```

IPs `.20`, `.29`, `.32`, `.33` are routed to **DATA**, while the majority
(`.21–.28`, `.30`, `.31`) go to **USERS**. This also explains why the virtual
sites were **split between the two servers**: the NCSA configurations match this
partition exactly.

File: [`rc.route`](../systems/firewall/network/rc.route)

### NCSA VirtualHost: choosing the site by destination IP

The packet now arrives at the right Sun and the right address; HTTPd must still
work out **which directory to serve**. NCSA HTTPd used `<VirtualHost IP>`
sections for this:

### ORIGINAL RECOVERED — the `www.pippo.com` site (USERS)

```conf
<VirtualHost 206.20.95.25>
ServerName www.pippo.com
ServerAdmin webmaster@internetforce.com
ResourceConfig conf/defa_srm.conf
DocumentRoot /usr/local/etc/httpd/htdocs/ianna/
ErrorLog logs/pippo.error_log
TransferLog logs/pippo.access_log
</VirtualHost>
```

The mechanism, described in `NCSA.HTM`, is simple: when a connection arrives,
the server uses `getsockname()` to find out **on which local address** it
arrived, looks that address up in a table and applies `ServerName`,
`ServerAdmin` and `DocumentRoot` accordingly. The Xpert bundle also contains
the `NCSA_PAT.Z` sources compiled with
`-DAPB_BIND_ADDRESS -DAPB_VIRTUAL_HOST`.

The virtual sites therefore live in the real configurations:
`www.art-diary.com`, `www.sicilia.com`, `www.pesaro.com`, `www.creo-mi.com`,
`www.pippo.com` and others on USERS; `www.canalemoda.com`, `www.shiseidoit.com`,
`www.nassetti.com`, `www.net-pool.com` on DATA. The chain, now complete, is:

```text
www.pippo.com
      ↓ DNS A record
206.20.95.25
      ↓ firewall routing (fw-users)
Sun USERS
      ↓ VIF 206.20.95.25
NCSA <VirtualHost 206.20.95.25>
      ↓
/usr/local/etc/httpd/htdocs/ianna/
```

It is the kind of mechanism that today a hosting panel hides behind an "Add
domain" button. In 1995 every layer had to be built.

A concrete, inspectable example is the snapshot of the personal site
[`pippo.com` of 1997](../systems/marco/personal-web/pippo.com-1997/README.en.md):
it preserves the historical `VirtualHost` for `www.pippo.com`, the CGI counter
served from `pointest.com` (the domain associated with the Gorgonzola POP,
initially hosted on DATA) and the personal `/~ianna/` path.

In the operational flow, static customer content was uploaded to DATA and
personal pages to USERS; pages were always tested on DVLP before release. DATA
also mirrored at least one external site (the Areacom “annabella” pages) with a
scheduled `webcopy` job, and ran regular statistics jobs.

### What is original and what is reconstructed

It is important not to confuse the two levels:

- The **VIF bundle is original**: it includes `VIF-1_10.GZ`, `VIF.RC`,
  `VIF.HTM`, `/dev/vif`, `Makefile.sun`, `NCSA.HTM`, `NCSA_PAT.Z`. The excerpts
  on this page come from there. See
  [`systems/sun-vif/`](../systems/sun-vif/README.en.md).
- The **VIF startup script actually used in production by Internet Force was not
  recovered**. The surviving `VIF.RC` is the package's model script, with
  placeholder names: it is not the `.20–.35` list.
- The SunOS `ifconfig`/route sequence above is therefore the **package
  procedure**, not an Internet Force operational file. We will not present a
  reconstruction as if it were an original.

### Epilogue: the operating system absorbs the function

The VIF 1.10 README contains a historically notable note:

```text
Solaris 2.x: You don't need vif,
since the operating system already has the necessary functionality.
```

with the syntax `ifconfig IF:N ip-address up`, adding however that the feature
was **undocumented and not officially supported**. What on SunOS 4.1.x required
external kernel code, compilation and `modload` was already native in the next
generation. We cannot deduce from this that Solaris copied VIF, but we can
directly observe the evolution of the problem. The full story of that
circulation of code is in
[`09-historical-notes.VIF-NETWORK-EVOLUTION.md`](09-historical-notes.VIF-NETWORK-EVOLUTION.md)
(in Italian).

## FTP

### Public, authenticated and confined

Before the Web became the universal way to distribute files, **FTP, File
Transfer Protocol**, was one of the fundamental tools of the Internet: it let
you connect to a server, browse directories and transfer files. An ISP could
use it in three ways, often together:

```text
anonymous FTP
→ public access with no personal account

authenticated FTP
→ login with real credentials

chrooted / guest FTP
→ authenticated access but confined to part of the filesystem
```

Internet Force used **wu-ftpd**. On DATA the anonymous area lived under
`/usr/local/ftp`, with a **download-only** `/pub` tree (files world-readable but
directories not writable by the public) and a separate **upload-only**
directory (where files could be deposited but not read back). USERS provided
ordinary authenticated FTP, so that each customer could upload their own pages.
DVLP allowed FTP only from the office network, for testing.

### `inetd` → `tcpd` → `ftpd`

Unlike the Web, FTP did not listen on its own. The line recovered from
`inetd.conf` describes a small chain of programs:

### ORIGINAL RECOVERED — USERS `inetd.conf`

```conf
#   Wu-ftpd for anonymous and/or real (chrooted) FTP access.
ftp	stream	tcp	nowait	root	/usr/etc/tcpd	/usr/local/etc/ftpd
```

```text
TCP connection on the FTP port
        ↓
inetd
        ↓
tcpd
        ↓
/usr/local/etc/ftpd (wu-ftpd)
```

- **`inetd`** is the *super-server*: it listens for many services and starts the
  appropriate program only when a connection arrives.
- **`tcpd`** is the security wrapper (TCP wrappers): before starting the real
  daemon it applies access control and logging.
- **`ftpd`** is the actual FTP server.

File: [`inetd.conf`](../systems/users/system/inetd.conf)

### Why `ftpd` might not appear in `ps`

Because `ftpd` is created by `inetd` only at connection time, there was no need
to see an `ftpd` process running continuously: seeing `inetd` waiting was
enough. This is an important practical difference when reading the process list
of a machine from that era.

### `ftpusers`: excluding system accounts

FTP must not accept any account present in `/etc/passwd`. Internet Force kept a
`ftpusers` deny-list:

### ORIGINAL RECOVERED — `ftpusers`

```text
root
nobody
daemon
sys
bin
uucp
news
majordomo
operator
```

The published list (identical on FIREWALL, DATA and USERS) is at
[`systems/users/system/ftpusers`](../systems/users/system/ftpusers).

If an account appears here, it cannot be used to log in over FTP. The most
obvious case is `root`: allowing a direct FTP login as root would have been an
enormous risk. In general, service accounts have too much power to be admitted
to "just" FTP.

### What `chroot` changes

Suppose we want to give a customer FTP access to a directory of their own. The
naive solution - a normal Unix login - would show them the machine's entire
filesystem. The safer approach is to make a subdirectory look as if it were
**the whole filesystem**: this is the principle of **chroot**.

```text
normal view                   after chroot
/                             /
├── bin                       ├── etc
├── etc                       ├── bin
├── usr          ────>        ├── home
├── var                       └── ftp-world
└── users
```

The confined process normally sees nothing above that point. It is not a modern
container nor a perfect sandbox, but it is a very effective way to reduce what a
service or account can reach.

### `guestgroup` and a real Internet Force case

The `ftp-world.txt` file documents a guest account with this home:

### ORIGINAL RECOVERED — `ftp-world.txt`

```text
/users/01/segir/./ftp-world:/ftponly
```

The syntax has a precise meaning: the part before `/./` is the **chroot root**
(`/users/01/segir`), the part after it is the **initial directory** after login
(`/ftp-world`). The same document records a real `ftpaccess` directive:

```conf
guestgroup users www world
```

The members of the listed groups are treated as **guests** and confined to the
expected hierarchy. This is one of the clearest pieces of evidence that
confinement applied **also to user accounts**, not only to the FTP process. The
complete original operational note (with the customer identifiers removed) is
at [`systems/users/system/ftp-world.txt`](../systems/users/system/ftp-world.txt).
The complete Internet Force `ftpaccess` file has not survived: we show only the
attested directive, without inventing the rest.

### Why the jail needs its own `passwd` and `group`

If the process sees a new `/`, then `/etc/passwd` is no longer the machine's
real file either. For this reason FTP jails contained small local files:

```text
/usr/localftp/etc/passwd
/usr/localftp/etc/group
```

The archive preserves interventions on their owners and permissions. It is a
very instructive detail: a chroot jail was not a magic feature to switch on. One
had to **build a small coherent filesystem** - directories, files, owners and
permissions - for the service to live in.

### Chroot, restricted shell and "FTP-only" shells

User confinement did not end with FTP alone. Other finds document accounts with
limited shells (`/bin/nosh`, `/bin/lynx`) and a tcsh/restricted-shell solution.
The techniques are different and were often combined:

```text
chroot
    → limits the visible part of the filesystem

restricted shell
    → limits the commands and behaviour of the session

/ftponly or /bin/nosh
    → prevents or restricts the normal interactive login
```

The `/ftponly` shell in the example account exists for exactly this: it signals
that the account is not meant to open an interactive Unix shell, but only for a
controlled use (FTP, or a menu). This is why an "FTP-only" shell exists: to
distinguish a service account from a login account.

### What we must not infer

Confinement did not depend on a single mechanism and must not be generalised
beyond the evidence. We have no equivalent finds proving an operational chroot
for every main daemon (BIND, Sendmail, NCSA HTTPd, XTACACS, POP3/IMAP). For NCSA
HTTPd, for example, the recovered file shows execution as an unprivileged user
(`User nobody`), which is a privilege reduction but does **not** by itself prove
a chroot. The correct formulation is:

> Internet Force applied the principle of confinement to both services and user
> accounts, using chroot where appropriate and combining it with restricted
> shells, unprivileged accounts, Unix permissions, tcp_wrappers and network
> policy.

## Usenet news

DATA operated the Usenet news service. News articles were fed from the upstream
provider's server at `news.ios.com`, which is also why the
`news.internetforce.com` name resolved to that server for reading clients.
Rule 12 of the FireWall-1 rule base records the feed explicitly
(`news.ios.com -> data : nntp`). Customers read news over NNTP after
establishing their dial-up session.

## Mailing lists

Majordomo, running on DATA, provided the mailing-list service. The recovered
aliases show the lists `intf-list`, `coach`, `marketing-l` (with a digest
edition) and `cosmo-answer`. Each list had the usual Majordomo aliases for
subscription, approval, requests and archive, and subscriptions were approved
by mail command. List archives were converted to HTML with a Hypermail-based
flow. Customer and staff procedures for subscribing and removing addresses
survive in the recovered training material.

## Later additions

In 1996 the environment gained a **CERN httpd 3.0 caching proxy** (a separate
Unix host acting as an HTTP cache for the network) and, as an experiment, a web
server running on Windows NT with an Oracle back end. The proxy is described in
the software inventory and the security page.

---

See also: [DATA server](../systems/data/README.en.md) ·
[USERS server](../systems/users/README.en.md) ·
[VIF — Virtual Interface for SunOS 4.x](../systems/sun-vif/README.en.md) ·
[Software inventory](11-software-inventory.en.md)

---

→ [Build an Internet Force POP, step by step](00-build-an-isp.en.md)
