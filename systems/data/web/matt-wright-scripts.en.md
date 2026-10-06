[🇮🇹 Italiano](matt-wright-scripts.md) · 🇬🇧 **English**

# Matt Wright's scripts (Matt's Script Archive)

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../LICENSE)

This page documents the CGI scripts by **Matt Wright** (Matt's Script Archive)
present in the recovered backup material, **without redistributing their
source**. It is the detailed companion to the general entry in
[CGI and web software](cgi-and-web-software.en.md).

## Licensing / redistribution note

The recovered original source files for Matt Wright's scripts are not
redistributed in this repository. Their original distribution terms do not
permit republishing them here. This page therefore documents their historical
presence, function and use, and points to the official archive for the software.

In particular, the recovered archive `Matt.script.tot.tar.gz` (which contains
the `total/` collection) remains in the curator's private working material and is
**not** copied into the public tree. The individual copies `rand_image` and
`ssi_image` - which are part of the same collection - are not published either.

## Inventory of the recovered scripts

The recovered `total/` collection contains the following scripts (names and
versions as declared by the collection `README`). Functions are described at the
level of the name/period use; no unattested implementation details are added.

| Script | Version | Function | Local use at Internet Force |
|---|---|---|---|
| Guestbook | 2.3.1 (1995-10-29) | CGI guestbook. | Not attested in the public collection; a readable `guestbook.cgi` copy is documented in [CGI and web software](cgi-and-web-software.en.md). |
| Free for All Link Page | 2.2 (1996-07-17) | CGI-managed link page. | No evidence of local activation. |
| WWWBoard | 2.0 ALPHA 2 (1995-11-25) | CGI discussion board. | No evidence of local activation. |
| FormMail | 1.5 (1996-02-05) | Emails the contents of a form. | No evidence of local activation. |
| Random Image Displayer | 1.2 (1995-07-17) | Random image/banner per page load. | **Attested**: locally configured as `advert.cgi` for banners (see [CGI and web software](cgi-and-web-software.en.md)). |
| SSI Random Image Displayer | 1.2 (1995-11-04) | Server Side Includes variant. | No evidence of local activation. |
| Random Link Generator | 1.0 (1995-07-30) | Random link. | No evidence of local activation. |
| Animation | 1.2 (1995-11-21) | Server-push animation. | No evidence of local activation. |
| Countdown | 1.2.1 (1995-10-08) | Countdown. | No evidence of local activation. |
| Counter | 1.1.1 (1996-01-11) | Access counter. | No evidence of local activation. |
| Simple Search | 1.0 (1995-12-16) | Simple site search. | No evidence of local activation. |
| TextCounter | 1.2 (1996-05-10) | Text counter. | No evidence of local activation. |
| Random Text | 1.0 (1996-07-13) | Random text. | No evidence of local activation. |
| HTTP Cookie Library | 1.1.1 (1996-07-15) | Perl library for HTTP cookies. | No evidence of local activation. |
| TextClock | 1.0.2 (1996-07-15) | Text clock. | No evidence of local activation. |
| Credit Card Verifier | 1.02 (1996-07-01) | Card-number checksum verifier. | No evidence of local activation. |
| Book 'em Dan-O | 1.01 (1996-07-07) | CGI utility from the collection. | No evidence of local activation. |

## Use in the Internet Force Web/CGI environment

The only clearly attested local use is the **Random Image Displayer**, configured
as `advert.cgi` with `basedir = http://www.internetforce.com/img_rand/` and a set
of local images; details are in
[CGI and web software](cgi-and-web-software.en.md). The other scripts are
preserved as recovered period software; no specific use is asserted without
evidence.

## Official archive

The software is published by its author at the official **Matt's Script Archive**:

<https://www.scriptarchive.com/>

Per-script pages are available on that site. The version currently available is
not necessarily identical to the historical version Internet Force used.

---

See also: [CGI and web software](cgi-and-web-software.en.md) ·
[Web, FTP, news and mailing lists](../../../docs/05-web-news-ftp.en.md)
