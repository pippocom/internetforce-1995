[🇮🇹 Italiano](DOMAIN-PROVISIONING-WORKFLOW.md) · 🇬🇧 **English**

# Adding a new customer domain (workflow)

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../LICENSE)

> **Modern document.** This is a didactic explanation, not a historical file.
> The operational sequence is derived from the recovered original HOWTO
> [`new_dns-HOWTO.txt`](new_dns-HOWTO.txt), preserved alongside as an
> **ORIGINAL** artifact. Short original excerpts are quoted where useful.

This workflow describes how Internet Force turned a new customer domain into a
site that was actually served: from registration/delegation to the NCSA
`VirtualHost` and the final test. It is the same path as the
[DNS](../../../docs/03-dns.en.md) and
[Web, FTP, news and mailing lists](../../../docs/05-web-news-ftp.en.md)
documents, but seen from the point of view of the person who had to execute it.

The model is the one described in
[VIF on SunOS](../../sun-vif/README.md): with HTTP/1.0 every site needed its own
IP address, which the Sun had to own through the VIF virtual interfaces.

## 1. Register and delegate the domain

A domain does not exist on the Internet until it is registered and delegated.
The original HOWTO does not document the registration practice; that is
described in
[InterNIC/GARR domain registration](../../../artifacts/domain-registration/README.en.md):
`.com` was registered through InterNIC, `.it` through the structure managed via
GARR. Only after delegation can queries for the domain reach the Internet Force
nameservers.

## 2. Make Internet Force authoritative

Internet Force hosted the domain on its BIND-4 nameservers. The zone file was
built from a `.source` master file for the domain. The original HOWTO showed the
`canalemoda.source` case:

```text
@  IN   SOA     canalemoda.com dnsmaster.internetforce.com. (
                1996041801       ; Serial
                10800            ; Refresh 3 hours
                3600             ; Retry 1 hour
                604800           ; Expire after a week
                86400 )  ; Minimum ttl 1 day
                                NS      harley.ios.com.
                                NS      users.internetforce.com

>E www                  A       206.20.95.20
localhost               A       127.0.0.1
```

The `NS` record to the registrar's server (`harley.ios.com`) and the one to
`users.internetforce.com` declare who answers for the domain; the `www` record
maps the name to the site's future IP address. Zone structure and syntax are
explained in [DNS](../../../docs/03-dns.en.md).

## 3. Update `named.boot`

The domain had to be declared in the BIND-4 boot file, for example:

```text
primary   canalemoda.com                        primary/canalemoda.com
```

The recovered `named.boot` is in [`named.boot`](named.boot).

## 4. Generate the zone

Zones were not written by hand: they were generated from the master with
`makezones` and the DNS `Makefile` workflow (see
[`named-data/Makefile`](named-data/Makefile)), adding the new generation rule.
The original HOWTO also documents the typical errors, for example the
requirement to use TAB in the `Makefile`.

## 5. Choose the site's IP address

Every hosted site mapped to a dedicated address (for example `206.20.95.20`).
The complete map of virtual addresses is visible in the reverse zone
[`db.206.20.95`](named-data/primary/db.206.20.95).

## 6. Make sure the address exists on the Sun (VIF)

The address had to really exist on the web machine. The original HOWTO recalls
using `ifconfig le0` to read the Sun's physical Ethernet address
(`users: 8:0:20:74:ff:4f`, `data: 8:0:20:77:cb:64`), needed for the published
ARP of the VIF interfaces. The full mechanism is described in
[VIF on SunOS](../../sun-vif/README.md).

## 7. Route the new address through the firewall

Because DATA and USERS sat behind separate FireWall-1 interfaces, the new
address had to be routed to the right segment. The original HOWTO shows the
addition in `rc.route`:

```text
ifconfig qe0 fw-data netmask 255.255.255.192
route delete intfnet fw-data
route add host data fw-data 0
route add host 206.20.95.20 fw-data 0
```

The canonical public configuration is
[`../../firewall/network/rc.route`](../../firewall/network/rc.route).

## 8. Update reverse DNS (PTR)

The original HOWTO adds the PTR to the `internetforce.source` master:

```text
; PTR record (added by marco following yogo's suggestion)
20.95.20.206    PTR     www.canalemoda.com.
```

The PTR makes the name resolvable from the address; the reverse zone is
[`db.206.20.95`](named-data/primary/db.206.20.95).

## 9. Configure the NCSA `VirtualHost`

Finally NCSA HTTPd associates the address with the site through a
`VirtualHost` block, for example:

```text
<VirtualHost 206.20.95.20>
ServerName www.canalemoda.com
DocumentRoot /usr/local/etc/httpd/htdocs/cmoda/
</VirtualHost>
```

The complete configuration is in
[`../web/httpd.conf`](../web/httpd.conf), explained in
[Web, FTP, news and mailing lists](../../../docs/05-web-news-ftp.en.md).

## 10. Test

The original HOWTO tests zone generation (`makezones`) and reloads `named` with
`kill -HUP`. In modern terms the final check was: the zone generates without
errors, `named` reloads, the name resolves to the chosen address, the firewall
routes that address, and the `VirtualHost` serves the correct `DocumentRoot`.

---

See also: [DNS](../../../docs/03-dns.en.md) ·
[Web, FTP, news and mailing lists](../../../docs/05-web-news-ftp.en.md) ·
[VIF on SunOS](../../sun-vif/README.md) ·
original HOWTO [`new_dns-HOWTO.txt`](new_dns-HOWTO.txt)
