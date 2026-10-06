🇮🇹 **Italiano** · [🇬🇧 English](08-monitoring.en.md)

# Monitoraggio

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

Il monitoraggio di rete e sistemi era costruito su **SNMP** e **Scotty/tkined**,
un'applicazione di gestione di rete in Tcl/Tk. La stazione di monitoraggio era
la workstation Linux/X di Marco sulla LAN dell'ufficio, ed è lì che fu creata la
mappa tkined recuperata - [`intf.snmp.map`](../artifacts/tkined/intf.snmp.map),
versione **1.3.4**.

## Perché serviva un monitoraggio centralizzato

Internet Force non era una rete locale: era un provider con server centralizzati
a Milano, POP remoti collegati da linee dedicate, un upstream internazionale
verso IDT e i pool dial-up dei POP da presidiare. Con un solo amministratore,
l'unico modo per accorgersi in tempo di un guasto - o per capire se un problema
era interno oppure esterno, oltre l'upstream - era osservare la rete da un unico
punto.

Un monitoraggio centralizzato serviva a:

- distinguere un guasto interno (router, access server, servizi di Milano) da un
  guasto sulla rete esterna o sull'upstream;
- raccogliere elementi oggettivi prima di aprire o sostenere una segnalazione
  tecnica verso il fornitore a monte;
- tenere visibile lo stato delle linee dedicate che collegavano i POP remoti a
  Milano, senza dipendere dalla memoria di una singola persona;
- osservare l'uso reale delle risorse - carico delle interfacce, linee dial-up
  occupate - invece di limitarsi a “tenere accesi i modem”.

## SNMP e tkined

**SNMP** (Simple Network Management Protocol, qui in versione 1) era il modo
standard con cui un dispositivo di rete esponeva il proprio stato: interfacce,
contatori di traffico, stato delle linee. Ogni apparato gestito eseguiva un
agente SNMP e pubblicava questi dati in strutture standard chiamate **MIB**; il
sistema di monitoraggio le interrogava con una community string di sola lettura.

**tkined** era l'applicazione di gestione di rete che faceva da console. Girava
sulla workstation Linux/X di Marco ed è lì che fu creata la mappa recuperata,
nella versione 1.3.4. tkined univa due cose diverse:

- una **mappa di topologia**: i dispositivi gestiti disegnati come nodi con le
  loro relazioni, cioè *dove* si trovano e *come* sono collegati;
- **misure dal vivo**: piccoli script Tcl avviavano controlli ricorrenti e
  disegnavano **stripchart** (grafici a scorrimento nel tempo) per il carico
  delle interfacce, gli utenti attivi e la raggiungibilità.

In breve: la mappa diceva *cosa* esisteva e come era collegato, gli stripchart
dicevano *come stava andando* in quel momento. Il formato del file di mappa è
simile a Tcl ma non è pensato per essere modificato a mano.

## Cosa veniva monitorato

La mappa tkined (versione 1.3.4) contiene i dispositivi gestiti e le loro
relazioni:

- il **World Hub** (`10.0.0.254`) e l'**hub dell'ufficio** (`206.20.95.254`, un
  3Com LinkBuilder FMS gestito via SNMP);
- il **Cisco 2501** centrale (`10.0.1.1`);
- i **router dei POP**: 2501 Palermo (`10.0.4.1`), 2501 Pesaro (`10.0.3.1`),
  2501 Gorgonzola (`10.0.5.1`);
- gli **access server**, con i loro indirizzi lato seriale (`10.0.2.1`
  Milano/ts1, `10.0.3.130` Pesaro, `10.0.4.130` Palermo, `10.0.5.130`
  Gorgonzola);
- i server: `firewall`, `data`, `users`, `dvlp` e il `marco` di Marco;
- l'**UPS**, con un controllo di raggiungibilità.

La mappa originale è consultabile qui:
[`artifacts/tkined/intf.snmp.map`](../artifacts/tkined/intf.snmp.map).

## Cosa raccoglieva

tkined forniva topologia viva più stripchart pilotati da piccoli script Tcl:

- **carico delle interfacce** su router, access server e hub — per esempio
  l'Ethernet e la Serial0 del 2501 centrale, e i collegamenti dei router dei
  POP: in pratica il traffico sulle singole tratte;
- **utenti attivi** sugli access server, che mostrava quante delle 16 linee di
  ogni POP fossero in uso, cioè l'**utilizzo dei modem** dei pool dial-up;
- **raggiungibilità** per dispositivi gestiti come l'UPS.

La mappa avvia job come `start_ifload_monitor` e un monitor degli utenti attivi
(`ip_monitor.tcl`) contro i dispositivi scoperti. I contatori delle interfacce
e lo stato delle linee venivano dai MIB SNMP standard esposti dai dispositivi
Cisco e dall'hub 3Com.

