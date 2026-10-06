[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# pippo.com — 1997 Web snapshot

> **Internet Force 1995–1996 Historical Archive**\
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.\
> Author and archive curator: **Marco Iannacone** · https://pippo.com
> License: [CC BY 4.0](../../../../LICENSE)

This directory preserves an offline copy of **pippo.com** reconstructed from 1997 Wayback Machine captures.

It is not a dump of the Internet Force server filesystem. It is an **archived Web snapshot** consisting of the resources that Internet Archive captured. [`snapshot/MANIFEST.tsv`](snapshot/MANIFEST.tsv) records the original URL, capture timestamp, MIME type, HTTP status, digest and archive URL for each resource.

The main capture is dated 11 May 1997; some resources have different capture timestamps, as is normal for a mirror reconstructed from a Web archive.

## A personal website inside the Internet Force ecosystem

`pippo.com` was Marco Iannacone's personal domain and the site was hosted on the Internet Force infrastructure. The same personal home was also reachable through `/~ianna/` on the Internet Force domains:

```text
http://www.intf.com/~ianna/
http://www.internetforce.com/~ianna/
```

The recovered snapshot directly preserves a link to the first form; the second was also used in the author's contemporary professional signature. `intf.com` and `internetforce.com` were both active domains on the same server.

The snapshot is therefore preserved as a standalone artifact rather than physically under `systems/marco/` or `systems/data/`: its content is personal, while the artifact also documents the ISP's Web and hosting services.

## A small sample of the 1995–1997 Web

The surviving code contains many characteristic techniques of the period:

- **frames** with a `<NOFRAMES>` fallback;
- separate Italian and English pages;
- JavaScript writing a scrolling message into the browser **status bar**;
- `.au` audio;
- forms submitted to **CGI** programs;
- a CGI visitor counter;
- a server-generated clock;
- a **Finger Gateway** link;
- downloadable ZIP files;
- GIF images used for navigation and page graphics.

`index.html` still contains:

```html
<!-- Ianna's Home Page version 0.2 - 10/10/1995 -->
```

so the 1997 snapshot also preserves parts of a structure originating in 1995.

## The animated GIF

[`snapshot/titolo.gif`](snapshot/titolo.gif) is the animated header created by Marco Iannacone.

The file is a **460×59 pixel, 8-frame GIF**. A hand-built animated header was one of the techniques used in 1995–1996 to introduce motion and visual identity into Web pages before today's animation mechanisms existed.

## The CGI counter

The lower frame contains:

```html
Experimental page: accessed
<img src="http://www.pointest.com/cgi-bin/Count.cgi?df=marco.dat|dd=C&ft=0">
times, since 31-12-1995.
```

The number was generated dynamically by the CGI and is therefore not embedded in the archived HTML. The counter had exceeded approximately **290,000 visits**.

`pointest.com` was not an unrelated external Web service. It was the domain associated with the Internet Force **Gorgonzola POP**. Marco Iannacone installed the counter CGI there as part of a paid consultancy assignment; in its initial configuration `pointest.com` was itself hosted on **DATA**.

The same CGI host was also used by the contact form:

```html
<form method="POST"
      action="http://www.pointest.com/cgi-bin/cgiemail/pippo/write.cgi">
```

and by the Hypertxt Web-page counter (`hyper.dat`).

## Other links to Internet Force infrastructure

The snapshot retains additional references to ISP services:

```text
http://www.intf.com/tools/finger.query
```

for the Finger Gateway, and:

```text
http://www.intf.com/~ianna/
```

for the personal home.

These references make the site useful not only as a personal artifact, but also as a concrete example of virtual hosting, personal home pages and CGI services working together inside the Internet Force infrastructure.

## Hypertxt on the 1997 site

The snapshot also includes the official **MaISoft Hypertxt** Web page and several downloadable ZIP packages.

Three files in the snapshot:

```text
hyper140.zip
hyper141.zip
hyper14b.zip
```

are byte-for-byte identical and contain a `FILE_ID.DIZ` identifying **Hypertxt 1.41**. This is historically useful: the filename `hyper14b.zip` was already in use in March 1997 as a download name, but the preserved snapshot does not contain a 1.44b release in that file.

`hypertxt/index.html` also states:

```text
Upload ultima versione: 2 Aprile 1997
```

and identifies 1.41 as the latest available release at that time.

These clues should be read together with the other Hypertxt material in the repository rather than treating the ZIP filename alone as proof of the enclosed release.

## Preservation status

The [`snapshot/`](snapshot/) directory keeps resources as recovered from the Wayback mirror, without modernizing HTML, links, CGI references or forms.

References to dynamic services that no longer operate are intentionally left in place as part of the historical artifact.

Only local Mac filesystem metadata created while assembling the package (`.DS_Store`, `__MACOSX`) has been excluded because it is unrelated to the historical site.

See [`snapshot/MANIFEST.tsv`](snapshot/MANIFEST.tsv) for the metadata of the recovered resources (URLs, timestamps, type/status and Web-archive references).
