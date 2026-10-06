[🇮🇹 Italiano](22-unix-host-preparation.md) · 🇬🇧 **English**

# Preparing a Unix host

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

## What problem this solves

A freshly installed operating system works, but it is not yet an Internet Force
host. To become one it must know **who it is** (network identity), **where it is**
(address, netmask, local network), **how to get out** (default route), **what to
start** at boot and **who may do what** (accounts and permissions). This chapter
covers that preparation, from a bare system to its operational role.

## How Internet Force implemented it

On SunOS, preparation followed a text-file model, rebuilt at every boot by the
`rc` scripts:

- **identity:** `hostname`, local domain `internetforce.com`
  (`/etc/defaultdomain`) and `/etc/hosts` with the machines on the network;
- **interfaces:** the address on `le0` (SunOS) with `ifconfig`, netmasks in
  `/etc/netmasks`;
- **default route:** `/etc/defaultrouter` named the router (`intf-idt` on the
  firewall), and `rc.route` rebuilt the host-specific routes at every boot;
- **service startup:** `rc.local` started the local daemons (portmapper, etc.);
- **permissions:** a `fixperms` script restored the correct owner on system
  binaries and fixed the cases flagged by the security checks;
- **accounts:** service accounts used non-interactive shells (e.g. `/bin/nosh`)
  to limit their use.

The result was a host that, on every reboot, rebuilt its own network
configuration and services by itself.

## Components and hosts

Every Internet Force host followed the same model: **DATA**, **USERS**,
**FIREWALL**, **DVLP** and the **MARCO** workstation (Linux/Slackware, with its
own `rc.*` scripts). On SunOS the interface was `le0`; on Linux it could be
`eth0`.

## Representative configuration

The route (route in English, the path IP packets must follow) was
rebuilt at every boot on DATA (`systems/data/system/rc.route`): the
default route points at the firewall, not directly at the Internet.

```sh
hostname=`hostname`
route delete intfnet $hostname
route add $hostname $hostname 0
route add default fw-$hostname 1
```

The local network identity, instead, was defined by static files. From the
firewall (`systems/firewall/network/defaultrouter` and `defaultdomain`):

```text
intf-idt
internetforce.com
```

→ Complete files: [`systems/data/system/rc.route`](../systems/data/system/rc.route) ·
[`systems/firewall/network/defaultrouter`](../systems/firewall/network/defaultrouter) ·
[`systems/firewall/network/netmasks`](../systems/firewall/network/netmasks) ·
[`systems/data/system/rc.local`](../systems/data/system/rc.local) ·
[`systems/firewall/system/fixperms`](../systems/firewall/system/fixperms)

## How it connects to the rest of the POP

A prepared host is the precondition for everything else: without an address and
a default route it cannot talk to the [router/WAN](16-router-and-wan.en.md); the
network identity and `/etc/hosts` are the basis of [DNS](03-dns.en.md); accounts
and permissions are the basis of [authentication](10-authentication-tacacs.en.md),
[mail](04-email.en.md), [web](05-web-news-ftp.en.md) and [FTP](05-web-news-ftp.en.md).
See also the [Architecture overview](01-architecture.en.md) for the physical
context.

## Related original material

- [`systems/data/system/`](../systems/data/system/README.en.md) — `rc.local`, `rc.route`, `inetd.conf`, `passwd`.
- [`systems/users/system/`](../systems/users/system/README.en.md) — preparing the USERS host.
- [`systems/firewall/network/`](../systems/firewall/network/README.en.md) — network identity, netmasks, routes.
- [`systems/marco/`](../systems/marco/README.en.md) — `rc.*` scripts on Linux.
- [`artifacts/operations-manuals/manual.md`](../artifacts/operations-manuals/manual.en.md) — original operations manual.

*Sources: original configuration files.*

---

← [Build a POP](00-build-an-isp.en.md) ·
Previous: [Architecture](01-architecture.en.md) ·
Next: [Router, WAN](16-router-and-wan.en.md) →
