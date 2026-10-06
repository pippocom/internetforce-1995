[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# Milano POP

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../LICENSE)

Milano is where the central site and the dial-up POP are the same place. The
central Cisco 2501 provides the Internet uplink, and the **Milano Cisco
2511** provides local dial-up access. There is deliberately no separate
Milano POP 2501.

## Access server

- Cisco 2511, hostname `c2511IF`, IOS 10.2.
- Ethernet0: `10.0.2.1/24`; known in DNS/hosts as `ts1`.
- 16 asynchronous lines (`line 1 11`, `line 12`, `line 13 16`), each
  `encapsulation ppp`, `ip unnumbered Ethernet0`, `async mode interactive`.
- Customer default addresses `206.20.95.70` … `206.20.95.85`, inside the
  `206.20.95.64/26` dial-up subnet.
- Line speed 115200 bit/s, hardware flow control, `modem ri-is-cd`.
- A `guest` account existed on the terminal server that auto-connected to
  USERS, for an operator walking up to the console.

## Routing

The 2511's default route points at the world/backbone gateway (`10.0.0.1`)
at the central site, so Milano customer traffic joins the same path as every
other POP: over the backbone to the central 2501 and out to IDT. The central
FireWall-1 keeps a route for the dial subnet (`206.20.95.64/26`) pointing at
`ts1`, because it guards the server segments on the same backbone.

## Notes

Because Milano hosted the central platform, its dial-up subnet is part of the
`206.20.95.0/24` Milan block rather than a separate `/24`. The reverse DNS
names are `ppp1-milano` … `ppp16-milano`.

---

See also: [The POPs](../README.en.md) ·
[The Internet uplink](../../cisco-2501-uplink/README.en.md) ·
[The dial-up session](../../../docs/02-dialup-session.en.md)
