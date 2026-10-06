🇮🇹 **Italiano** · [🇬🇧 English](01-architecture.en.md)

# Panoramica dell'architettura

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

Internet Force era organizzata attorno a un sito centrale a Milano e a un
piccolo numero di Point of Presence regionali. I servizi centrali,
l'autenticazione e il collegamento internazionale vivevano a Milano; i POP
fornivano l'accesso telefonico locale e i banchi modem. Questo documento
descrive l'architettura iniziale del 1995. Le aggiunte del 1996 sono trattate
in [Crescita della rete 1995 → 1996](13-network-growth-1995-1996.md).

Il documento procede in due movimenti. Prima la topologia fisica e logica -
backbone, sito centrale, bordo Internet, firewall, POP, LAN dell'ufficio e
convenzioni di indirizzamento. Poi il modo concreto in cui una singola
macchina Unix entrava in quella rete, dalla prima configurazione
dell'interfaccia alle route host-specific del firewall. Questa seconda parte è
pensata anche per chi non ha mai amministrato Unix o Linux: i concetti
(`/etc`, `/dev`, `root`, i daemon, `ifconfig`, `route`, gli script di avvio)
vengono spiegati la prima volta che servono.

## Il backbone privato

Il backbone interno era una rete privata `10.0.0.0/8`. Un hub Ethernet (ai tempi
non esistevano ancora gli switch di rete) noto come **World Hub** (`10.0.0.254`)
univa tutto ciò che stava da quel lato del firewall:

- il router centrale Cisco 2501 dell'uplink Internet (`10.0.1.1`);
- l'interfaccia world del firewall (`10.0.0.1`);
- i router dei POP;
- l'UPS.

Il World Hub era il punto d'incontro del dominio di routing, non un segmento
clienti. I nomi di rete come `intf-world` e `intfnet` in `/etc/networks` lo
identificano.

Un *backbone* è la rete dorsale che collega tra loro le sedi e i router. Un
*hub* Ethernet è il dispositivo che connette fisicamente più host sullo stesso
cavo, formando un unico dominio di collisione. Il World Hub non serviva i
clienti: era il punto in cui i router si scambiavano il traffico destinato
alle altre reti.

## Il sito centrale (Milano)

Poiché il sito centrale e il POP di Milano condividono la stessa sede fisica,
Milano compare due volte nella topologia: come sede della piattaforma centrale
di servizi UNIX e del bordo internazionale, e come POP dial-up di Milano. Non
c'è quindi **nessun router POP separato per Milano**: il Cisco 2501
centrale/world fornisce l'uplink Internet, e il Cisco 2511 di Milano fornisce
l'accesso dial-up.

Le macchine UNIX centrali stavano dietro il firewall su segmenti dedicati:

| Host | Indirizzo | Ruolo |
|---|---|---|
| `firewall` | 206.20.95.129 (ufficio), 10.0.0.1 (world) | gateway Check Point FireWall-1 |
| `data` | 206.20.95.3 | DNS primario, FTP anonimo, news, Majordomo, web/VIF |
| `users` | 206.20.95.4 | XTACACS, posta, POP3/IMAP, home clienti, DNS secondario |
| `dvlp` | 206.20.95.130 | host di sviluppo/build (LAN ufficio) |
| `marco` | 206.20.95.140 | workstation dell'amministratore (LAN ufficio) |
| `shell` | 206.20.95.5 | host shell clienti pianificato — mai messo in esercizio |

I due server di produzione erano sistemi Sun SPARCstation 5 con SunOS 4.1.4 e
64 MB di RAM. DVLP era uno SPARCstation 4 con 32 MB.

DATA e USERS erano *server headless*: non avevano monitor né console grafica e
si amministravano da terminale. È un dettaglio importante per la seconda parte
del documento, dove si vede che tutta la loro configurazione viveva in file di
testo e script.

## Il bordo Internet: il Cisco 2501

Il punto in cui la rete privata Internet Force incontrava Internet pubblica era
il Cisco 2501 centrale, nel sito di Milano. La configurazione recuperata porta
l'hostname `2501internet`.

