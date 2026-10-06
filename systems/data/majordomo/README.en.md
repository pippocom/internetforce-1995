[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# Mailing lists (Majordomo) — DATA

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../LICENSE)

Majordomo ran on DATA and managed Internet Force's mailing lists. This directory
preserves the recovered historical software together with the ISP-specific
operational material.

## Preserved historical software

| Software | Version | File | Role |
|---|---|---|---|
| Majordomo | 1.92 | [Majordomo.tar.z](Majordomo.tar.z) | Mailing-list management. |
| Hypermail | 1.02 | [hypermail.102.tar](hypermail.102.tar) | Conversion of list archives into HTML pages. |

**Majordomo 1.92** — `Majordomo.tar.z` is the upstream mailing-list manager
package. Its internal `majordomo_version.pl` file declares version `1.92`. The
recovered archive also contains the **local Internet Force list configuration**
(`lists/intf-list`, `lists/coach`, `lists/cosmo-answer`, `lists/marketing-l` and
`digests/marketing-l-digest`) and operational material under `dati-utili/` and
`archives/`. The ISP-specific operational material is in
[`coach.txt`](coach.txt) (a subscription template for the `Coach` list) and
[`HOWTO-create.m-list.txt`](HOWTO-create.m-list.txt) (an operational recipe that
invokes Hypermail for the `cosmo-answer` archive), and in
[Mailing lists](../../../docs/20-mailing-lists-majordomo.en.md).

**Hypermail 1.02** — `hypermail.102.tar` is the software that converted mail
archive files into Web-readable HTML pages; it was the final step of the list
archiving flow described in
[`HOWTO-create.m-list.txt`](HOWTO-create.m-list.txt). It is not a generic
web-server component.

Both packages are **third-party historical software**, each with its own
original licence.

---

See also: [Mailing lists](../../../docs/20-mailing-lists-majordomo.en.md) ·
[DATA server](../README.en.md)
