[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# Check Point FireWall-1

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../LICENSE)

| Item | Description |
|---|---|
| `FW-policy.gif` | The **ORIGINAL** FireWall-1 Rule Base Editor screenshot (`/usr/local/etc/fw/conf/final1.W`), showing the real 15-rule policy. |
| `firewall-lic.txt` | FireWall-1 version/entitlement information; the license key itself has been replaced with a placeholder. |

`FW-policy.gif` is a primary historical artifact, not a reconstruction. The
rule base it shows is transcribed in
[Security](../../../docs/06-security.en.md), including the final
`Any -> Any : Any : STOP` rule and the per-service paths.

## FireWall-1 Stateful Inspection

Check Point, founded in 1993, introduced FireWall-1 in 1994 with the technology it called **Stateful Inspection**.

Traditional packet filters evaluated each packet primarily on the basis of parameters such as IP address, protocol and port, without maintaining a complete representation of the state of the communication. FireWall-1 instead introduced a dynamic connection-state table: the firewall could therefore recognise whether a packet belonged to an already authorised session and apply policy while taking into account the context of the communication, rather than only the characteristics of the individual packet.

This made it possible to apply more context-aware control over connections without necessarily requiring a protocol-specific application proxy for every service.

In 1995 this technology was still extremely recent: FireWall-1 had been introduced commercially only the year before. Its presence in Internet Force systems therefore documents a very early adoption of a principle that would become fundamental in the evolution of network firewalls.
