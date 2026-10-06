[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# System configuration (USERS)

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../LICENSE)

The operating-system configuration of USERS, plus the customer restricted
shell.

| Item | Description |
|---|---|
| `inetd.conf`, `services`, `shells` | The network services USERS offered (telnet, ident, rsh/rlogin, FTP, finger, POP3, IMAP). |
| [`rc.route`](rc.route) | The routing table applied at boot: a host route for USERS and the default route via the firewall (**original**). |
| [`rc.local`](rc.local) | The USERS role startup script: `xtacacsd`, the dial-up accounting helper `xacctd_user` and the user HTTPd instances (**original**). |
| [`fixperms`](../../firewall/system/fixperms) | The permission-hardening script; it was byte-identical on FIREWALL and USERS, so a single canonical copy is published (**original**). |
| [`ftpusers`](ftpusers) | The list of accounts denied FTP login; identical on FIREWALL, DATA and USERS (**original**). |
| [`ftp-world.txt`](ftp-world.txt) | Operational note on guest/confined FTP (`guestgroup`, the `segir`/`ftp-world` jail); **sanitized original** — the customer's personal data was removed, structure unchanged. |
| [`quota.txt`](quota.txt) | The customer disk-quota profiles and the use of `quotacheck` (**original**). |
| `syslog.conf` | Logging configuration (central logging to `loghost`). |
| `httpd/` | The NCSA HTTPd configuration for the USERS web service and personal pages. |
| `passwd.users-jan1995` | The customer account database (January 1995), about 765 customer accounts plus system accounts (**sanitized original**). |
| `restricted-shell.txt` | The customer restricted-shell environment and account model (**sanitized original**). |

`rc.route`, `rc.local`, `fixperms`, `ftpusers` and `quota.txt` are recovered
**ORIGINALS** with no credentials. `ftp-world.txt` is a **SANITIZED ORIGINAL**
(customer identifiers replaced). `inetd.conf`, `passwd.users-jan1995` and
`restricted-shell.txt` are **SANITIZED ORIGINALS**. The customer account model
is described in [Customer provisioning](../../../docs/12-customer-provisioning.en.md);
quotas and FTP also in
[Operations and backup](../../../docs/14-operations-and-backup.en.md). Password
hashes are synthetic but keep the canonical DES format, so the account files
remain readable as they were.
