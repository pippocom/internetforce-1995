🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# Firewall

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../LICENSE)

Il gateway di sicurezza (Firewall) proteggeva i server centrali e la LAN dell'ufficio. Il
suo scopo era controllare l'accesso alle macchine che esponevano servizi -
DATA, USERS e lo SHELL pianificato, più la rete dell'ufficio - ciascuna con la
propria policy sulla propria interfaccia. I clienti dial-up stavano dal lato
world/backbone e non erano oggetto della protezione del firewall: chi si
collega via dial-up non espone servizi e quindi non ha bisogno di protezione.

![Scheda FIREWALL nella Systems Overview 1995](../../images/crops/firewall.png)

*Ritaglio da [`images/internetforce_server_map.png`](../../images/internetforce_server_map.png) (Systems Overview 1995).*

## Firewall-1: quando il firewall cominciò a capire le connessioni

Per comprendere quanto fosse avanzata nel 1995 l'adozione di Check Point FireWall-1, è utile ricordare quanto fosse ancora giovane il mercato dei firewall commerciali.

Le prime generazioni di firewall seguivano soprattutto due approcci. Il primo era il **packet filtering**: router e gateway decidevano se accettare o scartare ogni pacchetto sulla base di elementi come indirizzo IP, protocollo e numero di porta. Era un controllo relativamente semplice e, soprattutto, privo della conoscenza della conversazione a cui quel singolo pacchetto apparteneva.

Un secondo approccio consisteva negli **application proxy**. Il firewall terminava la connessione proveniente da una rete e ne apriva una nuova verso l'altra, utilizzando proxy specifici per servizi come FTP, SMTP o HTTP. All'inizio degli anni Novanta prodotti come DEC SEAL contribuirono alla nascita del mercato commerciale dei firewall; poco dopo, il Firewall Toolkit di Trusted Information Systems, sviluppato da Marcus Ranum e reso disponibile alla comunità Internet, portò questo modello nel mondo dei proxy applicativi. Dal suo codice sarebbe derivato anche il firewall commerciale TIS Gauntlet.

Check Point introdusse un approccio differente. Fondata nel 1993, sviluppò la tecnologia che chiamò **Stateful Inspection** e presentò FireWall-1 nel 1994.

L'idea era tanto semplice da spiegare quanto importante nelle conseguenze: il firewall non doveva più giudicare ogni pacchetto come se non avesse memoria di ciò che era successo prima. Manteneva invece informazioni sullo **stato delle connessioni**, poteva riconoscere se un pacchetto apparteneva a una sessione già autorizzata e applicare la policy nel contesto della comunicazione complessiva.

Era una soluzione che combinava parte della flessibilità del packet filtering con una conoscenza della connessione che i filtri statici non possedevano, senza richiedere necessariamente un proxy applicativo distinto per ogni protocollo.

Nel 1995 FireWall-1 aveva quindi alle spalle appena un anno di presenza commerciale. Trovarlo nell'architettura di un piccolo ISP italiano non significa semplicemente trovare "un firewall": significa trovare l'adozione molto precoce di una tecnologia che sarebbe diventata uno dei principi fondamentali dei firewall di rete moderni.

## Piattaforma

- Sun SPARCstation 5, SunOS 4.1.4, 32 MB di RAM.
- **Check Point FireWall-1 2.0a**, amministrato tramite la sua GUI X11.
- Cinque interfacce Ethernet:

| Interfaccia | Nome | Indirizzo | Netmask | Ruolo |
|---|---|---|---|---|
| `qe3` | fw-world | 10.0.0.1 | 255.0.0.0 | backbone / World Hub |
| `qe0` | fw-data | 206.20.95.10 | 255.255.255.192 | segmento DATA |
| `qe1` | fw-users | 206.20.95.11 | 255.255.255.192 | segmento USERS |
| `qe2` | fw-shell | 206.20.95.12 | 255.255.255.192 | segmento SHELL pianificato |
| `le0` | office | 206.20.95.129 | 255.255.255.128 | LAN dell'ufficio |

Il firewall aveva due schede di rete. La `le0` onboard (AMD Lance) collegava
la LAN dell'ufficio. La **scheda Sun Quad Ethernet** forniva le quattro
interfacce `qe`: il lato world/backbone (`qe3`) più un'interfaccia separata per
ogni segmento server - DATA (`qe0`), USERS (`qe1`) e lo SHELL pianificato
(`qe2`). Ogni server quindi si affacciava al firewall sulla propria interfaccia
ed era governato dalla propria policy, esattamente come mostra la rule base
recuperata. La segmentazione era fisica, non solo logica.

## Routing