L'accesso SNMP usava la versione 1 con una community string di sola lettura,
configurata su ogni dispositivo Cisco (`snmp-server community … RO`) e sugli
hub. Il firewall permetteva il traffico di gestione solo sulla rete interna.

## Le mappe di monitoraggio

Oltre alla mappa principale della rete, nell'archivio sono conservate due mappe
tkined dedicate a punti di vista specifici. Sono **reperti storici** recuperati;
le immagini che le accompagnano sono **ricostruzioni grafiche moderne**, in
stile tkined, esplicitamente etichettate come tali e basate sui file originali -
non misure inventate.

### IDT Connectivity Monitor

Monitoraggio della **raggiungibilità Internet oltre l'upstream IDT**. Non
descrive la topologia interna del provider: serve a controllare se, una volta
uscito da Internet Force e da IDT, un nodo o una destinazione esterna mostri
segnali di degrado. Veniva usato per osservare il **round-trip time** verso host
di riferimento e il **carico di linea** in ingresso/uscita, individuare anomalie
persistenti su tratte o nodi esterni e raccogliere elementi utili per le
segnalazioni tecniche verso IDT.

- README: [`artifacts/monitoring/idt-connectivity/README.md`](../artifacts/monitoring/idt-connectivity/README.md)
- File storico: [`idt.snmp.map`](../artifacts/monitoring/idt-connectivity/idt.snmp.map)
- Ricostruzione moderna: [`InternetForce_IDT_connectivity_monitor_1995.png`](../artifacts/monitoring/idt-connectivity/InternetForce_IDT_connectivity_monitor_1995.png)

### Geographic POP Network Monitor

Monitoraggio della rete geografica su cui si attestavano le linee dedicate dei
POP remoti, etichettata nella mappa come **CDN -> Frame Relay Telecom**. Non
mostra i server del provider, ma lo stato del trasporto geografico che teneva i
POP collegati al backbone e ai servizi centralizzati di Milano: collegamenti dei
POP, host/router/endpoint della rete geografica e stripchart di utilizzo su
alcune interfacce chiave.

> Nota sull'etichetta «CDN»: il termine è ripreso dalla mappa recuperata e non è
> spiegato altrove nell'archivio. Qui non ne viene proposta un'interpretazione;
> la descrizione resta legata a ciò che la mappa mostra.

- README: [`artifacts/monitoring/geographic-pop-backbone/README.md`](../artifacts/monitoring/geographic-pop-backbone/README.md)
- File storico: [`indi.snmp.map`](../artifacts/monitoring/geographic-pop-backbone/indi.snmp.map)
- Ricostruzione moderna: [`InternetForce_geographic_pop_network_monitor_1995.png`](../artifacts/monitoring/geographic-pop-backbone/InternetForce_geographic_pop_network_monitor_1995.png)

## Tempo, log e statistiche

A integrazione del monitoraggio interattivo:

- **xntpd** teneva l'ora sincronizzata con server pubblici, il che rendeva
  coerenti i log multi-dispositivo;
- **syslog** sui server inoltrava a `loghost` (DVLP), così un solo host
  raccoglieva i log degli altri;
- job pianificati producevano **statistiche web e di posta**, facevano rotazione
  dei log e rigeneravano i dati di scadenza/avviso per gli account clienti.

Questa combinazione - grafici SNMP per la rete, log centralizzati per gli host e
report pianificati per i servizi - dava a un solo amministratore una vista
utilizzabile dell'intero provider.

## Configurazione rappresentativa

La mappa tkined recuperata (`artifacts/tkined/intf.snmp.map`, versione 1.3.4) è
codice Tcl generato: ogni nodo porta nome, indirizzo e attributi SNMP.

```text
set node18 [ ined -noupdate create NODE ]
ined -noupdate icon $node18 switch.xbm
ined -noupdate name $node18 {Office Hub}
ined -noupdate address $node18 206.20.95.254
ined -noupdate attribute $node18 SNMP:Config {-community public -address 206.20.95.254 -port 161 -version SNMPv1}
```

→ Mappa completa: [`artifacts/tkined/intf.snmp.map`](../artifacts/tkined/intf.snmp.map) ·
[`artifacts/monitoring/`](../artifacts/monitoring/geographic-pop-backbone/README.md)

---

Vedi anche: [Panoramica dell'architettura](01-architecture.md) ·
[Operazioni e backup](14-operations-and-backup.md) ·
[La LAN dell'ufficio](../systems/office-lan/README.md)

---

→ [Costruire un Internet Force POP, passo per passo](00-build-an-isp.md)
