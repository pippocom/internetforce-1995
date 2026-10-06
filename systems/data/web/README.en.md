[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# Web server configuration (DATA)

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../LICENSE)

The NCSA HTTPd configuration for DATA (`www1.intf.com` and the customer
virtual hosts).

| File | Description |
|---|---|
| `httpd.conf` | Main server configuration: port, server root, virtual hosts. |
| `srm.conf` | Document roots, aliases, CGI mapping, directory indexing. |
| `access.conf` | Directory access rules. |
| `mime.types` | MIME type map. |

These are **SANITIZED ORIGINALS**. At launch DATA ran NCSA HTTPd; the later
migration to Apache is described in
[Web, FTP, news and mailing lists](../../../docs/05-web-news-ftp.en.md).

## Preserved historical software

| Software | Version | File | Role |
|---|---|---|---|
| script-vari | collection | [script-vari.tar.z](script-vari.tar.z) | Historical collection of Web/CGI tools by various authors (ftpmail, analog, curl, guestbook.cgi, …). Its exact local role is not established by the surviving documentation. |
| Recovered CGI scripts | — | [`scripts/`](scripts/README.en.md) | Recovered Web/CGI files (guestbook, SSI, EFF/Selena Sol, transfer log). |

The CGI scripts by **Matt Wright** used in the web environment are documented
separately, **without redistributing their source**, in
[Matt Wright's scripts](matt-wright-scripts.en.md).

---

See also: [CGI and web software](cgi-and-web-software.en.md) ·
[Recovered Web scripts](../../../systems/data/web/scripts/README.en.md)
