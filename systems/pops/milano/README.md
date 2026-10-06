🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# POP di Milano

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../LICENSE)

Milano è il luogo in cui sito centrale e POP dial-up coincidono. Il Cisco 2501
centrale fornisce l'uplink Internet, e il **Cisco 2511 di Milano** fornisce
l'accesso dial-up locale. Non esiste deliberatamente un 2501 POP separato per
Milano.

## Access server

- Cisco 2511, hostname `c2511IF`, IOS 10.2.
- Ethernet0: `10.0.2.1/24`; noto in DNS/hosts come `ts1`.
- 16 linee asincrone (`line 1 11`, `line 12`, `line 13 16`), ciascuna
  `encapsulation ppp`, `ip unnumbered Ethernet0`, `async mode interactive`.
- Indirizzi di default dei clienti `206.20.95.70` … `206.20.95.85`, dentro la
  sottorete dial-up `206.20.95.64/26`.
- Velocità di linea 115200 bit/s, flow control hardware, `modem ri-is-cd`.
- Esisteva un account `guest` sul terminal server che si collegava
  automaticamente a USERS, per un operatore che si avvicinava alla console.

## Routing

La rotta di default del 2511 punta al gateway world/backbone (`10.0.0.1`) nel
sito centrale, così il traffico dei clienti di Milano segue lo stesso percorso
di ogni altro POP: sul backbone fino al 2501 centrale e fuori verso IDT. Il
FireWall-1 centrale tiene una rotta per la sottorete dial-up (`206.20.95.64/26`)
che punta a `ts1`, perché sorveglia i segmenti dei server sullo stesso
backbone.

## Note

Poiché Milano ospitava la piattaforma centrale, la sua sottorete dial-up fa
parte del blocco di Milano `206.20.95.0/24` invece di una `/24` separata. I nomi
reverse DNS sono `ppp1-milano` … `ppp16-milano`.

---

Vedi anche: [I POP](../README.md) ·
[L'uplink Internet](../../cisco-2501-uplink/README.md) ·
[La sessione dial-up](../../../docs/02-dialup-session.md)