`/etc/rc.route` configurava le interfacce e costruiva rotte host-specific.
Sulle interfacce DATA e USERS cancellava la rotta connessa ampia e aggiungeva
una rotta per server, applicando il disegno segmentato anche a livello 3. La
rotta di default puntava al Cisco 2501 centrale (`intf-idt`, `10.0.1.1`), che è
come i server protetti raggiungevano Internet; le rotte per le reti dei POP
puntavano ai rispettivi router dei POP sul lato world. Le sessioni dial-up
viaggiavano sul world/backbone e non dipendevano dal firewall per l'accesso a
Internet.

## La rule base

Lo screenshot originale di FireWall-1 (`/usr/local/etc/fw/conf/final1.W`) è
conservato nell'archivio. Le 15 regole sono elencate in
[Sicurezza](../../docs/06-security.md). In sintesi:

- permesso universale per DNS e ident;
- accesso pubblico ai servizi web/ICMP/SMTP dei server;
- accesso completo nel namespace `intf.com`;
- accesso di clienti e ufficio a FTP, news, POP2/POP3;
- autenticazione degli access server (regola 7, `ts -> users : tacacs`) verso USERS;
- amministrazione da DVLP e dalla workstation di Marco, inclusi i canali di
  gestione e logging di FireWall-1 e X11;
- il feed news upstream (regola 12, `news.ios.com -> data : nntp`) verso DATA;
- supporto remoto (regola 13, `xpert.com -> dvlp, marco : talk, deslogin`) da `xpert.com` a DVLP e Marco;
- una regola finale `Any -> Any : Any : STOP` che scarta tutto il resto.

Le regole 8 e 9 (`ts -> Shell`, `Shell -> users : NFS`) appartengono allo
SHELL pianificato, mai messo in esercizio.

## Amministrazione

Il firewall era amministrato dall'interno della rete protetta dell'ufficio. La
regola 11 permette a DVLP di raggiungere il firewall via telnet e sui canali di
gestione (`FW1`) e logging (`FW1_log`) di FireWall-1; la regola 14
(`dvlp, marco -> marco, dvlp : X11`) elenca sia DVLP sia la workstation di
Marco come sorgenti e come destinazioni, quindi consentiva il traffico X11 tra
i due. La regola 10 concede a DVLP e Marco
l'accesso telnet ai server. Il traffico di gestione non attraversava mai
Internet pubblica.

## Servizi e configurazione

| Servizio / ruolo | Descrizione | Configurazione / evidenza | Documentazione |
|---|---|---|---|
| FireWall-1 2.0a | Gateway di sicurezza: packet filtering, NAT e segmentazione di rete. | [`checkpoint/firewall-lic.txt`](checkpoint/firewall-lic.txt) · [`checkpoint/`](checkpoint/README.md) | [Sicurezza](../../docs/06-security.md) · [`TECHNICAL.md`](TECHNICAL.md) |
| Policy / rule base — evidenza visiva | Screenshot originale del Rule Base Editor (`/usr/local/etc/fw/conf/final1.W`), 15 regole. | [`checkpoint/FW-policy.gif`](checkpoint/FW-policy.gif) | [Sicurezza](../../docs/06-security.md) |
| Routing e interfacce | Cinque interfacce Ethernet, rotte host-specific sui segmenti DATA/USERS, rotte dei POP. | [`network/rc.route`](network/rc.route) · [`network/`](network/README.md) | [Panoramica dell'architettura](../../docs/01-architecture.md) |
| Avvio, logging e monitoraggio | Avvio di FireWall-1 (`fwstart`), accounting dial-up, `loghost` centrale. | [`network/rc.local`](network/rc.local) | [Monitoraggio](../../docs/08-monitoring.md) |
| Hardening di sistema | Script di permessi, account di servizio, `inetd` minimale, `ftpusers`. | [`system/`](system/README.md) · [`system/fixperms`](system/fixperms) · [`../users/system/ftpusers`](../users/system/ftpusers) | [Sicurezza](../../docs/06-security.md) |

### Evidenza visiva della policy

[`checkpoint/FW-policy.gif`](checkpoint/FW-policy.gif) è lo screenshot originale
del Rule Base Editor di Check Point FireWall-1: è **evidenza visiva** della
policy caricata, conservata come reperto storico. Non sostituisce la
trascrizione testuale delle regole in [Sicurezza](../../docs/06-security.md), che
resta la fonte primaria.

## Contenuti correlati in quest'area

- `checkpoint/` — materiale di configurazione e policy di FireWall-1.
- `network/` — materiale di routing e configurazione di rete del gateway.

Lo screenshot originale della rule base è conservato con il materiale di
riferimento recuperato; vedi [Sicurezza](../../docs/06-security.md).

---

Vedi anche: [Panoramica dell'architettura](../../docs/01-architecture.md) ·
[Non uso di NIS/NFS](../../docs/06-security.md)