**Reperto** — [`systems/cisco-2501-uplink/config/2501.cfg`](../systems/cisco-2501-uplink/config/2501.cfg):

```text
interface Ethernet0
 ip address 10.0.1.1 255.255.255.0
interface Serial0
 ip address 206.20.64.30 255.255.255.252
 encapsulation frame-relay
 bandwidth 128
ip default-gateway 206.20.64.29
ip route 10.0.0.0 255.0.0.0 10.0.0.1
ip route 206.20.95.0 255.255.255.0 10.0.0.1
```

- `Ethernet0` è il lato interno, sul backbone `10.0.0.0/8`: `10.0.1.1/24`,
  noto in `/etc/hosts` come `intf-idt`.
- `Serial0` è il collegamento verso IDT, con `ip address 206.20.64.30/30` e
  incapsulamento `frame-relay`. Il campo `bandwidth 128` riflette il
  collegamento iniziale a **128 kbit/s**, portato a circa **2 Mbit/s** sei
  mesi dopo il lancio.
- `ip default-gateway 206.20.64.29` manda verso IDT tutto ciò che non è una
  rete Internet Force.
- `ip route 10.0.0.0 255.0.0.0 10.0.0.1` e
  `ip route 206.20.95.0 255.255.255.0 10.0.0.1` riportano invece il traffico
  interno verso l'interfaccia world del firewall.

Il router inviava quindi il traffico Internet verso IDT e quello interno verso
il firewall. Un'access list in uscita sul link seriale permetteva solo il
traffico con sorgente in una rete Internet Force, e un priority group dava al
traffico interattivo e DNS la priorità più alta. La descrizione canonica
dell'uplink è nel
[README del Cisco 2501](../systems/cisco-2501-uplink/README.md).

## Firewall e segmentazione

Il gateway di sicurezza era un Sun SPARCstation 5 con Check Point FireWall-1
2.0a, con cinque interfacce Ethernet:

| Interfaccia | Nome | Indirizzo | Netmask | Collega a |
|---|---|---|---|---|
| `qe3` | fw-world | 10.0.0.1 | 255.0.0.0 | backbone / World Hub |
| `qe0` | fw-data | 206.20.95.10 | 255.255.255.192 | segmento DATA |
| `qe1` | fw-users | 206.20.95.11 | 255.255.255.192 | segmento USERS |
| `qe2` | fw-shell | 206.20.95.12 | 255.255.255.192 | segmento SHELL pianificato |
| `le0` | office | 206.20.95.129 | 255.255.255.128 | LAN dell'ufficio |

DATA e USERS non erano due macchine su un unico segmento demilitarizzato.
Ciascuna era collegata attraverso la propria interfaccia del firewall, così
il traffico tra esse e il resto del mondo era controllato a livello di host.
È l'espressione centrale del principio di progetto per cui la sicurezza è
stata costruita fin dall'inizio. Il firewall è descritto in
[README del firewall](../systems/firewall/README.md), inclusa la rule base
originale recuperata; la sua configurazione di rete è nella directory
[`systems/firewall/network/`](../systems/firewall/network/README.md).

## Il percorso Internet per i clienti

I clienti dial-up stavano dal lato world/backbone della rete. Le loro sessioni
terminavano sugli access server dei POP e il loro traffico viaggiava sul
backbone fino al Cisco 2501 centrale, che lo inoltrava a IDT e a Internet. Il
firewall non era lì per proteggere quelle sessioni clienti - chi si collega
via dial-up non espone servizi e non ha bisogno di protezione - ma per
sorvegliare i server centrali e la LAN dell'ufficio.

Il firewall era quindi il punto di sicurezza centrale per le parti del sistema
che esponevano servizi: DATA, USERS, lo SHELL pianificato e la rete
dell'ufficio. Il traffico in ingresso verso i servizi pubblicati (DNS, web,
posta, FTP, news) attraversava FireWall-1 per raggiungere DATA e USERS, e la
stessa policy controllava come quei server e l'ufficio raggiungevano il mondo.

