[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# System configuration (FIREWALL)

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../LICENSE)

| File | Description |
|---|---|
| `passwd` | The FIREWALL account database (**sanitized original**). |
| [`fixperms`](fixperms) | The permission-hardening script (binary ownership, removal of setuid/setgid bits, protection of configuration files); it was byte-identical on FIREWALL and USERS, so this is the canonical public copy (**original**). |

`passwd` is a **SANITIZED ORIGINAL**: usernames and account structure are
unchanged; password fields carry synthetic hashes (locked accounts keep `*`)
and the name fields are replaced with "utente anonimizzato". The firewall
host had the usual UNIX service accounts and no customer accounts. `fixperms`
is a recovered **ORIGINAL** with no credentials; it is discussed in
[Security](../../../docs/06-security.en.md). The `ftpusers` list, identical on
FIREWALL, DATA and USERS, is published as the canonical copy at
[`../users/system/ftpusers`](../../users/system/ftpusers).
