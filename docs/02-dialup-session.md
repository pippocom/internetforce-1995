🇮🇹 **Italiano** · [🇬🇧 English](02-dialup-session.en.md)

# La sessione dial-up

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

Questa è la storia centrale del servizio: cosa succedeva quando il computer
di un cliente chiamava uno dei numeri di accesso di Internet Force. Il percorso
va dal PC del cliente, attraverso la rete telefonica e un banco modem, dentro
un access server Cisco, attraverso l'autenticazione centralizzata XTACACS, e
infine sul backbone di Internet Force e sul collegamento IDT verso Internet.

```
PC del cliente
   │  chiamata analogica
   ▼
rete telefonica / gruppo di caccia
   ▼
banco modem US Robotics Courier 28.8
   ▼
access server Cisco 2511 (POP) ───────────┐
   │  PPP                                  │  richiesta XTACACS
   ▼                                       ▼
router Cisco 2501 del POP          percorso protetto da FireWall-1
   │                                       ▼
   ▼                               USERS (XTACACS, 206.20.95.4)
backbone privato (10.0.0.0/8)              │  risultato
   ▼                                       ▼
Cisco 2501 centrale (10.0.1.1)     indietro all'access server
   ▼
IDT / New York → Internet
```

Il percorso dati è la colonna di sinistra: dal 2511 al router del POP, sul
backbone e poi al 2501 centrale verso IDT. Per i POP remoti (Pesaro, Palermo,
Gorgonzola) il router del POP è un Cisco 2501 dedicato; per Milano il 2501
centrale/world svolge quel ruolo, senza un 2501 POP separato.

Il ramo di destra è l'autenticazione: il 2511 interroga XTACACS su USERS
attraverso il percorso protetto da FireWall-1 e riceve il risultato. Non è un
salto del percorso dati del cliente verso Internet.

## 1. La chiamata

Il cliente configurava una connessione dial-up con il numero di accesso del
POP più vicino. Per ogni POP venivano pubblicate più linee telefoniche; il
gruppo di caccia (*hunt group*, detto anche gruppo rotativo) della rete
telefonica instradava ogni chiamata verso una linea libera, così il cliente
non doveva sapere quale modem avrebbe risposto. I numeri ricostruiti sono
elencati in [Accesso telefonico ai POP](../systems/pops/telephone-numbers.md).

Pesaro, per esempio, pubblicava un blocco di linee e un numero voce principale;
Palermo, Gorgonzola e Milano avevano ciascuno i propri numeri locali. Il numero
era l'unica impostazione specifica del POP nel software del cliente.

## 2. Il banco modem

Ogni POP aveva un banco di **16 modem US Robotics Courier 28.8 kbit/s**. Un
modem rispondeva alla chiamata e completava l'handshake analogico. I modem
erano inizializzati con una stringa AT che impostava 115200 bit/s tra modem e
access server (DTE) e 28800 bit/s sulla linea telefonica (DCE):

```
ate0q1\q3\n3\j0&c1\d2&d2s0=1$b115200%b28800&w
```

Le impostazioni includono echo off, result codes, flow control hardware,
gestione DCD e DTR drop, più auto-answer dopo un squillo.

## 3. Due apparati, due lavori

Nei POP remoti iniziali di Pesaro, Palermo e Gorgonzola il dial-up usava due
apparati Cisco distinti, perché avevano due lavori diversi:

- **Cisco 2511 — access server.** Un access server è un concentratore di linee
  asincrone: termina le 16 porte seriali a cui erano cablati i modem, instaura
  una sessione PPP su ogni linea e autentica centralmente chi chiama tramite
  XTACACS. Il 2511 è il punto in cui il cliente entra nella rete IP.
- **Cisco 2501 — router del POP.** Un router collega il POP al backbone
  Internet Force e decide dove inoltrare i pacchetti una volta entrati: le reti
  raggiungibili attraverso quel POP sono descritte nelle sue route.

In breve: il 2511 faceva entrare il cliente nella rete IP; il 2501 sapeva dove
inoltrare i pacchetti dopo. La separazione spiega perché in ogni POP
sopravvivano due configurazioni: non sono ridondanti, sono due ruoli. Il quadro
d'insieme dei POP è in [I POP](../systems/pops/README.md).

Milano era diverso: aveva il proprio Cisco 2511 per l'accesso dial-up, ma il
ruolo di routing verso il mondo era svolto dal **Cisco 2501 centrale/world**.
Non esisteva un secondo 2501 dedicato al POP di Milano.

### Perché una sottorete seriale tra 2501 e 2511

