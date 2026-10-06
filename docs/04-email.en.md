[🇮🇹 Italiano](04-email.md) · 🇬🇧 **English**

# Email

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

Internet Force ran a conventional UNIX mail platform for its customers. The
mail host was **USERS** (`206.20.95.4`), with **DATA** (`206.20.95.3`) as the
secondary mail exchanger. Both ran **Sendmail 8.6.12**, built in September
1995.

## Transport

`internetforce.com` published two MX records: USERS at preference 0 and DATA
at preference 1. Incoming Internet mail therefore arrived at USERS first.
Sendmail relayed and delivered mail locally; there was no smarthost in front
of it, so the servers spoke SMTP directly to the rest of the Internet.

Mail was delivered to the local mailbox with `mail.local`, and the well-known
aliases (`postmaster`, `webmaster`, `hostmaster`, `dnsmaster`, `staff`,
`sales`, `marketing`, `info`, `help`, `register`, `helpdesk`, `popserv`,
`compserv`) expanded to the appropriate people or role accounts. Site-wide
changes to aliases were made by editing `/etc/aliases` and rebuilding the
alias database.

## Customer mailbox access

Customers read mail with either of the two protocols deployed on USERS:

- **POP3** — the Berkeley `popper` server (version 1.6), started by `inetd`.
  Because Internet Force used a per-user access model, the maildrop was the
  customer's `.mailbox` file in the home directory rather than the system
  spool.
- **IMAP** — `/usr/local/etc/imapd`, also started by `inetd`, which let
  customers keep mail on the server and read it from multiple clients.

Both services were reachable by customers over their dial-up connection.
Stock mail clients of the period (Pine, Eudora, and similar) were supported;
Pine was pre-configured for new accounts.

## Mailing lists

Majordomo ran on DATA and provided the mailing-list service. The recovered
aliases show the lists `intf-list`, `coach`, `marketing-l` (with a digest
variant) and `cosmo-answer`, each with the standard Majordomo aliases for
subscription, approval, requests and archives. Lists were managed by mail
commands and controlled by list passwords; staff procedures for adding and
removing subscribers and for approving subscription requests survive in the
recovered training notes. See
[Web, FTP, news and mailing lists](05-web-news-ftp.en.md) for the list
management side.

## Reading mail on the road

Because a customer's mailbox lived on the central USERS server, mail was
available from any POP: the mailbox was not tied to a particular dial-up
line, only to the account.

## Representative configuration

From the Sendmail configuration recovered on DATA
(`systems/data/mail/sendmail.cf.data`):

```text
DMinternetforce.com
DS
Msmtp,   P=[IPC], F=mDFMuX, S=11/31, R=21, E=\r\n
Mlocal,  P=/bin/mail, F=lsDFMrmn, S=10, R=20/40
```

`DMinternetforce.com` is the local domain; `Msmtp` delivers over the network,
`Mlocal` delivers to the local mailbox (`.mailbox` in the home). An empty `DS`
means no smarthost: the servers spoke SMTP directly.

→ Complete configuration: [`systems/data/mail/sendmail.cf.data`](../systems/data/mail/sendmail.cf.data) ·
[`systems/users/mail/sendmail.cf.users`](../systems/users/mail/sendmail.cf.users)

---

See also: [USERS server](../systems/users/README.en.md) ·
[DNS](03-dns.en.md) ·
[POP3 and mailbox access](18-pop3-and-mailbox-access.en.md)

---

→ [Build an Internet Force POP, step by step](00-build-an-isp.en.md)
