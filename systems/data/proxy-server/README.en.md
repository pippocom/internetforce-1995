[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# Caching proxy (CERN httpd 3.0) — DATA

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../LICENSE)

In 1996 Internet Force added an **HTTP caching proxy**, running on **DATA** with
**CERN httpd 3.0** and listening on **port 8090**.

## What a caching proxy is

An **HTTP proxy** is a service that sits between clients and web servers: instead
of contacting the requested site directly, the client asks the proxy, which
fetches the page on its behalf and returns it. A **caching proxy** keeps a local
copy of pages that have already been requested, so later requests for the same
content can be served from the local cache.

For an ISP of the period this gave two concrete benefits:

- **reduced outbound traffic** to the Internet;
- **better access times** for content that had already been requested.

## Configuration

The recovered historical file documents the installation and configuration of
the service. Some representative directives:

```text
ServerRoot      /usr/local/etc/proxy
Port    8090
Caching         On
CacheRoot       /usr/local/etc/proxy/cache
CacheSize       1000
Protection PROXY-PROT {
        Mask            @(*.internetforce.com, 206.20.*.*, *.intf.com)
 }
```

These lines show the service directory, the listening port, caching, and the
proxy access restrictions.

Full recovered configuration:
[`CERN3-Proxy_installation.txt`](CERN3-Proxy_installation.txt).

---

See also: [DATA server](../README.en.md) ·
[Web, FTP, news and mailing lists](../../../docs/05-web-news-ftp.en.md) ·
[Software inventory](../../../docs/11-software-inventory.en.md)