I due apparati erano collegati direttamente da un link seriale (`Serial0` su
entrambi, `encapsulation ppp`, 64 kbit/s). Un link punto-a-punto ha comunque
bisogno di indirizzi IP alle due estremità, quindi ogni POP usava una piccola
sottorete privata per questo transito: non una rete clienti, solo il
collegamento tra access server e router. A Pesaro era `10.0.3.128/25`, con il
2501 su `10.0.3.129` e il 2511 su `10.0.3.130`. Il 2501 instradava le reti
dial-up (`206.20.115.0/27` e `206.20.115.64/27`) verso l'access server; il 2511
aveva una rotta di default verso il 2501 (`10.0.3.129`) e il 2501 una rotta di
default verso il gateway world/backbone (`10.0.0.1`). Palermo (`10.0.4.128/25`)
e Gorgonzola (`10.0.5.128/25`) seguivano lo stesso schema.

## 4. Amministrare IOS senza GUI

Cisco IOS, in questo impiego, non aveva interfaccia grafica: si amministrava
da riga di comando. Per la configurazione iniziale si usava la porta console
seriale; una volta assegnato un indirizzo IP e resa raggiungibile la macchina,
l'amministrazione poteva avvenire anche via Telnet. Il transceiver AUI/10Base-T
apparteneva al collegamento Ethernet, non alla console seriale.

Una sessione IOS tipica passava attraverso:

```
Router> enable
Password:
Router# configure terminal
Router(config)#
```

I tre prompt indicano tre livelli di privilegio: `>` è la modalità EXEC non
privilegiata, con i comandi di sola lettura; `#` è la modalità EXEC
privilegiata, raggiunta con `enable`, da cui si può intervenire sul dispositivo;
`(config)#` è la modalità di configurazione globale, raggiunta con
`configure terminal`, in cui si modificano davvero i parametri. Console e
Telnet portavano allo stesso insieme di prompt.

## 5. L'access server e le sue linee

Il banco modem era cablato a un access server Cisco 2511. Ogni modem
corrisponde a una linea asincrona; i POP iniziali usavano `line 1 16`, e i
corrispondenti blocchi `interface Async1` … `Async16` configurano le linee. La
configurazione essenziale per linea era:

- `encapsulation ppp` — il protocollo di collegamento sulla linea era PPP;
- `async mode interactive` — la linea accettava una chiamata interattiva in
  ingresso;
- `ip unnumbered Ethernet0` — l'interfaccia asincrona prendeva in prestito
  l'indirizzo di Ethernet0 invece di consumare una sottorete dedicata per ogni
  linea;
- `async default ip address <addr>` — l'indirizzo offerto al chiamante se il
  peer non ne negoziava uno; è l'indirizzo che compare nel pool clienti;
- `ip tcp header-compression passive` — la compressione dell'header TCP veniva
  offerta;
- velocità di linea, flow control, `modem ri-is-cd` e `stopbits 1`.

Il 2511 di Milano è un buon esempio: le sue linee hanno come default da
`206.20.95.70` a `206.20.95.85`, dentro la sottorete dial-up `206.20.95.64/26`.
La configurazione completa è in
[`systems/pops/milano/2511.cfg`](../systems/pops/milano/2511.cfg).

## 6. Autenticazione con XTACACS

Prima che il cliente ottenesse una sessione, l'access server autenticava la
chiamata contro il servizio XTACACS centrale. XTACACS (*Extended TACACS*) è il
protocollo Cisco di autenticazione, autorizzazione e accounting, predecessore
di TACACS+: un demone `xtacacsd` su un host Unix risponde alle richieste degli
apparati di accesso, che non conservano quindi un database locale degli utenti.
Ogni access server puntava a USERS:

```
tacacs-server host 206.20.95.4
tacacs-server extended
tacacs-server authenticate connections
tacacs-server authenticate slip always
tacacs-server notify connections
tacacs-server notify enable
tacacs-server notify logout
tacacs-server notify slip
```

USERS eseguiva `xtacacsd` (XTACACS, revisione 3.4, 1995) da
`/etc/xtacacsd -ls`; la sua configurazione è in
[`systems/users/tacacs/xtacacsd-conf`](../systems/users/tacacs/xtacacsd-conf),
con il manuale e la documentazione in
[`xtacacsd_man_and_config.txt`](../systems/users/tacacs/xtacacsd_man_and_config.txt).
Una volta verificati nome utente e password del cliente, la linea veniva
autorizzata e i record di accounting aggiornati. XTACACS manteneva anche un
record di login per ogni Cisco, così il comando standard `last` poteva produrre
report di connessione, e su USERS girava un helper di accounting dial-up
(`xacctd_user`). Autenticazione, autorizzazione e accounting per ogni POP erano
centralizzati in questo modo.

