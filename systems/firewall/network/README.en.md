[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# Firewall network configuration

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../LICENSE)

The routing and network configuration of the FireWall-1 gateway.

| File | Description |
|---|---|
| `rc.route` | Interface and route configuration (the five interfaces, host-specific routes, POP routes, default route) (**original**). |
| [`rc.local`](rc.local) | The firewall startup script: it started FireWall-1 (`fwstart`), the dial-up accounting and the other role services (**original**). |
| `rc-route.fw` | The firewall routing configuration as recovered in the operations notes. |
| `netmasks`, `networks`, `hosts` | Network tables, including the POP and 1996 networks. |
| `resolv.conf`, `defaultdomain`, `defaultrouter` | Resolver and default-route configuration. |
| `ntp.conf` | Time servers. |
| `inetd.conf` | The few services enabled on the firewall. |

`rc.route` and `rc.local` are **ORIGINALS**; the other files are **SANITIZED
ORIGINALS**. The interface layout and routing are described in
[Architecture overview](../../../docs/01-architecture.en.md) and
[The firewall](../README.en.md). The `fixperms` hardening script is at
[`../system/fixperms`](../system/fixperms).
