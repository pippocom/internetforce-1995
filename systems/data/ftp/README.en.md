[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# Public FTP (DATA)

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../LICENSE)

This directory held the files and data of Internet Force's public FTP service.

The complete FTP-service configuration did not survive in the recovered
material. The general operation of the service and its role in the
infrastructure are described in
[Web, FTP, news and mailing lists](../../../docs/05-web-news-ftp.en.md). The
`inetd` portion that started anonymous FTP on DATA is preserved in
[`../system/inetd.conf`](../system/inetd.conf).

## Preserved historical software

| Software | Version | File | Role |
|---|---|---|---|
| wu-ftpd | 2.4.2 beta 11 | [wu-ftpd-2.4.2-beta-11.tar.Z](wu-ftpd-2.4.2-beta-11.tar.Z) | Unix FTP daemon: provided the public FTP service. |
| mirror | 2.3 | [mirror-2.3.tar.gz](mirror-2.3.tar.gz) | FTP mirroring/synchronization software, used to replicate or maintain mirrored FTP content. |

**wu-ftpd 2.4.2 beta 11** — `wu-ftpd-2.4.2-beta-11.tar.Z` is the upstream
package of the FTP daemon used for the public FTP service. The package's
internal `README` states “RELEASE 2.4.2-BETA-10” while the filename says
`beta-11`; the archive preserves the historical software package as received.
The repository does not claim that the archive contains the Internet Force
configuration.

**mirror 2.3** — `mirror-2.3.tar.gz` is FTP mirroring software. No specific
mirror relationship is documented in the recovered material; the package is
preserved as recovered third-party historical software.

Both packages are **third-party historical software**, each with its own
original licence.

---

See also: [Web, FTP, news and mailing lists](../../../docs/05-web-news-ftp.en.md) ·
[System configuration (DATA)](../system/README.en.md)
