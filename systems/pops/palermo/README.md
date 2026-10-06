🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# POP di Palermo

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../LICENSE)

Palermo segue il disegno standard dei POP remoti: un router Cisco 2501 per il
collegamento al backbone e un access server Cisco 2511 per il banco modem.

## Router (Cisco 2501)

- Hostname `2501palermo`, IOS 10.2.
- Ethernet0: `10.0.4.1/26` (segmento privato `10.0.4.0/26`).
- Serial0: `10.0.4.129/25`, punto-punto verso il 2511 a `10.0.4.130`.
- Rotta di default verso il gateway world/backbone (`10.0.0.1`).
- Portava la rete dial-up di Palermo `206.20.224.0/24` e la sottorete clienti
  `206.20.224.64/27` verso il 2511.

## Access server (Cisco 2511)

- Hostname `2511palermo`, IOS 10.2.
- Ethernet0: `206.20.224.65/27` sulla sottorete `206.20.224.64/27`.
- 16 linee asincrone, PPP, `ip unnumbered Ethernet0`.
- Indirizzi di default dei clienti `206.20.224.2` … `206.20.224.17`.
- `tacacs-server host 206.20.95.4`, autenticazione centrale.

## Accesso telefonico

Il POP pubblicava un numero voce e un numero tecnico diretto, più un blocco di
linee modem instradate dal gruppo di caccia telefonico. I numeri sono registrati
nelle note operative recuperate.

## Note

Palermo compare nella mappa tkined recuperata sia con il suo 2501 (`10.0.4.1`)
sia con il suo access server (`10.0.4.130`), con stripchart di carico
interfaccia su entrambi i link Ethernet e seriale.

---

Vedi anche: [I POP](../README.md) ·
[L'uplink Internet](../../cisco-2501-uplink/README.md) ·
[La sessione dial-up](../../../docs/02-dialup-session.md)
