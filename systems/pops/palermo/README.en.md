[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# Palermo POP

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../LICENSE)

Palermo follows the standard remote-POP design: a Cisco 2501 router for the
backbone link and a Cisco 2511 access server for the modem bank.

## Router (Cisco 2501)

- Hostname `2501palermo`, IOS 10.2.
- Ethernet0: `10.0.4.1/26` (`10.0.4.0/26` private segment).
- Serial0: `10.0.4.129/25`, point-to-point to the 2511 at `10.0.4.130`.
- Default route toward the world/backbone gateway (`10.0.0.1`).
- Carried the Palermo dial network `206.20.224.0/24` and the
  `206.20.224.64/27` customer subnet toward the 2511.

## Access server (Cisco 2511)

- Hostname `2511palermo`, IOS 10.2.
- Ethernet0: `206.20.224.65/27` on the `206.20.224.64/27` subnet.
- 16 asynchronous lines, PPP, `ip unnumbered Ethernet0`.
- Customer default addresses `206.20.224.2` … `206.20.224.17`.
- `tacacs-server host 206.20.95.4`, central authentication.

## Telephone access

The POP published a voice number and a direct technical number, plus a modem
line block routed by the telephone hunt group. The numbers are recorded in
the recovered operations notes.

## Notes

Palermo appears in the recovered tkined map as both its 2501 (`10.0.4.1`)
and its access server (`10.0.4.130`), with interface-load stripcharts on both
the Ethernet and serial links.

---

See also: [The POPs](../README.en.md) ·
[The Internet uplink](../../cisco-2501-uplink/README.en.md) ·
[The dial-up session](../../../docs/02-dialup-session.en.md)
