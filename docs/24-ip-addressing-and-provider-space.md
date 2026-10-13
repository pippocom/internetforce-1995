🇮🇹 **Italiano** · [🇬🇧 English](24-ip-addressing-and-provider-space.en.md)

# Indirizzamento IP: spazio pubblico, backbone privato e dipendenza dal carrier

> **Internet Force 1995–1996 Historical Archive**  
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone e sulla sua testimonianza diretta come system e network administrator.  
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com  
> Licenza: [CC BY 4.0](../LICENSE)

Per costruire un ISP nel 1995 non bastavano modem, router, server Unix e un collegamento verso Internet. Serviva anche qualcosa di meno visibile ma essenziale: **uno spazio di indirizzamento IPv4 pubblico che il resto di Internet sapesse raggiungere**.

Per un piccolo ISP, nella pratica, questo significava normalmente ottenere dal proprio carrier o upstream uno o più blocchi di indirizzi pubblici, nel linguaggio dell'epoca spesso chiamati semplicemente **“classi C”**. Gli indirizzi dovevano poi essere distribuiti fra infrastruttura centrale, router, server, reti dei POP e utenti dial-up.

Internet Force seguiva esattamente questo modello. Lo spazio pubblico iniziale era fornito nel contesto del rapporto con **IDT**, l'upstream internazionale. Quando, durante la chiusura di Internet Force, i POP furono resi autonomi, non poterono semplicemente conservare gli indirizzi precedenti: ottennero nuovi collegamenti e nuovi indirizzi dal nuovo carrier, **COMM 2000**, e gli apparati e i servizi dovettero essere rinumerati.
Scordatevi Software Defined Networking, controller centralizzati o provisioning automatico: nel 1995 l'indirizzamento era un lavoro manuale. Marco Iannacone dovette progettare le nuove subnet, decidere quali blocchi assegnare ai diversi POP e apparati e riconfigurare uno per uno router, access server, server e servizi perché utilizzassero i nuovi indirizzi.

Questa dipendenza fra carrier, routing e indirizzi è uno degli aspetti che più distingue l'Internet commerciale degli anni Novanta dall'esperienza domestica contemporanea.

---

## 1. Quattro concetti che oggi vengono facilmente confusi

Prima di guardare Internet Force conviene separare quattro proprietà diverse di un indirizzo IP.

### Pubblico o privato

Un **indirizzo pubblico** è instradabile su Internet. Un server Web, un DNS o un host dial-up con un indirizzo pubblico può, in linea di principio e salvo firewall o altre policy, essere raggiunto dalla rete globale.

Un **indirizzo privato** appartiene invece a uno spazio destinato all'uso interno e non deve essere instradato sulla rete pubblica. Nel 1994 RFC 1597 aveva già formalizzato gli spazi privati, fra cui `10.0.0.0/8`; nel 1996 questa funzione sarebbe stata consolidata da RFC 1918.

Internet Force usava realmente `10.0.0.0/8` come rete privata di backbone.

### Statico o dinamico

“Pubblico” non significa “statico”, e “privato” non significa “dinamico”.

I server e gli apparati di rete hanno normalmente bisogno di indirizzi stabili. Un utente dial-up, invece, può ricevere un **indirizzo pubblico diverso a ogni connessione**.

Questo era il modello tipico dell'accesso Internet dell'epoca e anche quello che emerge dalle configurazioni Cisco 2511 di Internet Force: le linee asincrone avevano indirizzi pubblici disponibili per le sessioni PPP. L'indirizzo restava legato alla sessione o alla linea, non alla persona che telefonava.

### Indirizzo e traduzione NAT

Il **NAT** è un meccanismo distinto: traduce gli indirizzi fra due spazi. RFC 1631 lo descriveva già nel 1994, ma nel 1995 non era ancora il modello domestico universale che sarebbe diventato successivamente.

Oggi una casa tipica ha molti dispositivi con indirizzi privati, per esempio `192.168.x.x`, e un router che li presenta verso Internet attraverso uno o pochi indirizzi pubblici. Un cliente dial-up degli anni Novanta, invece, poteva ricevere direttamente sul proprio PC un **vero indirizzo IPv4 pubblico**.

### Indirizzo e posizione nella rete

Un indirizzo IP non era soltanto un numero assegnato a una macchina: descriveva anche **dove quella macchina si trovava nella topologia di routing**.

