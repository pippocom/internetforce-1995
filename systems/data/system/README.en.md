[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# System configuration (DATA)

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../LICENSE)

| File | Description |
|---|---|
| `passwd` | The DATA account database (**sanitized original**). |
| [`rc.route`](rc.route) | The routing table applied at boot: a host route for DATA and a default route via the firewall (**original**). |
| [`rc.local`](rc.local) | The role-specific startup script for DATA: the services started at boot, including the caching proxy and virtual web (**original**). |
| [`inetd.conf`](inetd.conf) | The base `inetd` snapshot plus the "DATA SERVER" portion with the anonymous FTP service (wu-ftpd) (**original**). |

`rc.route`, `rc.local` and `inetd.conf` are recovered **ORIGINALS** with no
credentials. `inetd.conf.DATA` is the same "DATA SERVER" portion recovered
also as a separate file and is therefore not duplicated here. The FTP content
is described in [Web, FTP, news and mailing lists](../../../docs/05-web-news-ftp.en.md).

`passwd` is a **SANITIZED ORIGINAL**: usernames and account structure are
unchanged; password fields carry synthetic hashes (locked accounts keep `*`)
and the name fields are replaced with "utente anonimizzato". DATA's system
accounts were the usual UNIX service accounts plus the web and FTP service
accounts. The `ftpusers` list was identical on FIREWALL, DATA and USERS; the
canonical public copy is at
[`systems/users/system/ftpusers`](../../users/system/ftpusers).
