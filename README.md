🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# Internet Force 1995–1996 — una ricostruzione tecnica di Marco Iannacone

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](LICENSE)
> **Repository:** https://github.com/pippocom/internetforce-1995

Internet Force è stato un Internet Service Provider italiano nato a Milano nel
1995. Fu progettato fin dall'inizio come ISP - non come una BBS cresciuta fino
a diventarlo - con un backbone privato, quattro Point of Presence regionali,
una piattaforma centrale di servizi su macchine UNIX Sun, un gateway di sicurezza
Check Point FireWall-1 e un collegamento internazionale dedicato verso IDT a
New York.

Questo repository ricostruisce come il servizio funzionava davvero, usando
l'archivio di configurazioni recuperato e la testimonianza diretta di Marco Iannacone, che
ha costruito e gestito l'infrastruttura come unico amministratore di sistema
e di rete. La documentazione è scritta per chi vuole capire l'architettura e
il funzionamento quotidiano, non solo ammirare l'hardware.

## Esplora Internet Force

Tre percorsi complementari per esplorare la storia e l'archivio:

- **Costruire un Internet Force POP** - il percorso tecnico che mostra come
  l'infrastruttura del 1995 veniva messa insieme, dalla preparazione degli host
  Unix fino a routing, dial-up, autenticazione, DNS, posta, Web, sicurezza,
  monitoraggio e operatività.
  → [Costruire un POP, passo per passo](docs/00-build-an-isp.md)