## Topologia dei POP

Ogni POP remoto aveva due ruoli funzionali: un **router** (Cisco 2501) e un
**access server dial-up** (Cisco 2511, o un Cisco 2509 a Tera in seguito). Il
router portava il traffico del POP sul backbone; l'access server terminava le
linee modem e autenticava i chiamanti.

| POP | Router | Access server | Rete dial-up |
|---|---|---|---|
| Milano | 2501 centrale/world (uplink) | 2511 su 10.0.2.1 | 206.20.95.64/26 |
| Pesaro | 2501 su 10.0.3.1 | 2511 su 206.20.115.65 | 206.20.115.0/24 |
| Palermo | 2501 su 10.0.4.1 | 2511 su 206.20.224.65 | 206.20.224.0/24 |
| Gorgonzola | 2501 su 10.0.5.1 | 2511 su 206.20.225.65 | 206.20.225.0/24 |

Ogni POP aveva inizialmente un banco di 16 modem US Robotics Courier
28.8 kbit/s. Il dettaglio completo è nel
[README dei POP](../systems/pops/README.md).

## La LAN dell'ufficio

L'ufficio di Milano usava un segmento Ethernet separato, `206.20.95.128/25`,
dietro l'interfaccia office del firewall. Un hub 3Com LinkBuilder FMS
(`206.20.95.254`) era il dominio di collisione 10Base-T condiviso. Qui erano
collegati DVLP, la workstation di Marco e i PC e Mac dell'ufficio. Vedi il
[README della LAN dell'ufficio](../systems/office-lan/README.md).

## Convenzioni di indirizzamento

- `10.0.0.0/8` — backbone privato. Le sottoreti di collegamento per POP erano
  ricavate da `10.0.0.0/8`, tipicamente una `/26` sull'Ethernet del router e un
  collegamento punto-punto `/25` verso l'access server.
- `206.20.95.0/24` — il blocco di servizio di Milano, suddiviso in
  `206.20.95.0/26` (server), `206.20.95.64/26` (dial-up Milano) e
  `206.20.95.128/25` (ufficio).
- `206.20.64.0/24` — il collegamento internazionale IDT.
- `206.20.115.0/24`, `206.20.224.0/24`, `206.20.225.0/24` — le reti dial-up dei
  POP remoti, con il pool clienti in una `/27` sull'access server.
- `206.20.226.0/24` … `206.20.231.0/24` — POP del 1996.

Il firewall applicava rotte host-specific sulle interfacce DATA e USERS
(`/etc/rc.route` cancellava la rotta connessa ampia e aggiungeva una rotta per
server), applicando il disegno segmentato anche a livello 3.

---

# Mettere una macchina Unix in rete

Immaginiamo di essere nel 1995 e di aver appena installato SunOS su una
SPARCstation oppure Linux su un PC. La macchina si accende, si ha una shell e
si può lavorare localmente. Dal punto di vista di un ISP, però, **così com'è
non serve ancora praticamente a nulla**: la prima cosa da fare è darle
un'identità sulla rete e insegnarle come raggiungere le altre macchine.

Oggi questi dettagli sono in gran parte nascosti da DHCP, installer grafici,
NetworkManager o cloud-init. Nel mondo Unix dell'epoca erano molto più
visibili: quasi tutta la configurazione viveva in semplici file di testo e
script di avvio. È uno degli aspetti più caratteristici della filosofia Unix,
riassunta nella formula *everything is a file*: non significa che ogni cosa sia
letteralmente un file di testo, ma che file, dispositivi e configurazioni sono
esposti attraverso interfacce semplici e componibili, facili da leggere e da
automatizzare con piccoli script.

Prima di entrare nel merito, alcuni termini che ricorrono continuamente:

- **`/etc`** — la directory che raccoglie i file di configurazione del
  sistema: `/etc/hosts`, `/etc/netmasks`, `/etc/networks`, `/etc/rc.route` e
  così via. Sono normalmente file di testo che l'amministratore legge e
  modifica.
- **`/dev`** — la directory dei *device file*, file speciali con cui i
  programmi parlano all'hardware (dischi, porte seriali, interfacce di rete).
  È il modo in cui Unix espone l'hardware come un file.
- **`root`** — l'utente amministratore (UID 0), l'unico con privilegi
  sufficienti a cambiare la configurazione di rete e di sistema. Le macchine
  Internet Force erano amministrate come `root` da terminale.
- **daemon** — un processo che resta in esecuzione in background per fornire
  un servizio, senza un terminale interattivo; esempi sono `inetd`, il
  super-server che avvia altri servizi su richiesta, e `named`, il name server
  DNS.
- **script `rc`** — gli script di avvio eseguiti al boot. Il nome viene da
  *run commands*: leggono i file di configurazione e rieseguono i comandi che
  danno alla macchina la sua identità di rete.
- **`ifconfig`** — il comando storico per configurare un'interfaccia di rete
  (assegnare indirizzo, netmask, broadcast).
- **`route`** — il comando per leggere e modificare la tabella di routing del
  kernel, cioè l'elenco delle destinazioni e di dove mandare i pacchetti.

## Le cinque informazioni che servono a una macchina

Per collegare un host a una rete IP occorre stabilire almeno cinque cose:

```text
indirizzo IP
netmask
indirizzo della rete
broadcast
gateway
```

Prendiamo la workstation Linux `marco`, la macchina da cui si amministrava e
monitorava l'infrastruttura (un PC di classe 486 con Linux e X11, in
`206.20.95.140`).

