🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# Configurazione di rete del firewall

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../LICENSE)

La configurazione di routing e di rete del gateway FireWall-1.

| File | Descrizione |
|---|---|
| `rc.route` | Configurazione di interfacce e rotte (le cinque interfacce, rotte host-specific, rotte dei POP, rotta di default) (**originale**). |
| [`rc.local`](rc.local) | Lo script di avvio del firewall: avvio di FireWall-1 (`fwstart`), dell'accounting dial-up e degli altri servizi di ruolo (**originale**). |
| `rc-route.fw` | La configurazione di routing del firewall come recuperata nelle note operative. |
| `netmasks`, `networks`, `hosts` | Tabelle di rete, incluse le reti dei POP e del 1996. |
| `resolv.conf`, `defaultdomain`, `defaultrouter` | Configurazione del resolver e della rotta di default. |
| `ntp.conf` | Server di tempo. |
| `inetd.conf` | I pochi servizi abilitati sul firewall. |

`rc.route` e `rc.local` sono **ORIGINALI**; gli altri file sono **ORIGINALI
SANITIZZATI**. La disposizione delle interfacce e il routing sono descritti in
[Panoramica dell'architettura](../../../docs/01-architecture.md) e
[Il firewall](../README.md). Lo script di hardening `fixperms` è in
[`../system/fixperms`](../system/fixperms).