Per questo cambiare carrier poteva obbligare a cambiare indirizzi. È precisamente ciò che accadde durante la dismissione di Internet Force.

---

## 2. “Classe C” nel linguaggio del 1995

CIDR era già stato introdotto nel 1993 da RFC 1519. Questo, però, non fece sparire improvvisamente la terminologia classful.

Nei libri di networking, nella documentazione operativa e nelle conversazioni tecniche dell'epoca continuavano a essere comunissimi termini come **classe A, classe B e classe C**. Per un piccolo ISP chiedere o ricevere “una classe C” era un modo naturale per indicare una rete IPv4 di 256 indirizzi, storicamente con maschera `/24`.

Internet Force nacque esattamente in quel periodo di transizione. Questo archivio conserva quindi la terminologia storica quando descrive come si parlava e si lavorava allora, ma usa la notazione CIDR quando la netmask originale è effettivamente documentata.

È importante anche non trasformare retroattivamente ogni rete `206.x.x.x` in un `/24`: Internet Force subnettava lo spazio ricevuto e, per alcuni segmenti, le configurazioni sopravvissute mostrano maschere più specifiche.

---

## 3. Lo spazio pubblico di Internet Force

Gli indirizzi pubblici utilizzati da Internet Force furono forniti da **IDT** insieme alla connettività upstream. Le configurazioni conservate permettono di vedere come quello spazio veniva poi usato.

### Collegamento verso IDT

Il Cisco 2501 centrale aveva:

- interfaccia interna: `10.0.1.1`;
- interfaccia seriale verso l'upstream: `206.20.64.30/30`;
- peer Frame Relay: `206.20.64.29`.

La mappa tkined storica etichetta in modo differente i due estremi `.29/.30`; le configurazioni Cisco sopravvissute indicano però `.30` come indirizzo locale del 2501 e `.29` come peer. L'archivio conserva esplicitamente questo conflitto fra fonti invece di “aggiustarlo” a posteriori.

### Servizi centrali

Fra gli indirizzi pubblici documentati nella rete centrale:

| Funzione | Indirizzo |
|---|---:|
| DATA | `206.20.95.3` |
| USERS | `206.20.95.4` |
| firewall verso DATA | `206.20.95.10` |
| firewall verso USERS | `206.20.95.11` |
| interfaccia firewall prevista per SHELL | `206.20.95.12` |
| rete office | `206.20.95.128/25` |
| firewall verso office | `206.20.95.129` |
| workstation `marco` | `206.20.95.140` |

DATA e USERS erano quindi direttamente identificabili tramite indirizzi pubblici stabili, mentre il firewall separava i diversi segmenti e applicava le policy di accesso.

### Milano e le sessioni dial-up

Per Milano la rete dial-up `206.20.95.64` è documentata con netmask `255.255.255.192`, quindi `/26`.

La distinzione importante è questa:

```text
server/router              -> indirizzo pubblico stabile
utente dial-up durante PPP -> indirizzo pubblico assegnato alla sessione
backbone interno           -> indirizzo privato 10.x.x.x
```

Il PC del cliente non veniva nascosto dietro un NAT del provider. Durante la sessione PPP diventava direttamente un nodo IP della rete pubblica.

---

## 4. Backbone privato e reti pubbliche dei POP

Internet Force usava contemporaneamente indirizzi privati e pubblici perché servivano a scopi diversi.

Il backbone interno era `10.0.0.0/8`. Fra gli indirizzi documentati:

| Nodo | Indirizzo privato |
|---|---:|
| firewall `fw-world` | `10.0.0.1` |
| World Hub | `10.0.0.254` |
| Cisco 2501 centrale | `10.0.1.1` |
| Cisco 2511 Milano | `10.0.2.1` |
| Cisco 2501 Pesaro | `10.0.3.1` |
| Cisco 2501 Palermo | `10.0.4.1` |
| Cisco 2501 Gorgonzola | `10.0.5.1` |

Le reti pubbliche associate ai quattro POP iniziali erano invece:

| POP | Spazio pubblico documentato | Esempio documentato |
|---|---|---|
| Milano | `206.20.95.64` | rete `/26` confermata |
| Pesaro | `206.20.115.0` | Cisco 2511 `206.20.115.65` |
| Palermo | `206.20.224.0` | Cisco 2511 `206.20.224.65` |
| Gorgonzola | `206.20.225.0` | Cisco 2511 `206.20.225.65` |

