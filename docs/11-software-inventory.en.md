[🇮🇹 Italiano](11-software-inventory.md) · 🇬🇧 **English**

# Software inventory

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

This is the software list we know to have been in use at Internet Force,
with the versions saved in the archive (when we found them in the backups).
It is organized by layer.

A note on terminology: in 1995 the phrase "open source" did not yet exist
(even though GPL and MIT licences were spreading), and the distribution terms of these packages varied. Internet Force used the
UNIX/Internet model of public protocol standards and freely distributable
network software, downloading and building it locally.

## Operating systems and firmware

| Software | Version | Where |
|---|---|---|
| SunOS | 4.1.4 | FIREWALL, DATA, USERS, DVLP |
| Linux (Slackware-era) | — | Marco's workstation |
| Cisco IOS | 10.2 / 10.3 | 1995 routers (uplink and initial POPs) |
| Cisco IOS | 11.0 | 1996 POPs (Tera, CNN, Fano, INDI) |

## Network services

| Software | Version | Role |
|---|---|---|
| Check Point FireWall-1 | 2.0a | central firewall |
| BIND / `named` | BIND 4 | primary DNS on DATA, secondary on USERS |
| `makezones` | 0.10 | zone generation and serial bumping |
| Sendmail | 8.6.12 | SMTP on DATA and USERS (built Sep 1995) |
| `mail.local` | SunOS | local mail delivery on USERS |
| Berkeley `popper` | 1.6 | POP3 service on USERS |
| `imapd` | — | IMAP service on USERS |
| Wu-ftpd | — | anonymous FTP on DATA |
| XTACACS (`xtacacsd`) | 3.4 (1995) | central dial-up authentication on USERS |
| Majordomo | — | mailing-list service on DATA |
| `tcpd` (TCP wrappers) | Wietse Venema | access control/logging for `inetd` services |
| tkined | 1.3.4 | SNMP network management |
| CERN httpd | 3.0 | caching proxy (1996) |

## Web servers

| Software | Version | Phase |
|---|---|---|
| NCSA HTTPd | 1.4 / 1.5 | launch and early operation |
| Apache | 1.1 | later, after migration |

The migration from NCSA HTTPd to Apache happened in 1996 (Apache was rising
to become the reference Unix web server, precisely in 1996); the recovered Xpert reference material includes
an early Apache configuration tree.

## Development and operations

| Software | Role |
|---|---|
| C compiler and development tools | on DVLP (build host) |
| Perl and UNIX interpreters | tooling on DVLP and the servers |
| GNU `tar` (`gtar`) | full backups |
| `dump` | incremental backups |
| `xntpd` | time synchronisation |
| `syslogd` | centralised logging to `loghost` |
| `cron` | scheduled statistics, log rotation, mirroring |
| `webcopy` + mirror script | scheduled mirroring of an external site |
| Hypermail | HTML archives of mailing lists |

## Customer-side software

| Software | Version | Notes |
|---|---|---|
| Easy! | — | Internet Force programs and clients bundled in the Welcome Kit: a launcher/interface for the Internet applications; author Marco Iannacone (documented in the kit's manual) |
| Trumpet Winsock | (kit) | Windows TCP/IP stack for dial-up, on the welcome-kit disks |
| Eudora | — | Mail client bundled in the kit |
| Agent | — | Mail/news client bundled in the kit |
| Netscape 2.0 | — | Reference browser bundled in the kit |
| Microsoft Internet Explorer | 2.0 | Bundled on the Windows 95 disk (`IF-WIN95`) |
| Telnet, Talk, IRC, Archie, Ping, FTP | — | Client programs bundled in the kit |

The customer-side programs were distributed on the
[Welcome Kit](../artifacts/customer-welcome-kit/README.en.md) floppies so that
customers did not have to download them over a slow dial-up line.

## Protocols and services in use

TCP/IP throughout; PPP on the dial-up lines; SMTP, POP3, IMAP, NNTP, HTTP,
FTP, DNS, TACACS, SNMP v1, NTP. See the individual service pages for how
each was used.

---

See also: [Development](07-development.en.md) ·
[DNS](03-dns.en.md) · [Email](04-email.en.md) ·
[Web, FTP, news and mailing lists](05-web-news-ftp.en.md)
