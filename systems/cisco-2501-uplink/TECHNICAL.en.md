[🇮🇹 Italiano](TECHNICAL.md) · 🇬🇧 **English**

# Cisco 2501 --- technical configuration guide

> **Internet Force 1995--1996 Historical Archive**\
> Historical reconstruction and technical documentation based on
> original Internet Force materials preserved by **Marco Iannacone**.\
> Author and archive curator: **Marco Iannacone** · https://pippo.com

The Cisco 2501 performed the **routing** role. This guide selects a few
lines from the recovered configurations and explains them; it does not
replace the complete historical files.

## Central 2501 toward IDT

Recovered configuration includes:

``` text
interface Ethernet0
 ip address 10.0.1.1 255.255.255.0
```

and on the international side:

``` text
interface Serial0
ip address 206.20.64.30 255.255.255.252
ip access-group 111 out
encapsulation frame-relay
bandwidth 128
priority-group 5
frame-relay lmi-type ansi
frame-relay map ip 206.20.64.29 150
```

`bandwidth 128` is an IOS parameter consistent with the initial 128
kbit/s phase; it does not itself set the physical circuit speed.
International capacity was later upgraded to 2 Mbit/s approximately six
months after launch.

The default route and default network in the same configuration:

``` text
ip default-gateway 206.20.64.29
ip default-network 199.248.149.0
ip route 199.248.149.0 255.255.255.0 206.20.64.29
```

`ip default-network 199.248.149.0` named the candidate default network;
the static route toward `206.20.64.29` made it reachable through the IDT
side.

## Remote POP routers

Pesaro, Palermo and Gorgonzola each had a 2501 connecting the local 2511
to the backbone. In the recovered Pesaro configuration the serial side
toward the 2511 is `10.0.3.129/25`:

``` text
interface Serial0
ip address 10.0.3.129 255.255.255.128
encapsulation ppp
bandwidth 64
```

and some representative routes:

``` text
ip route 0.0.0.0 0.0.0.0 10.0.0.1
ip route 10.0.9.128 255.255.255.128 10.0.3.130
ip route 206.20.230.32 255.255.255.224 206.20.115.66
ip route 206.20.230.64 255.255.255.224 206.20.115.66
```

## Reading a static route

Conceptually:

``` text
ip route <destination-network> <mask> <next-hop>
```

In the recovered Pesaro configuration the two dial-up subnets
`206.20.115.0/27` and `206.20.115.64/27` are associated with the 2511
(`10.0.3.130`):

``` text
ip route 206.20.115.0 255.255.255.224 10.0.3.130
ip route 206.20.115.64 255.255.255.224 10.0.3.130
```

These routes send dial-up traffic to the 2511, which terminates the
customer sessions; the rest follows the default route toward the
backbone.

## Full original configurations

- Central 2501: [`config/2501.cfg`](config/2501.cfg)
- Pesaro 2501: [`../pops/pesaro/2501.cfg`](../pops/pesaro/2501.cfg)
- Palermo 2501: [`../pops/palermo/2501.cfg`](../pops/palermo/2501.cfg)
- Gorgonzola 2501: [`../pops/gorgonzola/2501.cfg`](../pops/gorgonzola/2501.cfg)

## Continue exploring

-   [Cisco 2511 technical guide](../cisco-2511-pop/TECHNICAL.en.md)
-   [The dial-up session](../../docs/02-dialup-session.en.md)
-   [Architecture overview](../../docs/01-architecture.en.md)
