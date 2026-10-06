[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# CNN POP

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../LICENSE)

CNN was still an Internet Force POP in 1995. In 1995 CNN separately commissioned
Marco Iannacone for a **paid consultancy** to obtain its own DNS server: Marco
installed and configured a **DNS on Windows NT 3.5** for CNN.

## Router and access server

| Device | File |
|---|---|
| Cisco 2501 router | [2501-cnn.cfg](2501-cnn.cfg) |
| Cisco 2511 access server | [2511-cnn.cfg](2511-cnn.cfg) |

## Local DNS (Windows NT 3.5)

The files in [`dns/`](dns/) are the surviving configuration material of that
local DNS server. This configuration is **distinct from the central Internet
Force DNS** (DATA primary, USERS secondary).

The CNN case shows that, although still an Internet Force POP, CNN was already
beginning to provide some local services of its own.

| File | Description |
|---|---|
| [`dns/named.boot`](dns/named.boot) | DNS startup configuration. |
| [`dns/named.ca`](dns/named.ca) | Cache / root hints. |
| [`dns/named.in`](dns/named.in) | Local DNS zone/configuration file. |
| [`dns/named.zoo`](dns/named.zoo) | Local DNS zone/configuration file. |
| [`dns/named.127`](dns/named.127) | Local/reverse zone (`127`). |
| [`dns/named.206`](dns/named.206) | Local/reverse zone (`206`). |
| [`dns/CNN_info.txt.rtf`](dns/CNN_info.txt.rtf) | Informational note associated with the server. |

---

See also: [The POPs](../README.en.md) ·
[Later POPs](../later-pops/README.en.md) ·
[Network growth 1995 → 1996](../../../docs/13-network-growth-1995-1996.en.md)