Le maschere dei tre POP remoti non vanno dedotte soltanto dal fatto che gli indirizzi appartengano storicamente a reti di classe C: dove la netmask non è sopravvissuta in modo inequivocabile, l'archivio non la inventa.

Questa architettura rende visibile un principio fondamentale: **la rete privata serviva a collegare l'infrastruttura; lo spazio pubblico serviva a rendere servizi e sessioni raggiungibili su Internet**.

---

## 5. Come veniva assegnato un IP a un utente dial-up

Il percorso tipico era:

```text
telefono
  -> modem
  -> linea asincrona Cisco 2511
  -> autenticazione XTACACS
  -> sessione PPP
  -> indirizzo IPv4 pubblico
  -> routing verso il 2501
  -> IDT
  -> Internet
```

Le configurazioni dei Cisco 2511 mostrano `encapsulation ppp`, `ip unnumbered Ethernet0` e indirizzi preconfigurati per le linee asincrone.

Dal punto di vista del cliente, quindi, l'indirizzo era **dinamico** perché dipendeva dalla connessione. Dal punto di vista dell'ISP, gli indirizzi appartenevano a uno spazio pubblico già assegnato e instradato.

Questa distinzione spiega perché “IP dinamico” e “IP privato” non siano sinonimi.

---

## 6. Aggiungere un POP significava anche trovare indirizzi

Un nuovo POP non era pronto quando arrivavano soltanto router, modem e linee telefoniche.

Servivano almeno:

1. il collegamento dati verso la rete;
2. lo spazio IPv4 pubblico necessario;
3. gli indirizzi per router e access server;
4. gli indirizzi destinati alle sessioni dial-up;
5. routing coerente verso il resto dell'infrastruttura;
6. DNS e autenticazione correttamente raggiungibili.

Per questo l'indirizzamento deve comparire nel percorso **“Come costruire un ISP”** prima della configurazione finale dei router e dei servizi.

Il carrier non forniva soltanto “banda”. Forniva anche una parte della topologia IP dentro la quale l'ISP doveva vivere.

---

## 7. La separazione dei POP: quando gli indirizzi IDT non potevano seguirli

Durante la chiusura di Internet Force, Marco Iannacone progettò e organizzò una dismissione progressiva dell'infrastruttura.

La prima fase fu rendere autonomi i POP che intendevano continuare l'attività. Questo richiese molto più che spostare un router.

Per ciascun POP occorreva attendere l'attivazione del nuovo collegamento e la disponibilità di un nuovo spazio di indirizzamento pubblico. Il carrier scelto per questa fase fu **COMM 2000**. Solo allora era possibile rinumerare gli apparati, predisporre i servizi locali e trasferire sul nuovo sistema gli account degli utenti di pertinenza del POP.

Gli account non vennero quindi tutti spostati verso un unico nuovo ISP. I clienti dei POP resi autonomi furono separati e portati con le rispettive infrastrutture; **verso Enter andarono successivamente soltanto i clienti di Milano**.

---

## 8. Tre spazi post-Internet Force visibili nell'archivio

La conseguenza della separazione è ancora visibile nei file recuperati. Le reti successive non usano più lo spazio `206.20.*` della fase Internet Force.

### Pesaro Point

Le configurazioni post-Internet Force di Pesaro mostrano lo spazio:

`195.120.225.*`

e, in particolare, route verso:

- `195.120.225.160/27`
- `195.120.225.192/27`

via `195.120.225.3`.

Altri file conservano, fra gli esempi, indirizzi PPP come `195.120.225.99` e `195.120.225.102`, oltre a `195.120.225.6` usato da servizi quali DNS/TACACS in snapshot successivi.

Non è quindi una deduzione teorica: la rinumerazione è scritta direttamente nelle configurazioni.

### Pointest / Gorgonzola

Per l'ex POP di Gorgonzola, diventato **Pointest**, il materiale successivo appartiene allo spazio:

`194.133.145.*`

Un reperto storico indipendente conservato nell'archivio identifica esplicitamente:

`shelley.pointest.com = 194.133.145.2`

`shelley` era il server Linux della fase Pointest, sulla quale vennero portati servizi locali quali DNS, POP3 e XTACACS.