**Reperto** — [`systems/marco/system/rc.inet1`](../systems/marco/system/rc.inet1):

```sh
IPADDR="206.20.95.140"
NETMASK="255.255.255.128"
NETWORK="206.20.95.128"
BROADCAST="206.20.95.255"
GATEWAY="206.20.95.129"
```

Questo piccolo blocco descrive già, prima di eseguire qualsiasi comando, la
posizione della macchina nella rete:

- **indirizzo IP** (`IPADDR`) — l'indirizzo della workstation. In una LAN
  moderna arriverebbe automaticamente da DHCP; qui è *statico*, cioè deciso a
  mano, perché `marco` doveva essere sempre raggiungibile allo stesso
  indirizzo.
- **netmask** (`NETMASK`) — dice quali indirizzi appartengono alla stessa rete
  locale. `255.255.255.128` corrisponde alla notazione `/25`: la rete va da
  `206.20.95.128` a `206.20.95.255`. La macchina può parlare direttamente con
  gli host di questo segmento Ethernet; per le altre reti le serve un router.
- **indirizzo di rete** (`NETWORK`) — identifica la rete stessa, cioè
  `206.20.95.128/25`.
- **broadcast** (`BROADCAST`) — l'indirizzo con cui si invia un pacchetto a
  tutti gli host del segmento (`206.20.95.255`).
- **gateway** (`GATEWAY`) — la porta d'uscita verso il resto della rete. Per
  `marco` era `206.20.95.129`, l'interfaccia office del firewall sulla LAN
  dell'ufficio.

In figura:

```text
marco
206.20.95.140
      |
      | Ethernet
      |
206.20.95.129
FireWall-1
      |
      +------ resto di Internetforce
```

## Applicare l'indirizzo alla scheda: `ifconfig`

Aver scritto l'indirizzo in una variabile non cambia ancora la macchina:
bisogna applicarlo all'interfaccia Ethernet. In una shell Unix
`IPADDR="…"` definisce una variabile e `$IPADDR` la richiama; `eth0` è la
prima interfaccia Ethernet di Linux.

**Reperto** — [`systems/marco/system/rc.inet1`](../systems/marco/system/rc.inet1):

```sh
/sbin/ifconfig eth0 ${IPADDR} broadcast ${BROADCAST} netmask ${NETMASK}
```

