🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# POP di Pesaro

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../LICENSE)

Pesaro è un POP remoto completo con il disegno standard a due router di
Internet Force: un Cisco 2501 per il collegamento al backbone e un Cisco 2511 per
il banco modem.

## Router (Cisco 2501)

- Hostname `2501pesaro`, IOS 10.2.
- Ethernet0: `10.0.3.1/26` (segmento privato `10.0.3.0/26`).
- Serial0: `10.0.3.129/25`, collegamento punto-punto verso il 2511 a
  `10.0.3.130`.
- Rotta di default verso il gateway world/backbone (`10.0.0.1`).
- Portava la rete dial-up di Pesaro `206.20.115.0/24` e la sottorete clienti
  `206.20.115.64/27` verso il 2511.

## Access server (Cisco 2511)

- Hostname `2511pesaro`, IOS 10.3.
- Ethernet0: `206.20.115.65/27` sulla sottorete `206.20.115.64/27`.
- 16 linee asincrone, PPP, `ip unnumbered Ethernet0`.
- Indirizzi di default dei clienti `206.20.115.2` … `206.20.115.17`.
- `tacacs-server host 206.20.95.4`, così i chiamanti si autenticavano
  centralmente.

## Sotto-POP di Fano

Pesaro fungeva anche da hub per il successivo POP **Fano**. Il collegamento
seriale `10.0.9.128/25` si connette al router di Fano a `206.20.115.66`, e
Pesaro instrada la rete di Fano `206.20.230.0/24` verso il backbone. Vedi
[POP successivi](../later-pops/README.md).

## Accesso telefonico

Il POP pubblicava un numero principale e diverse linee modem, con un gruppo di
caccia che instradava le chiamate verso un modem libero. I numeri dial-in e la
disposizione delle linee sono registrati nelle note operative recuperate.

## Note

L'archivio recuperato contiene anche una configurazione Pesaro/INDI superata
(`*-indi-old`), precedente alla rielaborazione dei collegamenti Fano e INDI;
è conservata come storia delle versioni, non come configurazione canonica.

## Fase successiva a Internet Force (1996–1997)

Le configurazioni del POP di Pesaro durante Internet Force sono quelle descritte
sopra. La directory [`post-internet-force/`](post-internet-force/) raccoglie
invece il materiale della fase successiva alla chiusura di Internet Force e
l'evoluzione verso **Pesaro Point** e l'autonomia locale, incluse le modifiche su
Fano già citate:

- `collaudo.txt` — il documento di collaudo datato **22 ottobre 1996**, firmato
  da Gennaro Mascini per Pesaro Point srl;
- `CISCO/` — configurazioni Cisco 2501/2511 (anche per Fano);
- `Named-NT/` — il named Windows NT;
- `marzo/` — le modifiche del **marzo 1997** (Cisco, routing, DNS NT, note Linux).

Questi file provengono dalle configurazioni conservate della fase successiva
alla chiusura di Internet Force, con l'evoluzione verso Pesaro Point e
l'autonomia locale.

---

Vedi anche: [Chiusura e migrazioni](../../../docs/17-wind-down-and-migrations.md) ·
[I POP](../README.md) ·
[L'uplink Internet](../../cisco-2501-uplink/README.md) ·
[Crescita della rete](../../../docs/13-network-growth-1995-1996.md)