La configurazione Cisco della stessa fase è conservata in:

`systems/pops/gorgonzola/pointest/CISCO/2511BIGI.TXT`

Da quel file si leggono gli indirizzi esatti del router Pointest (`hostname 2511gorgonzola`, `ip domain-name pointest.com`):

| Elemento | Valore documentato |
|---|---|
| Ethernet0 | `194.133.2.196/27` (`255.255.255.224`) |
| Serial0 (verso il carrier) | `194.133.3.174/30` (`255.255.255.252`) |
| Rotta di default | `0.0.0.0/0` via `194.133.3.173` |
| Linee asincrone | `ip unnumbered Ethernet0`, `async default ip address` da `194.133.2.206` a `194.133.2.221` |
| Server TACACS | `194.133.2.197` |
| Name server | `194.133.0.2` |

La rete Ethernet del router era quindi `194.133.2.192/27`; `shelley`, il server Linux locale, è invece attestato a `194.133.145.2`, in un'altra sottorete dello stesso spazio `194.133.*`. Gli indirizzi sono riportati così come compaiono nelle configurazioni, senza normalizzarli.

### Infosfera / Bergamo

Anche il materiale Infosfera/Bergamo mostra uno spazio differente:

`194.235.140.*`

La configurazione Cisco 2511 recuperata contiene, fra l'altro:

`async default ip address 194.235.140.230`

Ancora una volta, l'indirizzamento racconta materialmente che non ci troviamo più nella rete Internet Force originaria.

### Una rete che si divide

La sequenza è quindi leggibile anche solo guardando gli indirizzi:

```text
Internet Force / IDT
    206.20.x.x
        |
        +--> Pesaro Point        195.120.225.x
        |
        +--> Pointest            194.133.145.x
        |
        +--> Infosfera/Bergamo   194.235.140.x
        |
        +--> Milano -> Enter     194.20.50.x
```

Gli indirizzi sono diventati una traccia archeologica della separazione dell'ISP.

---

## 9. COMM 2000

**COMM 2000** era un operatore di telecomunicazioni milanese nato nel 1985. Fu una delle realtà private che entrarono molto presto nel mercato italiano dei servizi di telecomunicazione alternativi al monopolio pubblico, inizialmente con servizi di rete e messaggistica e successivamente con accesso Internet e servizi dati per le aziende.

Negli anni Novanta entrò nel mercato Internet business e divenne uno dei principali ISP indipendenti italiani. Nel caso della dismissione di Internet Force, il suo ruolo fu molto concreto: **fornì ai POP che venivano resi autonomi il nuovo collegamento e il nuovo spazio di indirizzamento pubblico necessario a uscire dalla rete Internet Force/IDT**.

Questa funzione è ricordata direttamente da Marco Iannacone, che gestì tecnicamente la migrazione. I file recuperati documentano poi l'effetto del passaggio mostrando gli spazi IP nuovi e differenti utilizzati dagli ambienti post-Internet Force.

Nel 2000 COMM 2000 fu acquisita da KPNQwest e la società cambiò denominazione in KPNQwest Italia. Nel 2003 l'attività italiana tornò sotto controllo italiano. Dallo stesso gruppo COMM2000 era nata nel 1999 anche Messagenet, inizialmente con servizi di fax via Internet e successivamente nota per i servizi VoIP.

Per la storia societaria si vedano, fra le altre, la Gazzetta Ufficiale del 20 settembre 2000, la scheda storica KPNQwest Italia pubblicata da Key4biz e la storia ufficiale di Messagenet.

---

## 10. L'ultimo renumbering: `marco` da Internet Force a Enter

La migrazione verso Enter avvenne **dopo** che i POP erano già stati resi autonomi.

A quel punto nella vecchia infrastruttura restavano i clienti di Milano e i servizi centrali da mantenere durante la transizione.

La workstation Linux `marco`, che durante la vita di Internet Force era stata la workstation di amministrazione (`206.20.95.140`), venne riformattata e reinstallata con Linux. Mentre Internet Force era ancora operativo, Marco Iannacone predispose quella macchina per assorbire i dati e i servizi fino ad allora distribuiti soprattutto fra `USERS` e `DATA`, e vi copiò i dati necessari prima del cutover finale.

I clienti di Milano furono avvisati via email dei nuovi numeri dial-up di Enter.

Il giorno della migrazione finale:

