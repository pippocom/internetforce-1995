[🇮🇹 Italiano](21-putting-the-pop-together.md) · 🇬🇧 **English**

# Putting the POP together

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

This is the synthesis: **how a complete Internet Force POP works** once every
subsystem is configured. It adds no configuration; it shows how the previous
chapters fit together.

## The service chain

```text
Internet
   ↓
central Cisco 2501 (world/uplink)  ── backbone gateway 10.0.0.1
   ↓
Internetforce private backbone
   ↓
POP Cisco 2501  ── serial /25 link ──  Cisco 2511 access server
   ↓                                        ↑
   ↓                                  modem bank (16 lines)
   ↓                                        ↑
   ↓                                  customer call
   ↓
authentication: 2511 → XTACACS on USERS (206.20.95.4)
   ↓
POP local IP network (dial-up 206.20.x.0/24) → gateway → backbone
   ↓
central service hosts:
   FIREWALL  (edge + segmentation)
   DATA      (206.20.95.3)  primary DNS, web, anonymous FTP, Majordomo
   USERS     (206.20.95.4)  XTACACS, mail host, POP3/IMAP, personal pages
   DVLP      (206.20.95.130) build/operations, test, tape backup
   MARCO     (206.20.95.140) administrator workstation
   ↓
services:
   DNS  → 03-dns
   mail (SMTP)  → 04-email
   POP3/IMAP  → 18-pop3-and-mailbox-access
   web + virtual hosting (VIF)  → 05-web-news-ftp / sun-vif
   FTP  → 05-web-news-ftp + 06-security
   mailing lists (Majordomo)  → 20-mailing-lists-majordomo
   ↓
monitoring (SNMP/tkined), security, routine operations
```

The remote POPs (Pesaro, Palermo, Gorgonzola) reached Milan over dedicated
**CDA/CDN circuits at 64 kbit/s**; the sizing of the modem bank against that
capacity follows Xpert's empirical rule described in
[The POPs](../systems/pops/README.en.md).

## The path in order

1. [Architecture](01-architecture.en.md) — understand the machines and the link.
2. [Unix and host preparation](01-architecture.en.md) — make a host useful.
3. [Router, WAN](16-router-and-wan.en.md) — connect the POP to the backbone.
4. [Dial-up](02-dialup-session.en.md) — let the customer into the network.
5. [Authentication](10-authentication-tacacs.en.md) — recognise who is calling.
6. [DNS](03-dns.en.md) — give the network names.
7. [Mail](04-email.en.md) — transport and deliver messages.
8. [POP3 and mailbox](18-pop3-and-mailbox-access.en.md) — let the customer read mail.
9. [Web server](05-web-news-ftp.en.md) — serve the sites.
10. [Web permissions and CGI](19-web-permissions-and-cgi.en.md) — run programs safely.
11. [Virtual hosting (VIF)](../systems/sun-vif/README.en.md) — many sites on one machine.
12. [FTP](05-web-news-ftp.en.md) — move files, with confinement.
13. [Mailing lists](20-mailing-lists-majordomo.en.md) — distribute group mail.
14. [Security](06-security.en.md) — reduce and defend the surface.
15. [Monitoring](08-monitoring.en.md) — observe the network.
16. [Operations and backup](14-operations-and-backup.en.md) — keep the system running.
17. [Provisioning](12-customer-provisioning.en.md) — give the customer an account.
18. [Development and deploy](07-development.en.md) — build and release software.

## The administrator's view

All of this is described, in order and in the voice of the time, by the
**original operations manual** prepared by Marco for a potential junior sysad:
[`artifacts/operations-manuals/manual.md`](../artifacts/operations-manuals/manual.en.md).
It is the first-party reference to read alongside this path.

## How to continue

- Back to the [Build a POP index](00-build-an-isp.en.md).
- Explore by system: [The POPs](../systems/pops/README.en.md) and the
  [DATA](../systems/data/README.en.md) and [USERS](../systems/users/README.en.md) servers.
- Provenance of the recovered material:
  [Archive provenance](archive-provenance.en.md).

---

← [Build a POP](00-build-an-isp.en.md) ·
Previous: [Development and deploy](07-development.en.md)
