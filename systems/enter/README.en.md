[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# The Enter transition environment

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../LICENSE)

**Enter** was the destination Internet Force chose for migrating the remainder of its
Milanese customers and central services. It was not a former POP: it was the environment into which
Internet Force moved (through a consultancy by Marco) its operations as it wound down.

## Content

The configurations and material in this area document:

- the Cisco configurations of the Internet Force/Enter environment (`cisco/`);
- the DNS set (`etc/named.boot`, `etc/named.data/…`), with Enter authoritative
  for `internetforce.com`, `intf.com`, `enter.it` and other zones, plus the
  reverse zones `194.20.50`, `194.185.74`, `194.185.100`, `206.20.95`;
- the machine `marco` in the Enter network at `194.20.50.14`, with the
  `mailhost`, `users`, `mail`, `loghost` roles and the MX for `internetforce.com`
  and `intf.com` converging on it; the `news` feed points to `news.enter.it`;
- the account databases `etc/PASSWD` and `etc/passwd.txt`.

The set documents the transition described in
[The closure of Internet Force and the later evolutions](../../docs/17-wind-down-and-migrations.en.md).

## Provenance

These files come from the configurations preserved from the transition phase
towards Enter (autumn 1996).

---

See also: [Wind-down and migrations](../../docs/17-wind-down-and-migrations.en.md) ·
[Marco's workstation](../marco/README.en.md) · [The POPs](../pops/README.en.md)