`ifconfig` assegna a `eth0` l'indirizzo `206.20.95.140`, con la netmask e il
broadcast indicati. Dopo questo passaggio `marco` può comunicare con gli altri
host della propria LAN, ma non sa ancora come raggiungere le altre reti.

## Costruire la tabella di routing

Una macchina IP deve sapere dove inviare i pacchetti. La prima route dice che
la rete locale è direttamente raggiungibile attraverso Ethernet:

**Reperto** — [`systems/marco/system/rc.inet1`](../systems/marco/system/rc.inet1):

```sh
/sbin/route add -net ${NETWORK} netmask ${NETMASK}
/sbin/route add default gw ${GATEWAY} metric 1
```

La prima riga aggiunge la route per la rete locale:

```text
destinazione 206.20.95.128/25
        ↓
è locale
        ↓
usa eth0
```

La seconda è la **default route**, la regola più importante:

> se non conosci una route più specifica verso la destinazione, consegna il
> pacchetto al gateway `206.20.95.129`.

Il percorso di un pacchetto diventa quindi:

```text
destinazione sulla LAN?
      |
     sì ------> invio diretto via Ethernet
      |
     no
      |
      v
gateway 206.20.95.129
      |
      v
FireWall-1 / altre reti
```

Questo è il principio fondamentale del routing IP. La rete di Internet Force
era più articolata, ma il concetto non cambia.

## Gli script `rc`: la stessa configurazione a ogni avvio

Le cinque variabili e i comandi `ifconfig`/`route` non venivano digitati a mano
a ogni riavvio. Vivevano nel file `rc.inet1`, che il sistema eseguiva
automaticamente al boot - nella Slackware dell'epoca gli script `rc.*` in
`/etc/rc.d/` vengono lanciati in un ordine prestabilito. Il punto essenziale è
questo: il boot di una macchina Unix **riesegue la stessa sequenza di comandi**
appena letta, riportando ogni volta l'interfaccia e la tabella di routing allo
stato voluto. La configurazione non è un evento una tantum: è uno script che
si ripete a ogni accensione.

Lo script `rc.inet1` completo, con il commento originale e l'ordine esatto dei
comandi, è pubblico:
[`systems/marco/system/rc.inet1`](../systems/marco/system/rc.inet1).
La workstation è descritta nel
[README della workstation di Marco](../systems/marco/README.md).

## Su SunOS: hostname, `/etc/hosts` e le interfacce `le0`

Le Sun usavano una convenzione diversa da Linux, ma la logica era identica.
L'interfaccia Ethernet principale delle SPARCstation si chiamava `le0`: `le`
è il driver Ethernet AMD LANCE usato da quelle macchine.

Su SunOS l'identità dell'interfaccia stava in un file per interfaccia, per
esempio `/etc/hostname.le0`, che conteneva il *nome* dell'host (non
l'indirizzo):

**Reperto** — avvio SunOS (`rc.boot`), riprodotto dalle note tecniche:

```sh
hostname="`shcat /etc/hostname.??0 2>/dev/null`"
interface_names="`shcat /etc/hostname.* 2>/dev/null`"
ifconfig $1 "`shcat /etc/hostname\.$1`" netmask + -trailers up
```

- `shcat` stampa il contenuto di un file; le virgolette inverse (`` `…` ``)
  eseguono il comando e ne inseriscono il risultato nella riga.
- La prima riga ricava il nome host dal file `/etc/hostname.le0` (o
  equivalente).
- L'ultima riga configura l'interfaccia passandole quel nome; `netmask +` dice
  a `ifconfig` di prendere la netmask dalla tabella `/etc/netmasks` invece che
  da un valore scritto in linea; `-trailers` disattiva il vecchio trailer
  encapsulation dell'epoca e `up` attiva l'interfaccia.

Perché passare un *nome* e non un indirizzo? Perché `/etc/hosts` mette in
relazione nomi e indirizzi IP. Una macchina poteva essere indicata semplicemente
come `data` e il sistema ricavava da `/etc/hosts` l'indirizzo corrispondente.
La catena era:

