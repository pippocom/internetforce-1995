🇮🇹 **Italiano** · [🇬🇧 English](13-network-growth-1995-1996.en.md)

# Crescita della rete 1995 → 1996

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

L'architettura iniziale del 1995 aveva quattro POP. Nel corso del 1996
Internet Force ampliò la copertura con POP aggiuntivi e nuovi blocchi di
indirizzi, e firmware e alcuni modelli di access server cambiarono con la
crescita della rete. Questa pagina documenta quella seconda fase separatamente
dal progetto iniziale.

## Nuovi POP

| POP | Router | Access server | Blocco indirizzi | Note |
|---|---|---|---|---|
| Seregno | — | — | 206.20.226.0/24 | riservato; il blocco compare nella lista reti del firewall |
| Tera | 2501 su `10.0.7.1` | Cisco **2509** su `206.20.227.65` | 206.20.227.0/24 | dominio `tera-it.com` |
| CNN | 2501 su `10.0.8.1` | 2511 su `206.20.228.65` | 206.20.228.0/24 | dominio `cnn.it`; DNS/auth locali inizialmente |
| Fano | 2501 su `206.20.115.66` | 2511 su `206.20.230.65` | 206.20.230.0/24 | sotto-POP di Pesaro, 4 linee |
| INDI | 2501 su `10.0.10.1` | (collegato in frame-relay) | 206.20.231.0/24 | collegamento nazionale verso Albacom |

Lo schema funzionale resta quello del 1995: un **router** per il collegamento
al backbone e un **access server** per il banco modem, con autenticazione
centralizzata. Due dettagli sono specifici di questa fase:

- **Tera** usava un access server Cisco **2509** invece di un 2511. Il 2509 è il
  router async più piccolo della stessa famiglia; svolge esattamente il ruolo di
  access server.
- **CNN** doveva funzionare in modo più locale, e il suo router inizialmente
  puntava l'autenticazione a un indirizzo locale con una password di
  last-resort, e in seguito usava un server DNS Windows NT locale - una
  deviazione dal modello centralizzato, consentito grazie alle consulenze di Marco in una fase
  in cui Internet Force si avviava alla chiusura.

## Nuovi blocchi di indirizzi

`/etc/networks` e `/etc/netmasks` del firewall guadagnarono:

| Rete | Nome | POP |
|---|---|---|
| 206.20.226.0/24 | intf-seregno | Seregno |
| 206.20.227.0/24 | intf-tera | Tera |
| 206.20.228.0/24 | intf-cnn | CNN |
| 206.20.230.0/24 | intf-fano | Fano |
| 206.20.231.0/24 | intf-indi | INDI |

Le corrispondenti zone inverse furono aggiunte al DNS, e i nuovi domini clienti
(`tera-it.com` e il secondario `cnn.it`) furono serviti accanto a quelli
esistenti.

## Collegamenti regionali

Invece di collegare ogni nuovo POP direttamente al backbone di Milano, i POP
nazionali erano collegati in un piccolo albero:

- **Fano** pendeva da Pesaro sul collegamento seriale `10.0.9.128/25`, con
  Pesaro che instradava la rete di Fano `206.20.230.0/24` verso il backbone.
- **INDI** era raggiunta con un collegamento **frame-relay** tra Milano/Pesaro e
  il sito INDI, usando l'intervallo `10.0.10.0/24` sui link seriali
  (`POP_albacom-CISCO_configuration.txt` registra le mappe frame-relay per i
  lati di Milano e Pesaro).

È lo stesso approccio hub-and-spoke usato nel 1995, esteso di un livello più in
profondità perché un piccolo POP di provincia potesse essere servito attraverso
un vicino più grande.

## Routing statico e l'evoluzione pianificata

Con un solo collegamento upstream, il routing statico era una scelta naturale:
per il traffico destinato all'esterno di Internet Force esisteva sostanzialmente
un'unica via di uscita, quindi una default route verso il provider di
connettività era sufficiente. Introdurre un protocollo di routing dinamico
avrebbe aggiunto complessità senza un beneficio operativo corrispondente.

Xpert aveva indicato che l'introduzione di un protocollo di routing dinamico
avrebbe avuto senso con una successiva evoluzione dell'architettura: l'aggiunta
di un secondo collegamento verso un carrier italiano e il passaggio a un
Autonomous System proprio. Con più collegamenti indipendenti, eventualmente
distribuiti geograficamente, sarebbe invece diventato necessario gestire
dinamicamente i percorsi interni verso i diversi punti di uscita.

In quel disegno IGRP avrebbe gestito il routing interno. IGRP è un protocollo di
routing interno e non crea né definisce di per sé un Autonomous System: lo status
di Autonomous System e i molteplici collegamenti riguardavano l'architettura di
routing esterna. Si trattava di funzioni tecnicamente diverse, ma componenti
della stessa evoluzione pianificata.

Internet Force chiuse prima che questa evoluzione venisse realizzata.

## Firmware ed evoluzione dei servizi nel 1996

Accanto ai nuovi POP, il 1996 portò l'installazione di:

- Cisco IOS **11.0** sui nuovi router (i router del 1995 giravano 10.2/10.3);
- un **proxy cache CERN httpd 3.0** sulla rete centrale;
- la migrazione da **NCSA HTTPd ad Apache**;
- **SSH/SCP** per l'amministrazione sicura, in sostituzione di
  telnet/rlogin/rsh e FTP;
- capacità modem ampliata, in particolare a Milano.

La rete iniziale a quattro POP del 1995 e questa crescita del 1996 sono
documentate deliberatamente come due fasi, così che la configurazione successiva
non venga letta a ritroso nell'architettura di lancio.

La procedura operativa realmente seguita per aggiungere e configurare un POP è
conservata nel HOWTO originale
[`systems/pops/CISCO-add_new_pop-HOWTO.txt`](../systems/pops/CISCO-add_new_pop-HOWTO.txt).

---

Vedi anche: [Panoramica dell'architettura](01-architecture.md) ·
[I POP](../systems/pops/README.md) · [Note storiche](09-historical-notes.md)
