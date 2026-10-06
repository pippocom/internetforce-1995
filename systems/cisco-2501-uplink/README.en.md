[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# Cisco 2501 — Internet uplink

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../LICENSE)

The central Cisco 2501 was the edge of the Internet Force network. It sat at
the Milan central site, on the `10.0.0.0/8` backbone (the "world" side), and
carried all Internet traffic to and from the provider.

## Hardware and role

- Model: Cisco 2501, IOS 10.2.
- Hostname in the surviving configuration: `2501internet`.
- Backbone Ethernet: `10.0.1.1/24`, known in `/etc/hosts` as `intf-idt`.
- It was the default gateway of the firewall (`fwall.etc/defaultrouter` =
  `intf-idt`) and the point where the private backbone met the public
  Internet.

## Interfaces

```
interface Ethernet0
 ip address 10.0.1.1 255.255.255.0

interface Serial0
 ip address 206.20.64.30 255.255.255.252
 encapsulation frame-relay
 bandwidth 128
 frame-relay lmi-type ansi
 frame-relay map ip 206.20.64.29 150
```

Serial0 faced IDT in New York. The initial link ran at **128 kbit/s** - the
`bandwidth 128` in the surviving configuration reflects that first phase -
and was upgraded to **2 Mbit/s** approximately six months after launch.

## Routing

```
ip default-gateway 206.20.64.29
ip default-network 199.248.149.0
ip route 10.0.0.0   255.0.0.0     10.0.0.1
ip route 199.248.149.0 255.255.255.0 206.20.64.29
ip route 206.20.95.0 255.255.255.0 10.0.0.1
```

The router sent Internet-bound traffic to IDT and internal traffic toward
the firewall world interface (`10.0.0.1`). It carried routes for the POP
dial networks (`206.20.115.0/24`, `206.20.224.0/24`, `206.20.225.0/24`), and
in the later configuration for the 1996 networks as well
(`206.20.226.0/24` … `206.20.231.0/24`).

An outbound access list on the serial link permitted traffic whose source
was an Internet Force network, and a priority group gave interactive and DNS
traffic the highest priority, web traffic medium, and FTP/SMTP lower.

## Management

The router ran SNMP v1 with a read-only community and was monitored from
tkined. It was reached by telnet from the office/administration network.

## Configuration provenance

The surviving configuration corresponds to the central World/Milano Cisco 2501
documented on this page. The recovered file is a **later/merged revision**: it
includes, for example, POP routes added in 1996. It should therefore not
automatically be interpreted as a byte-exact snapshot of the 1995 launch
configuration.

The same configuration appears twice in the recovered archive - once as the
uplink's own file and once in the Xpert reference directory - with identical
addressing. The uplink's canonical description is this page; the
configuration file is kept with the recovered reference material.

---

See also: [Architecture overview](../../docs/01-architecture.en.md) ·
[Network growth](../../docs/13-network-growth-1995-1996.en.md) ·
[Uplink configuration](config/README.en.md)