```text
file di configurazione
      ↓
nome dell'host
      ↓
risoluzione in /etc/hosts
      ↓
ifconfig
      ↓
interfaccia attiva
```

Il file `/etc/hosts` del firewall è pubblico e mostra esattamente questo
schema, con `data`, `users`, `shell`, le interfacce `fw-*`, il router
`intf-idt` e i nomi della rete ufficio:
[`systems/firewall/network/hosts`](../systems/firewall/network/hosts).
La stessa idea - l'identità di rete affidata a file di testo leggibili e
concatenabili - è al centro della filosofia Unix descritta all'inizio di questa
sezione.

> Le identità di rete di DATA e USERS (`/etc/hosts`, `/etc/netmasks`,
> `/etc/networks`, `rc.route`) sono pubblicate accanto ai rispettivi componenti:
> [`systems/data/system`](../systems/data/system/README.md) e
> [`systems/users/system`](../systems/users/system/README.md).

## DATA e USERS: il firewall come unico gateway

Per una workstation come `marco` basta una default route. I due server
centrali avevano invece una situazione particolare: DATA e USERS non erano
appoggiati a una normale LAN condivisa, ma ognuno aveva un segmento Ethernet
dedicato verso una specifica interfaccia di FireWall-1. Il loro file
`rc.route` costruiva di conseguenza una tabella di routing particolare:

**Reperto** — `rc.route` di DATA ([`systems/data/system/rc.route`](../systems/data/system/rc.route)) e di USERS ([`systems/users/system/rc.route`](../systems/users/system/rc.route)); le due versioni differiscono solo per i commenti:

```sh
hostname=`hostname`
route delete intfnet $hostname
route add $hostname $hostname 0
route add default fw-$hostname 1
```

- La prima riga assegna alla variabile `hostname` il nome corrente della
  macchina (per DATA vale `data`, per USERS vale `users`).
- `route delete intfnet $hostname` cancella la route connessa e generica per
  l'intera rete `206.20.95` su quell'interfaccia.
- `route add $hostname $hostname 0` aggiunge una route solo per sé stesso.
- `route add default fw-$hostname 1` imposta come default gateway l'interfaccia
  del firewall corrispondente: per DATA diventa `fw-data`, per USERS
  `fw-users`.

Quindi:

```text
DATA  -------- fw-data
                 |
              FIREWALL

USERS -------- fw-users
                 |
              FIREWALL
```

Non esisteva una grande Ethernet su cui tutti i server si vedevano
direttamente: il firewall era parte integrante della topologia, e ogni server
vedeva il resto dell'infrastruttura solo attraverso la propria interfaccia del
firewall.

Lo stesso schema vale per gli script di avvio `rc.local`, che differivano per
ruolo: [`systems/data/system/rc.local`](../systems/data/system/rc.local),
[`systems/users/system/rc.local`](../systems/users/system/rc.local) e
[`systems/firewall/network/rc.local`](../systems/firewall/network/rc.local).

## Il firewall: cinque interfacce, più reti

FireWall-1 girava su una Sun con **cinque interfacce Ethernet** (la tabella
completa è nella sezione "Firewall e segmentazione"). Questo cambia il
problema: una macchina normale deve sapere qual è il proprio IP, mentre il
firewall deve sapere quali reti sono collegate a ciascuna delle sue interfacce
e dove inoltrare il traffico. Il suo `rc.route` è uno dei reperti più
istruttivi dell'archivio.

**Reperto** — [`systems/firewall/network/rc.route`](../systems/firewall/network/rc.route):

```sh
ifconfig le0 netmask 255.255.255.128
ifconfig qe3 fw-world netmask 255.0.0.0
route add net 206.20.95.64 ts1 1
route add net 206.20.115.0 10.0.3.1 1
route add net 206.20.224.0 10.0.4.1 1
route add net 206.20.225.0 10.0.5.1 1
route add net default intf-idt 1
```

- `ifconfig le0 netmask 255.255.255.128` configura l'interfaccia office
  (`le0`) sulla metà alta `206.20.95.128/25`.