- **Esplora la rete** - tre mappe storiche interattive per navigare visivamente
  l'infrastruttura del 1995 e aprire le schede dei sistemi e le
  configurazioni sopravvissute.
  → [Esplora Internet Force](https://pippocom.github.io/internetforce-1995/)
- **Leggi la storia** - l'articolo di Marco Iannacone pubblicato su Codemotion
  insieme al repository racconta il recupero dell'archivio e il funzionamento
  quotidiano di Internet Force, dai modem ai sistemi Unix, dai POP al Welcome Kit.
  → [*Archeologia di un ISP: come funzionava davvero un Internet provider nel 1995*](publications/codemotion-2026/README.md)

## Il sistema in sintesi (1995)

- **Confine internazionale** - un Cisco 2501 nel sito centrale, collegato a
  IDT/NYC, inizialmente a 128 kbit/s e portato a 2 Mbit/s circa sei mesi dopo
  il lancio.
- **Backbone** — una rete privata `10.0.0.0/8` che univa il sito centrale, il
  firewall e i router dei POP.
- **Sicurezza** — un Sun SPARCstation 5 con Check Point FireWall-1 2.0a, con
  interfacce separate per i server DATA e USERS, la LAN dell'ufficio e il lato
  world/backbone.
- **Servizi centrali** — una coppia di Sun SPARCstation 5: DATA (DNS, FTP,
  news, mailing list, web/VIF) e USERS (autenticazione, posta, home dei
  clienti, web personale, DNS secondario).
- **POP** — Milano (nella stessa sede del centrale, dove il Cisco 2501
  centrale/world fa da router e il 2511 locale da access server), Pesaro,
  Palermo e Gorgonzola, ciascuno con un router POP Cisco 2501 e un access
  server Cisco 2511 che alimentava un banco di 16 modem US Robotics 28.8
  kbit/s.
- **Autenticazione** — XTACACS su USERS, usato da ogni access server.
- **Sviluppo** — un host di build separato, uno SPARCstation 4, sulla LAN
  dell'ufficio.

## Come leggere questo repository

Il repository ha più punti d'ingresso complementari e un breve contesto culturale.

### 1. Costruire l'ISP — percorso narrativo

[**Costruire un ISP come Internet Force, passo per passo**](docs/00-build-an-isp.md)
guida il lettore partendo da sistemi operativi appena installati e seguendo i
passi reali di configurazione che trasformano un insieme di macchine Unix,
router, banchi modem e collegamenti di rete in un provider funzionante.

Non è richiesta una conoscenza pratica preliminare di Unix o Linux: ogni
concetto Unix (`/etc`, `/dev`, `root`, un daemon, `inetd`, `chmod`, `chroot`, …)
viene spiegato nel punto in cui serve. La sessione dial-up è **un capitolo** di
questo percorso più ampio, non l'intero percorso.

1. [Costruire un ISP, passo per passo](docs/00-build-an-isp.md) — la sequenza
   educativa completa.
2. [La sessione dial-up](docs/02-dialup-session.md) — dal PC del cliente e dal
   gruppo di caccia telefonico, attraverso il banco modem e l'access server
   Cisco, attraverso l'autenticazione XTACACS, fino a Internet.
3. [Autenticazione (XTACACS)](docs/10-authentication-tacacs.md) — come ogni
   access server validava gli utenti su USERS.
4. [DNS](docs/03-dns.md) — come si risolvevano i nomi una volta stabilita la
   sessione.
5. [Posta elettronica](docs/04-email.md) — SMTP, POP3 e IMAP per i clienti.
6. [Web, FTP, news e mailing list](docs/05-web-news-ftp.md) — i servizi
   pubblici raggiunti dal cliente e l'hosting Web offerto anche alle aziende.
7. [Il Welcome Kit cliente](artifacts/customer-welcome-kit/README.md) — il
   manuale, il programma cliente Easy!, i dischetti di installazione e il
   packaging originale forniti ai nuovi clienti.
8. [Il Listino Aziende del 1996](artifacts/company/business-services-price-list-1996/README.md)
   — connettività business, IP statici e LAN, domini, DNS, pagine Web e hosting
   in tagli da 1, 5 e 10 MB.

### 2. Esplorare per sistema e infrastruttura

Ideale per capire l'architettura componente per componente:

- [Panoramica dell'architettura](docs/01-architecture.md) — topologia,
  indirizzamento, configurazione degli host e segmentazione.
- [Indirizzamento IP: spazio pubblico, backbone privato e dipendenza dal
  carrier](docs/24-ip-addressing-and-provider-space.md) — perché un ISP del 1995
  aveva bisogno di spazio pubblico instradato e come cambiò con i carrier.
- [Crescita della rete 1995 → 1996](docs/13-network-growth-1995-1996.md) — i
  POP successivi e le espansioni.
- [La chiusura di Internet Force e le evoluzioni successive](docs/17-wind-down-and-migrations.md)
  — Enter, Pesaro Point, Pointest/Gorgonzola e Infosfera/Bergamo.
- [L'uplink Internet](systems/cisco-2501-uplink/README.md) — il Cisco 2501
  centrale.
- [I POP](systems/pops/README.md) — Milano, Pesaro, Palermo, Gorgonzola e i
  POP successivi.
- [Il firewall](systems/firewall/README.md) — FireWall-1 e la rule base reale.
- [DATA](systems/data/README.md) e [USERS](systems/users/README.md) — i server
  di servizio centrali.
- [DVLP](systems/dvlp/README.md) — sviluppo e build.
- [La LAN dell'ufficio](systems/office-lan/README.md) — la rete dell'ufficio di
  Milano.
- [VIF su SunOS](systems/sun-vif/README.md) — le interfacce virtuali per il
  virtual hosting.
- [Monitoraggio](docs/08-monitoring.md) — tkined e SNMP.
- [Inventario software](docs/11-software-inventory.md) — versioni e origini.
- [Xpert, IP accounting e XACCT](docs/25-xpert-ip-accounting-xacct.md) — come
  Internet Force usò nel 1995–1996 una delle prime versioni prototipali della
  tecnologia Xpert che sarebbe diventata XACCT.
- [Operazioni e backup](docs/14-operations-and-backup.md) — attività di routine.
- [Note storiche](docs/09-historical-notes.md) — Xpert UNIX Systems, il periodo
  di formazione a Tel Aviv e il contesto organizzativo.
- [Provenienza dell'archivio](docs/archive-provenance.md) — come sono stati
  recuperati i materiali.

### Contesto storico e culturale

Internet Force è nato dentro una cultura tecnica precisa. Come si acquisivano e
si condividevano le competenze in quella rete - manuali, RFC, pagine `man`, FAQ,
mailing list e Usenet, e l'attesa di documentarsi prima di chiedere - è
raccontato in
[Come si imparava Internet: competenza, autonomia e RTFM](docs/23-learning-internet-culture.md).

L'articolo Codemotion [*Archeologia di un ISP*](publications/codemotion-2026/README.md),
pubblicato da Marco Iannacone insieme a questo repository, ricostruisce inoltre
la storia complessiva dell'infrastruttura e del suo recupero trent'anni dopo.

## Cronologia

- **1995 — progettazione e lancio.** Xpert UNIX Systems (Israele) è il prime contractor per la
  progettazione; Marco si forma tra Milano e Tel Aviv; vengono costruiti l'hardware Sun,
  il backbone privato e il collegamento IDT. NCSA HTTPd, BIND 4, Sendmail
  8.6.12, XTACACS. Quattro POP. Il collegamento internazionale parte a
  128 kbit/s e viene poi portato a 2 Mbit/s.
- **1996 — crescita.** POP aggiuntivi (Tera, CNN, Fano, INDI, Seregno),
  capacità modem ampliata, un proxy cache CERN, migrazione da NCSA HTTPd ad
  Apache e SSH/SCP per l'amministrazione sicura. Il [Listino Aziende del 15
  giugno 1996](artifacts/company/business-services-price-list-1996/README.md)
  documenta anche l'offerta commerciale per imprese: connettività LAN, IP
  statici, linee dedicate, domini, DNS, realizzazione di pagine e hosting Web.
- **1996–1997 — chiusura e migrazione.** Internet Force chiude; i POP che
  continuano l'attività vengono resi progressivamente autonomi (Pesaro Point,
  Pointest/Gorgonzola, Infosfera/Bergamo) e solo dopo i clienti di Milano e i
  servizi centrali migrano su **Enter**. Vedi
  [La chiusura di Internet Force e le evoluzioni successive](docs/17-wind-down-and-migrations.md).

## Struttura del repository

```
docs/          documentazione narrativa (architettura, servizi, operazioni)
systems/       riferimento per sistema: uplink, pops, firewall, data, users,
               dvlp, office-lan, marco, oracolo, enter, infosfera-bergamo
artifacts/     materiali storici: welcome kit, documenti commerciali, inventari,
               manuali, foto, archivio email, Usenet, strumenti
publications/  articoli e pubblicazioni legati alla ricostruzione dell'archivio
site/          presentazione web statica
```

Il riferimento per sistema include anche le aree storiche `systems/marco/`,
`systems/oracolo/`, `systems/data/proxy-server/`, `systems/pops/cnn/`,
`systems/pops/gorgonzola/pointest/`, `systems/pops/pesaro/post-internet-force/`,
`systems/enter/` e `systems/infosfera-bergamo/`.

Il repository contiene anche i **file di configurazione recuperati**, accanto al
sistema a cui appartengono o sotto `artifacts/`. Ogni cartella ha una breve nota
che spiega cosa sono i file e come sono stati trattati credenziali e dati
personali; vedi [`artifacts/README.md`](artifacts/README.md).

---

Marco Iannacone ha costruito e gestito questa infrastruttura. Correzioni e
aggiunte basate sull'archivio recuperato sono benvenute.
