[🇮🇹 Italiano](TECHNICAL.md) · 🇬🇧 **English**

# Cisco 2511 --- modems, PPP and XTACACS

> **Internet Force 1995--1996 Historical Archive**\
> Historical reconstruction and technical documentation based on
> original Internet Force materials preserved by **Marco Iannacone**.\
> Author and archive curator: **Marco Iannacone** · https://pippo.com

The Cisco 2511 was the POP **access server**, turning a telephone call
terminated by a modem into an IP session.

Recovered initial configurations show 16 asynchronous lines
(`line 1 16`). The asynchronous interfaces use PPP and contain
`encapsulation ppp`, `ip unnumbered Ethernet0` and per-line default IP
configuration.

All initial 2511s point to:

``` text
tacacs-server host 206.20.95.4
```

That host was USERS, running `xtacacsd`. Authentication was therefore
centralized.

In the recovered Pesaro 2511 configuration the TACACS server and its
services are declared globally:

``` text
tacacs-server host 206.20.95.4
tacacs-server extended
tacacs-server authenticate connections
tacacs-server authenticate slip always
tacacs-server notify connections
tacacs-server notify enable
tacacs-server notify logout
tacacs-server notify slip
```

Line authentication was then requested in the line configuration, in the
`line 1 15` block:

``` text
line 1 15
 exec-timeout 0 0
 login tacacs
```

The recovered file does not contain a separate TACACS accounting
directive: the lines present are those above.

In remote POPs the 2511 and 2501 were complementary: the access server
terminated subscriber sessions, while the 2501 routed the POP toward the
backbone.

## Full configurations

The recovered configurations of the four access servers:

- [`systems/pops/milano/2511.cfg`](../pops/milano/2511.cfg)
- [`systems/pops/pesaro/2511.cfg`](../pops/pesaro/2511.cfg)
- [`systems/pops/palermo/2511.cfg`](../pops/palermo/2511.cfg)
- [`systems/pops/gorgonzola/2511.cfg`](../pops/gorgonzola/2511.cfg)

## Continue exploring

-   [Cisco 2501 technical guide](../cisco-2501-uplink/TECHNICAL.en.md)
-   [The dial-up session](../../docs/02-dialup-session.en.md)
-   [Architecture overview](../../docs/01-architecture.en.md)