- `ifconfig qe3 fw-world netmask 255.0.0.0` configura l'interfaccia world
  (`qe3`) sul backbone `10.0.0.0/8`, con l'indirizzo `10.0.0.1`.
- `route add net 206.20.95.64 ts1 1` manda la rete dial-up di Milano
  all'access server `ts1` (`10.0.2.1`).
- Le tre righe seguenti mandano le reti dial-up di Pesaro, Palermo e
  Gorgonzola ai rispettivi router (`10.0.3.1`, `10.0.4.1`, `10.0.5.1`).
- `route add net default intf-idt 1` è la default route: tutto ciò che non è
  una rete Internet Force va verso il Cisco 2501 centrale (`intf-idt`,
  `10.0.1.1`) e da lì a Internet.

Questo è il punto in cui la piccola rete del provider si collega al resto di
Internet.

## Routing host-specific: perché cancellare una route

Il blocco più interessante è quello che configura il segmento DATA:

**Reperto** — [`systems/firewall/network/rc.route`](../systems/firewall/network/rc.route):

```sh
ifconfig qe0 fw-data netmask 255.255.255.192
route delete intfnet fw-data
route add host data fw-data 0
route add host 206.20.95.20 fw-data 0
```

Perché configurare un'interfaccia e subito dopo cancellare la route verso la
sua rete? Perché quel segmento non andava trattato come una normale LAN in cui
qualsiasi indirizzo della sottorete è automaticamente raggiungibile. La route
generica - «tutta la rete dietro `fw-data`» - viene rimossa e sostituita da
destinazioni esplicite: l'host `data` e singoli indirizzi.

Sul lato USERS lo schema è identico:

```sh
ifconfig qe1 fw-users netmask 255.255.255.192
route delete intfnet fw-users
route add host users fw-users 0
route add host 206.20.95.21 fw-users 0
```

Gli indirizzi `.20`–`.35` sono gli indirizzi di interfaccia virtuale usati dai
siti web ospitati, descritti in [Web, news e FTP](05-web-news-ftp.md). In
questo modo il firewall conosce **solo gli indirizzi che devono realmente
esistere su quel segmento**: il routing non era soltanto connettività, era già
parte dell'architettura di sicurezza. Il file completo è
[`systems/firewall/network/rc.route`](../systems/firewall/network/rc.route);
la configurazione di rete del firewall, con le sue tabelle, è in
[`systems/firewall/network/`](../systems/firewall/network/README.md).

## Lo strato temporale del `rc.route`

Il `rc.route` recuperato dal firewall non appartiene a un solo istante:
contiene anche reti aggiunte durante l'espansione del 1996.

```text
206.20.226.0
206.20.227.0
206.20.228.0
206.20.230.0
206.20.231.0
```

Queste righe vanno lette come **strato successivo**, non retrodatate al 1995:
descrivono i POP aggiunti l'anno seguente. È un promemoria generale: i reperti
recuperati possono provenire da momenti diversi e vanno collocati nel tempo,
non trattati come un unico snapshot.

## I file di supporto della configurazione di rete

Attorno agli script stavano alcuni file di testo che vale la pena conoscere,
tutti pubblici nella directory
[`systems/firewall/network/`](../systems/firewall/network/README.md):

- [`hosts`](../systems/firewall/network/hosts) — la tabella nomi ↔ indirizzi,
  usata prima di (e insieme a) il DNS.
- [`netmasks`](../systems/firewall/network/netmasks) — la netmask associata a
  ciascuna rete; è il file che `ifconfig ... netmask +` consultava.
- [`networks`](../systems/firewall/network/networks) — i nomi simbolici delle
  reti (`intf-world`, `intf-office`, `intf-dialup`, `intf-servers`,
  `intfnet`), che compaiono anche nelle route del firewall.
- [`defaultrouter`](../systems/firewall/network/defaultrouter) — contiene una
  sola riga, `intf-idt`, il gateway di default per gli host che ne usano uno
  solo.
