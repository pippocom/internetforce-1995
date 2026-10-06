[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# Recovered Web scripts (1995–1996)

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../../LICENSE)

This directory contains loose Web/CGI files recovered from the historical
working archive. They are kept directly readable because some preserve
Internet Force-specific configuration or development-workflow evidence; this
does **not** mean that all were written by Internet Force or that the
repository's CC BY 4.0 automatically applies to them.

## Files

### `advert.cgi` — not redistributed

Internet Force used **Matt Wright's** **Random Image Displayer** (Matt's Script
Archive) for the random banners on its sites: version **1.2** (1995), configured
for `www.internetforce.com/img_rand/` and `www.intf.com/...`. Matt Wright's terms
require permission for redistribution, so the **upstream source is not
redistributed** in this repository. The historical use and the Internet Force
configuration are documented in the inventory
[`systems/data/web/cgi-and-web-software.md`](../cgi-and-web-software.md).

### `guestbook.cgi` / `guestbook.doc`

Third-party guestbook software, preserved with its generic upstream
configuration (`www.cs.uoregon.edu`) rather than an Internet Force deployment
configuration.

### `ssis.pl`

Third-party SSI-substitute script by **George Burgyan** and **Gabe Schaffer**,
preserved as a working copy with its original authorship context.

### `EFF/`

Copies of EFF/Selena Sol Web scripts and templates, mostly upstream/example
material. The historical value also lies in `EFF/WS_FTP.LOG`, which records
transfers from `marco.intf.com:/home/ianna/eff` (30 September 1996),
documenting the workstation workflow.

## Licensing

There is no single license for this directory: every file retains its original
author's attribution and is **not** relicensed under CC BY 4.0. Some files may
require the author's permission for redistribution.

---

See also: [Web, FTP, news and mailing lists](../../../../docs/05-web-news-ftp.en.md) ·
[Development and DVLP](../../../../docs/07-development.en.md) ·
[Recovered artifacts](../../README.en.md)
