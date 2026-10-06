[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# USERS server

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../LICENSE)

USERS was one of the two central production servers and the one customers
interacted with most. It handled authentication, mail and customer accounts.

![USERS box in the 1995 Systems Overview](../../images/crops/users.png)

*Crop from [`images/internetforce_server_map.png`](../../images/internetforce_server_map.png) (Systems Overview 1995).*

## Platform

- Sun SPARCstation 5, SunOS 4.1.4, 64 MB RAM.
- Address `206.20.95.4`, on its own firewall segment via `fw-users`
  (`206.20.95.11`).
- Mail host for `internetforce.com` (MX 0); secondary name server (`dns2`).

## Roles

### Authentication (XTACACS)

USERS ran `xtacacsd` as the central authentication service for every
dial-up POP. Each Cisco access server pointed at `206.20.95.4`. XTACACS also
kept per-access-server login records for accounting. See
[Authentication](../../docs/10-authentication-tacacs.en.md).

### Mail

Sendmail 8.6.12 provided SMTP; the Berkeley `popper` served POP3 and
`imapd` served IMAP. Customer mail was delivered to a per-user `.mailbox` in
the home directory. See [Email](../../docs/04-email.en.md).

### DNS

USERS was the secondary nameserver (`dns2`) for all the Internet Force zones,
transferring them from DATA.

### Customer homes and web

Customer accounts lived under `/users/01/<login>/home`. Each account had a
restricted shell environment and, when required, a `public_html` directory
served as personal web space. Disk quotas were enforced on the customer
filesystems. See
[Customer provisioning](../../docs/12-customer-provisioning.en.md).

The personal pages hosted here also included the `/~ianna/` area and Marco
Iannacone's personal site `pippo.com`, served as a virtual host from USERS: the
recovered HTTPd configuration contains a `VirtualHost` for `www.pippo.com`.
The 1997 snapshot is preserved in
[`systems/marco/personal-web/pippo.com-1997/`](../../systems/marco/personal-web/pippo.com-1997/README.en.md).

## Services started by `inetd`

The recovered `inetd.conf` shows the services USERS offered: telnet, ident,
shell/rsh, login/rlogin, FTP, finger and the two mail access protocols
(`imapd` and the `popper`). The `inetd` daemons were wrapped with `tcpd`
(TCP wrappers) for access control and logging.

## Storage

The server used the system disk plus additional SCSI disks exported as
customer account filesystems (`/usr/export/sd1c`, `/usr/export/sd2c`), with
quotas enabled. A third disk was reserved for future capacity.

## Services and configuration

| Service / role | Description | Configuration / evidence | Documentation |
|---|---|---|---|
| Secondary DNS (`dns2`) | Secondary nameserver for the Internet Force zones, transferred from DATA. | *no USERS-specific configuration recovered* | [DNS](../../docs/03-dns.en.md) |
| XTACACS / AAA | Central authentication for every dial-up access server. | [`tacacs/xtacacsd-conf`](tacacs/xtacacsd-conf) · [`tacacs/`](tacacs/README.en.md) | [Authentication (XTACACS)](../../docs/10-authentication-tacacs.en.md) |
| SMTP / sendmail | Primary mail host for `internetforce.com` (MX 0), Sendmail 8.6.12. | [`mail/sendmail.cf.users`](mail/sendmail.cf.users) | [Email](../../docs/04-email.en.md) |
| POP3 | Mailbox access via the Berkeley `popper`. | [`system/inetd.conf`](system/inetd.conf) · [`system/services`](system/services) | [Email](../../docs/04-email.en.md) · [POP3 and mailbox access](../../docs/18-pop3-and-mailbox-access.en.md) |
| IMAP | Mailbox access via `imapd`. | [`system/inetd.conf`](system/inetd.conf) · [`system/services`](system/services) | [Email](../../docs/04-email.en.md) |
| Customer home directories and quotas | Accounts, restricted shell, disk quotas and filesystem layout. | [`system/passwd.users-jan1995`](system/passwd.users-jan1995) · [`system/quota.txt`](system/quota.txt) · [`system/restricted-shell.txt`](system/restricted-shell.txt) · [`system/rc.local`](system/rc.local) | [Customer provisioning](../../docs/12-customer-provisioning.en.md) · [Operations and backup](../../docs/14-operations-and-backup.en.md) |
| Customer web pages | NCSA HTTPd for `~user` and virtual hosts. | [`system/httpd/`](system/httpd/) | [Web, FTP, news and mailing lists](../../docs/05-web-news-ftp.en.md) · [Web permissions and CGI](../../docs/19-web-permissions-and-cgi.en.md) |

> There is no USERS-specific `named.boot` in the public archive: the secondary
> DNS role is documented, not configured here. The secondary-zone material is
> kept with the primary nameserver
> ([`../data/dns/`](../data/dns/README.en.md)).

## Related content in this area

- `tacacs/` — XTACACS daemon, configuration and documentation.
- `mail/` — Sendmail configuration and mail alias material.
- `dns/` — secondary nameserver area (no specific configuration recovered).
- `system/` — the host's `/etc` configuration, disk layout and startup
  scripts.

---

See also: [The dial-up session](../../docs/02-dialup-session.en.md) ·
[DATA server](../data/README.en.md)
