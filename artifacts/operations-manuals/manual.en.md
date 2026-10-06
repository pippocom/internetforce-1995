[🇮🇹 Italiano](manual.md) · 🇬🇧 **English**

# Internet Force reference site manual for junior sysad
# Author Marco Iannacone

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../LICENSE)

*Merged and reorganized from the recovered manual drafts
(`document.glob.txt`, `document.software.txt`, `GENERAL_SITE-SETUP-INFO.txt`,
`document.hardware.txt`). Credentials removed; duplicated passages collapsed.
This is a reconstruction by Marco.*

## Contents

1. Introduction
2. Computer systems configuration
3. Communication hardware
4. Network topology
5. Servers and services
6. Site management and routine tasks
7. Cisco operational FAQ
8. POP information

## 1. Introduction

This manual describes the servers, the routers and the routine procedures of
the Internet Force platform: FIREWALL, DVLP, DATA and USERS, the POP routers
and terminal servers, and the services they provide. It is the operating
reference for the system administrator.

## 2. Computer systems configuration

### FIREWALL
- Sun SPARCstation 5, 32 MB, SunOS 4.1.4.
- Five Ethernet interfaces: `qe3` world (10.0.0.1), `qe0` DATA
  (206.20.95.10), `qe1` USERS (206.20.95.11), `qe2` SHELL (206.20.95.12),
  `le0` office (206.20.95.129).
- Check Point FireWall-1, administered from the office through X11.

### DVLP
- Sun SPARCstation 4, 32 MB, SunOS 4.1.4.
- Build/development host on the office LAN. `/cisco` holds the router
  configurations. The backup tape drive is attached here.

### DATA
- Sun SPARCstation 5, 64 MB, SunOS 4.1.4.
- System disk plus three ~2 GB SCSI disks used for NEWS, HTTP and future
  capacity.

### USERS
- Sun SPARCstation 5, 64 MB, SunOS 4.1.4.
- System disk plus SCSI disks used for customer accounts and future
  capacity, with quotas.

## 3. Communication hardware

### Routers
- One central Cisco 2501 provides the Internet uplink (IOS 10.2).
- Each remote POP has a Cisco 2501 router and a Cisco 2511 access server. In
  Milano, where the central site and the POP coincide, the central/world 2501
  serves as the router and there is no separate POP 2501.
- All devices run SNMP and are monitored with tkined from Marco's
  workstation.

### Terminal server
- The access servers carry the modem banks. Lines are configured for PPP,
  interactive mode, with a per-line default customer address and central
  TACACS authentication.

## 4. Network topology

- Private backbone `10.0.0.0/8`; the World Hub (`10.0.0.254`) joins the
  central 2501, the firewall world interface, the POP routers and the UPS.
- Central servers on `206.20.95.0/26`, each behind its own firewall
  interface.
- Office LAN `206.20.95.128/25` behind the firewall office interface.
- POP dial networks `206.20.115/224/225.0/24` (and later `226`–`231`).

## 5. Servers and services

### FIREWALL
- Check Point FireWall-1 with the recovered 15-rule policy (public DNS and
  ident, access to the servers' web/mail services, TACACS from the access
  servers, administration from DVLP and marco, the news feed, Xpert support,
  and a final STOP).

### DVLP
- Development and build host. Software is built here and deployed to
  production. Web pages are tested here before release. FTP is restricted to
  the office network.

### DATA
- Primary name server.
- Anonymous FTP site (`/usr/local/ftp`, download and upload areas).
- Majordomo mailing-list server.
- Usenet news server (fed from the upstream provider).
- WWW site and virtual customer hosts (VIF).

### USERS
- Secondary name server.
- Customer home environment and personal web pages.
- FTP site for authenticated users.
- SMTP, POP3 and IMAP.
- XTACACS authentication server.

## 6. Site management and routine tasks

### Backup
Full backups use GNU `tar` to the tape on DVLP; DATA, USERS and FIREWALL are
read over the internal network. Incremental backups use `dump`. The tape is
checked with `df` first so that removable media are not captured.

### Systems startup and shutdown
Boot order: FIREWALL, DATA, USERS, then DVLP and MARCO. Shutdown is by
`shutdown`; the systems are never switched off directly.

### Users management
Accounts are created with the `adduser` script, which allocates a UID,
builds the jailed home environment, appends the real account and applies a
quota. Account removal and password resets follow the same account model.

### Quota management
Customer filesystems (`sd1c`, `sd2c`) enforce block and inode quotas, applied
with `edquota` and checked with `quotacheck`.

### HTML site management
Pages are edited, uploaded to DVLP for testing, then released to USERS
(personal pages) or DATA (customer/virtual sites).

### FTP site management
The anonymous area on DATA is download-only in `/pub` and upload-only in the
upload directory; permissions follow the classic anonymous-FTP rules.

### Majordomo management
Mailing lists on DATA are managed by mail command, with subscription approval
and HTML archives.

## 7. Cisco operational FAQ

**Add and configure a new POP.** Copy the known-good 2511 and 2501
configurations, give them the new POP's name, run the setup dialogue, set the
subnet bits (17 for the 2501, 18 for the 2511), then `write mem`. Connect the
2501 to the World Hub and load its configuration from the TFTP staging
directory.

**Change a single line parameter.** Telnet to the router, `conf t`, select
the line, change the parameter, `write mem`.

**Erase a configuration.** `write erase`, then `reload` - dangerous.

**Reach the modem/terminal server.** Initially by telnetting to the access
server's address on port 16; the final design gives each router an Ethernet
connection.

**Console access.** Use `kermit` on SunOS or `minicom` on Linux at 9600 bit/s.

**Save a configuration.** `write net`, then give the staging host and file
name.

## 8. POP information

Dial-in numbers: see
[POP telephone access](../../systems/pops/telephone-numbers.en.md).
