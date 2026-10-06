🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# La LAN dell'ufficio

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../LICENSE)

L'ufficio di Milano aveva una propria rete dietro l'interfaccia office del
firewall, separata dal backbone e dai segmenti dei server.

![Internet Force Office LAN 1995](../../images/internetforce_office_lan.png)

*Immagine completa [`images/internetforce_office_lan.png`](../../images/internetforce_office_lan.png) (Office LAN 1995). Documentaria: nessuna postazione è interattiva.*

L'ufficio (`intf-office`, `206.20.95.128/25`) era un ambiente di lavoro misto
Macintosh e Unix/Linux dietro l'interfaccia office del firewall: redazione e DTP
su Mac, area commerciale, authoring web e amministrazione tecnica su Linux
([workstation `marco`](../marco/README.md)). L'immagine documenta persone,
postazioni e ruoli; **non è interattiva** e non ha pagine per le singole
postazioni.

Una fotografia storica dell'ufficio è conservata in
[`artifacts/photographs/`](../../artifacts/photographs/README.md).

## Rete

- `206.20.95.128/25`, la metà alta del blocco di Milano `206.20.95.0/24`.
- Interfaccia office del firewall `le0`: `206.20.95.129`.
- Hub dell'ufficio: un **3Com LinkBuilder FMS** (LinkBuilder FMS II, modello
  3C16670) a `206.20.95.254` — un dominio di collisione 10Base-T condiviso, non
  uno switch.
- L'ufficio usava micro-transceiver Allied Telesyn AUI/10BaseT per collegare le
  apparecchiature all'hub.

## Sistemi collegati

Il segmento dell'ufficio portava le macchine di sviluppo e amministrative e i
computer desktop:

| Host | Indirizzo | Note |
|---|---|---|
| `firewall` (interf. office) | 206.20.95.129 | gateway del segmento |
| `dvlp` | 206.20.95.130 | host di sviluppo/build |
| `anna` | 206.20.95.131 | segreteria / customer care |
| `franz` | 206.20.95.132 | workstation ufficio (direzione commerciale) |
| `maxi` | 206.20.95.133 | workstation ufficio (area commerciale) |
| `html` | 206.20.95.134 | workstation contenuti web |
| `laura` | 206.20.95.135 | redazione / DTP |
| `alice` | 206.20.95.136 | redazione / DTP |
| `salvatore` | 206.20.95.137 | art direction / grafica |
| `maus` | 206.20.95.138 | supporto tecnico hardware |
| `pascal` | 206.20.95.139 | direzione IT |
| `marco` | 206.20.95.140 | workstation dell'amministratore |
| `PcDemo` | 206.20.95.141 | PC dimostrativo |
| `oracolo` | 206.20.95.142 | [host database/web successivo](../oracolo/README.md) |

`anna` copriva la **segreteria** e il **customer care**: riceveva gli ordini
dall'area commerciale, inseriva ordini e anagrafiche nel gestionale, inviava a
Marco i dati necessari all'attivazione tecnica degli account e rispondeva alle
richieste dei clienti, comprese quelle via email.

Le macchine dell'ufficio erano un misto di PC e Mac, tipico di un ufficio
italiano di metà anni Novanta. La workstation di Marco (`marco`) usava Slackware Linux 2.1
con X11 ed era la stazione di amministrazione e monitoraggio.

## Nomi alternativi nei reperti recuperati

Gli snapshot DNS e `/etc/hosts` recuperati etichettano alcuni indirizzi della LAN
dell'ufficio anche con nomi aggiuntivi o alternativi, tra cui `aps`, `cust2` e
`isa`. Sono trattati come uno **strato di denominazione storica** presente nel
materiale di configurazione recuperato, non come i nomi principali delle
macchine e non come sostituti della nomenclatura usata nella ricostruzione.

`aps` era il nome dell'azienda / partita IVA personale di Pascal: questo rende
significativa la sua presenza nel materiale storico, ma il repository **non
deduce né afferma** una corrispondenza uno-a-uno tra quei nomi e specifici host
o indirizzi.

La nomenclatura reader-facing della ricostruzione (`laura`, `alice`,
`salvatore`, `maus`, `pascal`, e le altre) è quella mantenuta; il contesto
organizzativo è in [Persone, macchine e workflow](../../docs/15-people-and-workflows.md).

## Gestione

L'hub dell'ufficio era monitorato via SNMP da tkined (compare nella mappa
recuperata con uno stripchart di carico interfaccia), e la rete dell'ufficio era
il perimetro protetto da cui si amministravano la GUI del firewall e i server.
Le regole 10, 11 e 14 di FireWall-1 esprimono i percorsi amministrativi e X11 da
questo segmento.

## UPS

Un UPS proteggeva le apparecchiature centrali sul lato backbone ed era
monitorato per raggiungibilità da tkined.

---

Vedi anche: [Panoramica dell'architettura](../../docs/01-architecture.md) ·
[Il firewall](../firewall/README.md) · [Monitoraggio](../../docs/08-monitoring.md)
