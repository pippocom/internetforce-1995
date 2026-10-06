[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# Pesaro POP

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../LICENSE)

Pesaro is a full remote POP with the standard Internet Force two-router
design: a Cisco 2501 for the backbone link and a Cisco 2511 for the modem
bank.

## Router (Cisco 2501)

- Hostname `2501pesaro`, IOS 10.2.
- Ethernet0: `10.0.3.1/26` (`10.0.3.0/26` private segment).
- Serial0: `10.0.3.129/25`, a point-to-point link to the 2511 at
  `10.0.3.130`.
- Default route toward the world/backbone gateway (`10.0.0.1`).
- Carried the Pesaro dial network `206.20.115.0/24` and the `206.20.115.64/27`
  customer subnet toward the 2511.

## Access server (Cisco 2511)

- Hostname `2511pesaro`, IOS 10.3.
- Ethernet0: `206.20.115.65/27` on the `206.20.115.64/27` subnet.
- 16 asynchronous lines, PPP, `ip unnumbered Ethernet0`.
- Customer default addresses `206.20.115.2` … `206.20.115.17`.
- `tacacs-server host 206.20.95.4`, so callers authenticated centrally.

## Fano sub-POP

Pesaro also acted as the hub for the later **Fano** POP. The serial link
`10.0.9.128/25` connects to the Fano router at `206.20.115.66`, and Pesaro
routes the Fano network `206.20.230.0/24` on toward the backbone. See
[Later POPs](../later-pops/README.en.md).

## Telephone access

The POP published a main number and several modem lines, with a hunt group
so that calls were routed to a free modem. The dial-in numbers and the line
layout are recorded in the recovered operations notes.

## Notes

The recovered archive also contains a superseded Pesaro/INDI configuration
(`*-indi-old`) from before the Fano and INDI links were reworked; it is kept
as version history rather than as the canonical configuration.

## Phase after Internet Force (1996–1997)

The Pesaro POP configurations from the Internet Force period are those described
above. The [`post-internet-force/`](post-internet-force/) directory instead holds
the material from the phase after Internet Force's closure and the evolution
towards **Pesaro Point** and local autonomy, including the Fano changes already
mentioned:

- `collaudo.txt` — the acceptance document dated **22 October 1996**, signed by
  Gennaro Mascini for Pesaro Point srl;
- `CISCO/` — Cisco 2501/2511 configurations (including Fano);
- `Named-NT/` — the Windows NT named;
- `marzo/` — the **March 1997** changes (Cisco, routing, NT DNS, Linux notes).

These files come from the configurations preserved from the phase after Internet
Force's closure, with the evolution towards Pesaro Point and local autonomy.

---

See also: [Wind-down and migrations](../../../docs/17-wind-down-and-migrations.en.md) ·
[The POPs](../README.en.md) ·
[The Internet uplink](../../cisco-2501-uplink/README.en.md) ·
[Network growth](../../../docs/13-network-growth-1995-1996.en.md)