- [`resolv.conf`](../systems/firewall/network/resolv.conf) — la configurazione
  del resolver DNS: dominio `internetforce.com` e name server
  `206.20.95.3`/`206.20.95.4` (DATA e USERS).
- [`inetd.conf`](../systems/firewall/network/inetd.conf) — i pochi servizi
  gestiti dal super-server `inetd` sul firewall; l'analisi del hardening e di
  `inetd` è in [Sicurezza](06-security.md).

## Cosa deve portarsi a casa il lettore

Configurare la rete di una macchina Unix significava essenzialmente rispondere
a quattro domande:

```text
Chi sono?
→ hostname + IP

Quali host posso raggiungere direttamente?
→ netmask + rete locale

Dove mando tutto il resto?
→ default gateway

Ci sono destinazioni che richiedono percorsi particolari?
→ route specifiche
```

Su una workstation bastavano poche righe; su un firewall multihomed le stesse
idee diventavano una vera topologia di rete. Solo dopo questi passaggi aveva
senso parlare di servizi:

```text
ha un indirizzo
      ↓
sa qual è la propria rete
      ↓
sa dove inviare il traffico esterno
      ↓
è raggiungibile dagli altri sistemi autorizzati
```

Un server web perfettamente configurato ma senza indirizzo IP e route corrette
è, tecnicamente, un ottimo modo di servire pagine web a nessuno. Per questo nel
percorso di questo archivio la configurazione di rete viene prima dei singoli
servizi.

## Filosofia Unix e identità di rete

Dietro le configurazioni appena lette c'è il modello Unix su cui erano
costruiti i server Internet Force. I server SunOS erano amministrati
principalmente attraverso **riga di comando, file di testo e processi**: DATA e
USERS erano headless e non si configuravano aprendo pannelli grafici. L'idea di
fondo è che lo stato del sistema sia leggibile e riproducibile - leggere un
file, lanciare un comando, concatenare azioni con uno script - invece di
dipendere da una singola azione manuale.

L'**identità di rete** di un host Unix era fatta esattamente di questi
elementi: `/etc/hosts` forniva le associazioni locali fra indirizzi e nomi,
mentre gli script di avvio (`rc.route`, `rc.inet1`, `rc.boot`) configuravano
interfacce e routing. Sul firewall, per esempio, la configurazione distingue
le cinque interfacce già viste:

```text
le0  → office       206.20.95.129/25
qe0  → fw-data      206.20.95.10
qe1  → fw-users     206.20.95.11
qe2  → fw-shell     206.20.95.12
qe3  → fw-world     10.0.0.1/8
```

Internet Force **non usava deliberatamente NIS né NFS** in produzione: ogni
server teneva i propri dati e autenticava localmente, con XTACACS unico
servizio di credenziali condiviso. Il commento nel file `networks` - "questo
file non viene mai consultato quando NIS è in esecuzione" - ricorda che i
reperti contengono anche porzioni preparatorie standard che non riflettono
l'uso operativo. L'analisi completa è in [Sicurezza](06-security.md).

Fra l'identità dell'host e i servizi che espone c'è un ultimo passaggio: un
indirizzo IP identifica l'host, mentre protocollo e porta distinguono i singoli
servizi (SMTP, POP3, IMAP, XTACACS su USERS). Ma «quali sorgenti possono
raggiungere quali servizi» è una domanda di sicurezza, non di indirizzamento:
la si affronta in [Sicurezza](06-security.md) e nella
[guida tecnica di FireWall-1](../systems/firewall/TECHNICAL.md).

---

## Continua

- [La sessione dial-up](02-dialup-session.md) — come una chiamata telefonica
  diventava una sessione IP.
- [Sicurezza](06-security.md) — il firewall, l'hardening e il confinamento.
- [Crescita della rete 1995 → 1996](13-network-growth-1995-1996.md) — i POP e
  le reti aggiunti l'anno successivo.

---

→ [Costruire un Internet Force POP, passo per passo](00-build-an-isp.md)