Questa conversazione è un **ramo laterale** del percorso: le richieste
XTACACS attraversavano il percorso protetto da FireWall-1 per raggiungere
USERS, mentre il traffico Internet ordinario del cliente restava sul lato
world/backbone. USERS non è un salto del percorso dati del cliente verso
Internet. I dettagli sono in
[Autenticazione (XTACACS)](10-authentication-tacacs.md).

## 7. La sessione

Dopo l'autenticazione, alla sessione dial-up veniva assegnato dinamicamente un
indirizzo IP dal pool gestito direttamente dall'access server (CISCO 2511). L'indirizzo apparteneva
quindi alla sessione di collegamento, non a una configurazione IP permanente del
singolo abbonato. L'assegnazione dinamica degli indirizzi agli utenti non va
confusa con il routing della rete: il routing di Internet Force era statico.
Il routing sull'access server usava il peer PPP e la rotta di default del server
verso il backbone.

I clienti potevano quindi usare tutta la gamma di servizi TCP/IP: navigazione
web, posta, news Usenet, FTP e il resto. Sulle macchine Windows 3.1/95 lo stack
TCP/IP usuale dell'epoca era **Trumpet Winsock**; Internet Force lo forniva nel
[Welcome Kit](../artifacts/customer-welcome-kit/README.md) cliente insieme a un
manuale utente stampato e ai programmi client per i servizi principali.

## 8. Instradamento verso Internet

Il traffico della sessione lasciava l'access server verso il router Cisco 2501
del POP, che lo portava sul backbone privato verso il sito centrale. Lì il
Cisco 2501 centrale (`10.0.1.1`) lo inviava sul collegamento IDT verso New York
e dentro Internet. Il traffico di ritorno seguiva il percorso inverso.

Le sessioni clienti restavano dal lato world/backbone della rete; non
dipendevano dal firewall per l'accesso a Internet. FireWall-1 proteggeva i
server centrali e la LAN dell'ufficio - le parti del sistema che esponevano
davvero servizi - con una policy separata per ogni interfaccia server.

## 9. Riferimento dial-in

| POP | Access server | Router (2501) | Pool indirizzi clienti | Modem |
|---|---|---|---|---|
| Milano | 2511 `10.0.2.1` | 2501 centrale/world | 206.20.95.70–85 | 16 |
| Pesaro | 2511 `206.20.115.65` | `10.0.3.1` | 206.20.115.2–17 | 16 |
| Palermo | 2511 `206.20.224.65` | `10.0.4.1` | 206.20.224.2–17 | 16 |
| Gorgonzola | 2511 `206.20.225.65` | `10.0.5.1` | 206.20.225.2–17 | 16 |

Ogni indirizzo cliente aveva una voce reverse-DNS corrispondente
(`ppp1-16-<pop>`). I POP successivi aggiunsero capacità dial-up nel 1996 e sono
trattati in [Crescita della rete 1995 → 1996](13-network-growth-1995-1996.md).

Il collegamento geografico dei POP remoti (Pesaro, Palermo, Gorgonzola) verso
Milano era un circuito dedicato **CDA/CDN da 64 kbit/s**; il dimensionamento del
banco modem rispetto a questa capacità è descritto in
[I POP](../systems/pops/README.md).

## Fonti recuperate

- Router centrale/world: [`systems/cisco-2501-uplink/config/2501.cfg`](../systems/cisco-2501-uplink/config/2501.cfg)
- Pesaro: [`2501.cfg`](../systems/pops/pesaro/2501.cfg), [`2511.cfg`](../systems/pops/pesaro/2511.cfg)
- Palermo: [`2501.cfg`](../systems/pops/palermo/2501.cfg), [`2511.cfg`](../systems/pops/palermo/2511.cfg)
- Gorgonzola: [`2501.cfg`](../systems/pops/gorgonzola/2501.cfg), [`2511.cfg`](../systems/pops/gorgonzola/2511.cfg)
- Milano: [`2511.cfg`](../systems/pops/milano/2511.cfg)
- XTACACS su USERS: [`xtacacsd-conf`](../systems/users/tacacs/xtacacsd-conf),
  [`xtacacsd_man_and_config.txt`](../systems/users/tacacs/xtacacsd_man_and_config.txt)
- POP e numeri: [I POP](../systems/pops/README.md),
  [numeri telefonici](../systems/pops/telephone-numbers.md)

Questi file sono livelli temporali diversi: sono stati recuperati in momenti
diversi e possono non combaciare perfettamente fra loro.

---

Flussi successivi: [DNS](03-dns.md) · [Posta](04-email.md) ·
[Web, FTP, news e mailing list](05-web-news-ftp.md) ·
[Autenticazione (XTACACS)](10-authentication-tacacs.md)

---

→ [Costruire un Internet Force POP, passo per passo](00-build-an-isp.md)
