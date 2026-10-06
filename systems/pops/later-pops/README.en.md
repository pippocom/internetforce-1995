[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# Later POPs (1996)

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../LICENSE)

These POPs were added during 1996 as Internet Force expanded its coverage.
They keep the router + access-server pattern, but their device models and
link arrangements vary according to the site and are documented from their
recovered configurations rather than forced into a single template.

## Tera

- Router: Cisco 2501 (`2501tera`), Ethernet `10.0.7.1/26`; serial
  `10.0.7.129/25`.
- Access server: **Cisco 2509** at `206.20.227.65/24` (the 2509, not a 2511,
  plays the access-server role here).
- Dial network `206.20.227.0/24`; domain `tera-it.com`.

## CNN

CNN is documented separately on its dedicated home, together with its local DNS:
[CNN POP](../cnn/README.en.md).

## Fano

- A Pesaro sub-POP. Router (`pesaro-fano`) at `206.20.115.66/27`, linked to
  Pesaro over serial `10.0.9.128/25`; access server (`2511fano`) at
  `206.20.230.65/27` with 4 asynchronous lines and pool `206.20.230.34` …
  `206.20.230.37`.
- Dial network `206.20.230.0/24`; Pesaro routed Fano's traffic to the
  backbone.

## INDI

- Router: Cisco 2501 (`2501INDI`), Ethernet `10.0.10.1/26`.
- Reached over a **frame-relay** domestic link; the Milan and Pesaro ends of
  the frame-relay circuit are recorded in
  `POP_albacom-CISCO_configuration.txt` (maps onto `10.0.10.130` and
  `10.0.10.1`).
- Dial network `206.20.231.0/24`.

## Seregno

- The network `206.20.226.0/24` (`intf-seregno`) appears in the firewall's
  network list, but no router configuration for Seregno survives. It is
  included for completeness as part of the 1996 address plan.

---

See also: [The POPs](../README.en.md) ·
[Network growth 1995 → 1996](../../../docs/13-network-growth-1995-1996.en.md)
