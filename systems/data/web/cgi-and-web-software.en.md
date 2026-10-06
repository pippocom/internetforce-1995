[🇮🇹 Italiano](cgi-and-web-software.md) · 🇬🇧 **English**

# CGI and web software used by Internet Force

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../LICENSE)

This page documents the ecosystem of CGI and web utility software used on the
Internet Force servers (in particular DATA/USERS): what was used, version, purpose,
recovered evidence, any local configuration or customization, and redistribution
status. The recovered readable files are in
[`systems/data/web/scripts/`](../../../systems/data/web/scripts/README.en.md).

## Inventory

| Software | Version | Author/source | Purpose at Internet Force | Recovered evidence | Local configuration/customization | Upstream link | Redistribution |
|---|---|---|---|---|---|---|---|
| Random Image Displayer (`advert.cgi`) | 1.2 (1995) | Matt Wright — Matt's Script Archive | Random image banners for customer pages | Locally configured copy (private) | `basedir = http://www.internetforce.com/img_rand/`; images `cosmopolitan.jpg`, `meazzi.jpg`, `per.jpg`; URLs to `www.intf.com/…` | <https://www.scriptarchive.com/> | **Not redistributed** (permission required) |
| Matt's Script Archive — `total` collection | 1996 | Matt Wright | Collection of CGI scripts (counter, guestbook, wwwboard, `rand_image`, `ssi_image`, formmail, …) | Archive `Matt.script.tot.tar.gz` (private) | — | <https://www.scriptarchive.com/> | **Not redistributed** |
| `rand_image` | — | Matt Wright | Random image | Archive `rand_image.tar.gz` (private) | — | <https://www.scriptarchive.com/> | **Not redistributed** |
| `ssi_image` | — | Matt Wright | Random image via SSI | Archive `ssi_image.tar.gz` (private) | — | <https://www.scriptarchive.com/> | **Not redistributed** |
| `guestbook.cgi` | v2.20 | Third party | Guestbook | Readable file `guestbook.cgi` | Generic upstream configuration (`www.cs.uoregon.edu`), not Internet Force | — | Not CC BY; attribution retained |
| `ssis.pl` | 1.1.3 (1995) | George Burgyan, Gabe Schaffer | SSI substitute | Readable file `ssis.pl` | Working copy | — | Not CC BY |
| EFF/Selena Sol scripts/templates | 1995 | EFF / Selena Sol | Web scripts and templates | `EFF/` folder | Example/upstream material | — | Not CC BY |

## Notes

- **Matt's Script Archive:** Internet Force used in particular its *Random Image
  Displayer*, locally configured for its own banners. Matt Wright's terms require
  permission for redistribution of the source, so this repository **does not
  publish any Matt Wright code**: it documents only the use and the
  configuration. Any version currently available on `scriptarchive.com` is not
  necessarily identical to the historical version Internet Force used. The
  detailed inventory of the recovered scripts (name, version, function) and the
  licensing/redistribution context are in
  [Matt Wright's scripts](matt-wright-scripts.en.md).
- **Pointest (counter and form):** the snapshot of the personal site
  [`pippo.com` 1997](../../../systems/marco/personal-web/pippo.com-1997/README.en.md)
  preserves calls to a counter CGI (`Count.cgi`) and to `cgiemail` served by
  `pointest.com`; see also the
  [Gorgonzola POP](../../pops/gorgonzola/README.en.md).
- No password or credential is reproduced on this page.

---

See also: [Web server configuration](README.en.md) ·
[Web, FTP, news and mailing lists](../../../docs/05-web-news-ftp.en.md) ·
[Recovered Web scripts](../../../systems/data/web/scripts/README.en.md)
