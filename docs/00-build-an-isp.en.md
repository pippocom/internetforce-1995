[🇮🇹 Italiano](00-build-an-isp.md) · 🇬🇧 **English**

# Building an Internet Force POP, step by step

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

This is the repository's **sequential technical guide**: not a file list, but the
path along which an administrator would have built and brought up an Internet Force
POP. It starts from connectivity and Unix systems, then progressively adds access,
authentication, DNS, mail, web, FTP, security and operations, until a complete
service platform is running.

Every chapter is a **link** to the canonical document that explains it; beside it
you find the technologies involved and the kind of original material available.
Each chapter contains a **representative configuration snippet** and a link to the
full file.

The path follows the real order of the work. The **original operations manual**
for a possible future junior sysadmin is at
[`artifacts/operations-manuals/manual.md`](../artifacts/operations-manuals/manual.en.md):
read it as a first-party source alongside this guide.

> **Before the technical walkthrough:** how this craft was learned on the early
> Internet - competence, autonomy and RTFM - is told in
> [Learning the Internet](23-learning-internet-culture.en.md). It is cultural
> context, not a configuration step.

---

## 0. [Understanding the POP architecture](01-architecture.en.md)

Which machines exist and how they are connected: central site, regional POPs,
private backbone and Internet edge.

**Technologies:** Cisco, private backbone, firewall, LAN. **Evidence:**
diagrams, tkined maps, host inventory.

## 1. [Preparing a Unix host](22-unix-host-preparation.en.md)

From a freshly installed system to a useful host: identity, address, routes,
`/etc/hosts`, startup scripts and permissions.

**Technologies:** SunOS/Linux, `ifconfig`, `route`, `rc` scripts. **Evidence:**
`rc.local`, `rc.route`, `fixperms`, network files.

## 2. [Router, WAN and connectivity](16-router-and-wan.en.md)

Connecting the POP to the backbone: interfaces, addressing, serial links and the
default route to the world gateway.

**Technologies:** Cisco 2501, serial/WAN, IOS 10.2. **Evidence:** `2501.cfg`,
`rc.route`.

## 3. [Dial-up and the modem bank](02-dialup-session.en.md)

Letting the customer into the IP network through the modem bank and the access
server.

**Technologies:** Cisco 2511, US Robotics 28.8 modems, PPP. **Evidence:**
`2511.cfg`, `modem.txt`, dial-in numbers.

## 4. [Authentication (XTACACS)](10-authentication-tacacs.en.md)

Every access server queries XTACACS on USERS: a branch separate from the data
path.

**Technologies:** XTACACS, USERS. **Evidence:** `xtacacsd-conf`, `passwd`.

## 5. [DNS](03-dns.en.md)

Resolution and authoritative service: forward and reverse zones, MX, customer
domain delegation.

**Technologies:** BIND/named. **Evidence:** `named.boot`, zone files, reverse.

## 6. [Mail (Sendmail)](04-email.en.md)

SMTP transport and local delivery: MX, aliases and mailboxes.

**Technologies:** Sendmail 8.6.12, `mail.local`. **Evidence:** `sendmail.cf`.

## 7. [POP3 and mailbox access](18-pop3-and-mailbox-access.en.md)

How the customer reads delivered mail: POP3/IMAP on USERS, the `.mailbox` model.

**Technologies:** popper 1.6, imapd, `inetd`. **Evidence:** popper config.

## 8. [Web server](05-web-news-ftp.en.md#world-wide-web)

Serving the sites: DocumentRoot, virtual hosts, personal areas.

**Technologies:** NCSA HTTPd. **Evidence:** `httpd.conf`, `srm.conf`.

## 9. [Web permissions and CGI](19-web-permissions-and-cgi.en.md)

Running programs safely: CGI directories, ownership, permissions, `fixperms`.

**Technologies:** CGI, `srm.conf`, `fixperms`. **Evidence:** CGI inventory,
`fixperms`.

## 10. [Virtual hosting (VIF)](../systems/sun-vif/README.en.md)

Many sites on one Sun: virtual interfaces in the SunOS kernel.

**Technologies:** VIF, SunOS 4.1.x, `modload`. **Evidence:** VIF bundle,
`VirtualHost`.

## 11. [FTP and confinement](05-web-news-ftp.en.md#ftp)

Anonymous and authenticated FTP, `inetd → tcpd → ftpd`, `chroot`, `ftpusers`.

**Technologies:** wu-ftpd, `chroot`. **Evidence:** `ftpusers`, `ftp-world.txt`.

## 12. [Mailing lists (Majordomo)](20-mailing-lists-majordomo.en.md)

Group mail: subscriptions, approvals, distribution and archives.

**Technologies:** Majordomo on DATA, Sendmail aliases, Hypermail. **Evidence:**
Majordomo material.

## 13. [Security and hardening](06-security.en.md)

Reducing Unix to the machine's role, the firewall, `inetd`, confinement.

**Technologies:** TCP wrappers, `chroot`, firewall. **Evidence:** `inetd.conf`,
`fixperms`.

## 14. [Monitoring](08-monitoring.en.md)

Observing interfaces, links, servers and modem lines.

**Technologies:** SNMP, tkined. **Evidence:** `intf.snmp.map`, maps.

## 15. [Operations and backup](14-operations-and-backup.en.md)

Boot order, tape backup, scheduled tasks, logs, quotas.

**Technologies:** `gtar`/`dump`, cron, NTP. **Evidence:** backup scripts,
`crontab`.

## 16. [Customer provisioning](12-customer-provisioning.en.md)

From contract to account: creation, home, quota, dial-up identity.

**Technologies:** `adduser`, `edquota`. **Evidence:** `adduser`, `quota.txt`.

## 17. [Development and deploy](07-development.en.md)

Building on DVLP and releasing to production: build-and-deploy.

**Technologies:** DVLP, internal FTP, SSH/SCP. **Evidence:** `/cisco`, operational
notes.

## 18. [Putting the POP together](21-putting-the-pop-together.en.md)

How all the subsystems form one complete service, from the modem to the backbone.

**Technologies:** the whole chain. **Evidence:** synthesis of the chapters.

---

Prefer to inspect a single subsystem? Jump to
[Explore by system and infrastructure](../README.en.md) or the
[original operations manual](../artifacts/operations-manuals/manual.en.md).
