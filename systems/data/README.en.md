[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# DATA server

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../LICENSE)

DATA was the public-services host at the centre of the network: name
resolution, anonymous FTP, Usenet news, mailing lists and the main web and
virtual-host content.

![DATA box in the 1995 Systems Overview](../../images/crops/data.png)

*Crop from [`images/internetforce_server_map.png`](../../images/internetforce_server_map.png) (Systems Overview 1995).*

## Platform

- Sun SPARCstation 5, SunOS 4.1.4, 64 MB RAM.
- Address `206.20.95.3`, on its own firewall segment via `fw-data`
  (`206.20.95.10`).
- Primary nameserver (`dns`, `206.20.95.3`).

## Roles

### DNS (primary)

DATA was the authoritative primary for `internetforce.com`, `intf.com`,
`internetforce.it` and the hosted customer/virtual domains. It ran BIND 4
and generated zones with the `makezones` tooling. See [DNS](../../docs/03-dns.en.md).

### Anonymous FTP

DATA ran the public FTP service under `/usr/local/ftp`, with a download-only
`/pub`, a separate upload-only area, and a chrooted anonymous account using
Wu-ftpd and the `/ftponly` shell. See
[Web, FTP, news and mailing lists](../../docs/05-web-news-ftp.en.md).

### Usenet news

DATA served Usenet news, fed from the upstream `news.ios.com` server. The
FireWall-1 rule base records that feed (`news.ios.com -> data : nntp`).

### Web and virtual hosts

DATA served `www1.intf.com` and the customer virtual web sites through the
VIF address scheme (`www.20` … `www.35` in DNS). At launch the web server
was NCSA HTTPd, later replaced by Apache. See
[Web, FTP, news and mailing lists](../../docs/05-web-news-ftp.en.md).

Among the virtual hosts was `pointest.com`, the domain associated with the
Gorgonzola POP, served centrally from DATA in its initial phase but subsequently made autonomous by Marco; it exposed
the CGI services `Count.cgi` (counter) and `cgiemail` (contact form). The
snapshot of the personal site
[`pippo.com` of 1997](../../systems/marco/personal-web/pippo.com-1997/README.en.md)
uses exactly those CGI services and links the ISP's virtual hosting to a
concrete Web artifact.

### Mailing lists

Majordomo ran on DATA and hosted the `intf-list`, `coach`, `marketing-l`
(with digest) and `cosmo-answer` lists, with HTML archives.

## Storage

The server used the system disk plus three ~2 GB SCSI disks with designated
roles: NEWS, HTTP and spare future capacity. The anonymous FTP and web trees
lived on these disks.

## Services and configuration

| Service / role | Description | Configuration / evidence | Documentation |
|---|---|---|---|
| Primary DNS (BIND 4) | Authoritative nameserver for the Internet Force and hosted domains. | [`dns/named.boot`](dns/named.boot) · [`dns/named-data/`](dns/named-data/) · [`dns/`](dns/README.en.md) | [DNS](../../docs/03-dns.en.md) |
| Anonymous FTP | Public chrooted FTP archive (Wu-ftpd, `/ftponly` shell). | [`system/inetd.conf`](system/inetd.conf) · [`../users/system/ftp-world.txt`](../users/system/ftp-world.txt) · [`../users/system/ftpusers`](../users/system/ftpusers) | [Web, FTP, news and mailing lists](../../docs/05-web-news-ftp.en.md) |
| Majordomo | Mailing lists with HTML archives. | [`majordomo/`](majordomo/README.en.md) | [Mailing lists](../../docs/20-mailing-lists-majordomo.en.md) |
| Caching proxy (CERN httpd 3.0) | HTTP proxy with cache, listening on port 8090. | [`proxy-server/`](proxy-server/README.en.md) · [`CERN3-Proxy_installation.txt`](proxy-server/CERN3-Proxy_installation.txt) | [Web, FTP, news and mailing lists](../../docs/05-web-news-ftp.en.md) · [Software inventory](../../docs/11-software-inventory.en.md) |
| Usenet news | News service fed from `news.ios.com` (NNTP). | *no recovered configuration* (the FireWall-1 rule documents the feed) | [Web, FTP, news and mailing lists](../../docs/05-web-news-ftp.en.md) |
| WWW / NCSA httpd | Web server and customer virtual hosts. | [`web/httpd.conf`](web/httpd.conf) · [`web/`](web/README.en.md) | [Web, FTP, news and mailing lists](../../docs/05-web-news-ftp.en.md) |
| Virtual hosting (VIF) | Per-site dedicated addresses via Virtual Interface on SunOS. | [`../sun-vif/`](../sun-vif/README.en.md) · [`dns/new_dns-HOWTO.txt`](dns/new_dns-HOWTO.txt) | [Web, FTP, news and mailing lists](../../docs/05-web-news-ftp.en.md) |
| Additional FTP archives | Additional public mirrors and archives. | [`../../artifacts/scripts/automatic_mirror-HOWTO.txt`](../../artifacts/scripts/automatic_mirror-HOWTO.txt) | [Web, FTP, news and mailing lists](../../docs/05-web-news-ftp.en.md) |

> WAIS appears among DATA's historical services; for the VIF/WAIS material the
> reference is [`../sun-vif/`](../sun-vif/README.en.md). No link is forced to a
> configuration that does not exist.

## Related content in this area

- `dns/` — primary nameserver configuration and zones.
- [`mail/`](mail/README.en.md) — mail and DATA's secondary-MX role.
- [`ftp/`](ftp/README.en.md) — anonymous FTP area and preserved historical packages (the configuration is in `system/inetd.conf`).
- `majordomo/` — mailing-list configuration and procedures.
- `news/` — Usenet news material (no recovered configuration).
- `web/` — web server configuration and virtual-host material.
- `system/` — `/etc` configuration, `inetd` (anonymous FTP) and startup.

---

See also: [Architecture overview](../../docs/01-architecture.en.md) ·
[USERS server](../users/README.en.md)