```text
USERS + DATA
      |
      | dati copiati preventivamente
      v
    marco
      |
      | shutdown finale Internet Force
      | macchina scollegata, caricata sulla sua macchina e trasportata fisicamente da lui
      v
    Enter
      |
      v
      | Marco riconfigura
      +--> nuovo indirizzo principale: 194.20.50.14
      +--> virtual IP per i servizi Web
      +--> aggiornamento DNS
      +--> riavvio dei servizi
```

Marco Iannacone spense l'infrastruttura Internet Force, scollegò `marco`, trasportò personalmente la macchina presso Enter, la riaccese sulla nuova rete, cambiò l'indirizzo IP, configurò i virtual IP necessari per la parte Web e aggiornò i record DNS.

**Circa due ore dopo lo shutdown, i servizi erano nuovamente attivi**. I clienti di Milano potevano collegarsi utilizzando i nuovi numeri dial-up di Enter già comunicati in precedenza.

Il fatto che `marco` compaia successivamente nella rete Enter come `194.20.50.14`, con record DNS che fanno convergere sulla macchina ruoli come `users`, `mail`, `mailhost`, `loghost` e gli MX di `internetforce.com` e `intf.com`, documenta nei file il risultato di quella migrazione.

Il cambio da `206.20.95.140` a `194.20.50.14` è quindi l'ultimo esempio della stessa regola vista nei POP: **cambiando rete e provider, cambiava anche lo spazio IP nel quale vivevano gli host**.

---

## 11. Perché questo capitolo appartiene a “Come costruire un ISP”

L'indirizzamento non è un dettaglio da aggiungere dopo aver installato il resto.

Nel percorso storico di Internet Force la sequenza corretta è:

```text
scegliere il carrier / upstream
        ↓
ottenere lo spazio IPv4 pubblico
        ↓
progettare indirizzamento pubblico e privato
        ↓
configurare routing e collegamenti WAN
        ↓
costruire i POP e i pool dial-up
        ↓
attivare DNS, mail, Web e autenticazione
        ↓
monitorare e gestire la rete
```

La storia della chiusura mostra il principio al contrario: quando una parte dell'ISP usciva dalla rete del carrier precedente, doveva essere **rinumerata prima di poter diventare realmente autonoma**.

---

## Evidenze nel repository

Fra i materiali da usare per verificare e approfondire questo capitolo:

- `systems/cisco-2501-uplink/config/`
- `systems/pops/milano/`
- `systems/pops/pesaro/`
- `systems/pops/palermo/`
- `systems/pops/gorgonzola/`
- `systems/pops/gorgonzola/pointest/`
- `systems/pops/pesaro/post-internet-force/`
- `systems/infosfera-bergamo/`
- `systems/enter/`
- `systems/firewall/network/`
- `systems/data/`
- `systems/users/`
- `artifacts/tkined/`

Vedi anche:

- [Architettura](01-architecture.md)
- [Una sessione dial-up](02-dialup-session.md)
- [Crescita della rete 1995–1996](13-network-growth-1995-1996.md)
- [Router e WAN](16-router-and-wan.md)
- [Chiusura e migrazioni](17-wind-down-and-migrations.md)
- [Mettere insieme un POP](21-putting-the-pop-together.md)

---

## Riferimenti esterni

- RFC 1519, *Classless Inter-Domain Routing (CIDR): an Address Assignment and Aggregation Strategy* (1993): https://www.rfc-editor.org/rfc/rfc1519
- RFC 1597, *Address Allocation for Private Internets* (1994): https://www.rfc-editor.org/rfc/rfc1597
- RFC 1631, *The IP Network Address Translator (NAT)* (1994): https://www.rfc-editor.org/rfc/rfc1631
- Gazzetta Ufficiale, COMM 2000 S.p.A., convocazione per la modifica della ragione sociale in KPN Qwest Italia S.p.A., 20 settembre 2000: https://www.gazzettaufficiale.it/atto/parte_seconda/caricaDettaglioAtto/originario?atto.codiceRedazionale=M-7595&atto.dataPubblicazioneGazzetta=2000-09-20
- Key4biz, *KPNQwest Italia*, 10 settembre 2003: https://www.key4biz.it/Players-Documenti-2003-09-KPNQwest-Italia/72938/
- Messagenet, *Chi siamo*: https://messagenet.com/chisiamo/
