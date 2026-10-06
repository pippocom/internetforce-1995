🇮🇹 **Italiano** · [🇬🇧 English](16-router-and-wan.en.md)

# Router, WAN e connettività di rete

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

## Quale problema risolve

Un POP non è una rete isolata: deve portare il traffico dei clienti verso il
**backbone privato** di Internet Force e da lì verso Internet. Serve un router che
conosca le rotte del POP, il collegamento verso il sito centrale e la rotta di
default verso l'esterno.

## Come lo implementava Internet Force

Internet Force separava nettamente due ruoli (vedi
[Panoramica dell'architettura](01-architecture.md)):

- un **Cisco 2501** per l'instradamento: il 2501 centrale *world/uplink*, e un
  2501 in ogni POP remoto;
- un **access server Cisco 2511** (o 2509) per il banco modem, collegato al 2501
  da un link seriale (trattato nel capitolo [Dial-up](02-dialup-session.md)).

I POP adottavano lo stesso schema di indirizzamento: una `/26` privata
sull'Ethernet del router, un link seriale `/25` tra router e access server, e la
rete dial-up pubblica `/24`. Ogni router aveva una **rotta di default verso il
gateway world/backbone `10.0.0.1`**. IOS in uso: **10.2** sul 2501.

## Componenti e host

- Cisco **2501** centrale/world (uplink Internet + bordo IDT a New York).
- Cisco **2501** di ogni POP (`2501pesaro`, `2501gorgonzola`, `2501palermo`, …).
- Il link seriale router ↔ access server.
- Il backbone privato tra i POP e Milano.

## Configurazione rappresentativa

Esempio dalla configurazione recuperata del router di Pesaro
(`systems/pops/pesaro/2501.cfg`):

```text
hostname 2501pesaro
!
interface Ethernet0
ip address 10.0.3.1 255.255.255.192
!
interface Serial0
ip address 10.0.3.129 255.255.255.128
!
ip route 0.0.0.0 0.0.0.0 10.0.0.1
ip route 10.0.0.1 255.255.255.255 Ethernet0
ip route 206.20.115.0 255.255.255.224 10.0.3.130
ip route 206.20.115.64 255.255.255.224 10.0.3.130
```

La rotta di default punta al gateway del backbone; le rotte verso la rete
dial-up passano dall'access server (`10.0.3.130`). Questo è il pezzo che collega
il POP al resto della rete.

→ Configurazione completa: [`systems/pops/pesaro/2501.cfg`](../systems/pops/pesaro/2501.cfg)
→ Altre: [`systems/pops/`](../systems/pops/README.md) ·
[`systems/cisco-2501-uplink/config/2501.cfg`](../systems/cisco-2501-uplink/config/2501.cfg)

## Come si collega al resto del POP

Il router è il primo anello: porta il traffico al backbone; l'access server
collega i modem (capitolo dial-up); i server Unix (DATA, USERS) forniscono i
servizi. Vedi anche la configurazione di rete lato host in
[Unix e rete](01-architecture.md).

## Materiale originale correlato

- [`systems/cisco-2501-uplink/TECHNICAL.md`](../systems/cisco-2501-uplink/TECHNICAL.md)
- [`systems/cisco-2511-pop/TECHNICAL.md`](../systems/cisco-2511-pop/TECHNICAL.md)
- [`systems/pops/README.md`](../systems/pops/README.md)
- [`systems/data/system/rc.route`](../systems/data/system/rc.route) (rotta lato host)

*Fonti: configurazioni Cisco originali. Il manuale operativo
originale è in [`artifacts/operations-manuals/manual.md`](../artifacts/operations-manuals/manual.md).*

---

← [Costruire un POP](00-build-an-isp.md) ·
Precedente: [Unix e preparazione dell'host](01-architecture.md) ·
Prossimo: [Dial-up](02-dialup-session.md) →
