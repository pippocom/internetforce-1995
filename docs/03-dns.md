🇮🇹 **Italiano** · [🇬🇧 English](03-dns.en.md)

# DNS

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

Gli utenti non volevano ricordare `206.20.95.3`: volevano usare nomi come
`www.internetforce.com`. Il **Domain Name System (DNS)** risolve questo
problema con un database gerarchico e distribuito, in cui ogni livello delega
autorità a quello successivo e nessun nodo conosce l'intero albero. Internet Force
gestiva il proprio servizio dei nomi con **BIND**. Il server **DATA**
(`206.20.95.3`) era il nameserver primario; il server **USERS**
(`206.20.95.4`) era il secondario. Entrambi eseguivano BIND 4, la versione
dell'epoca, configurata tramite `/etc/named.boot` e non con il più recente
formato `named.conf`.

La versione puntuale di BIND (ad esempio `4.x.y`) non è attestata nei file
recuperati: l'archivio documenta lo **stile** della configurazione - le
direttive `cache`, `primary`, `secondary` di BIND 4 - ma non il numero di
release. È una lacuna dichiarata, non un dato mancante da inventare.

I file di configurazione e le zone recuperati sono in
[`systems/data/dns/`](../systems/data/dns/README.md).

## Il resolver e i server autoritativi

Per capire come i nomi diventavano indirizzi servono due ruoli distinti:

- il **resolver** (o *stub resolver*) è il lato client: una libreria presente su
  ogni macchina che, quando un programma chiede `www.internetforce.com`, invia
  la domanda ai nameserver configurati;
- il **server autoritativo** è il lato che conserva i dati di una zona e
  risponde con autorità, cioè garantendo che quella risposta proviene dalla
  fonte del dominio.

BIND può svolgere entrambi i ruoli. In Internet Force DATA e USERS erano i
server autoritativi per le zone Internet Force e dei clienti; ogni host della
rete aveva invece il proprio resolver configurato per interrogarli.

## Ruoli dei server

Il primario aveva i dati autoritativi per i domini Internet Force e per i domini
dei clienti ospitati. Il secondario trasferiva le zone dal primario e poteva
rispondere alle query se il primario non era disponibile. Ogni server della
rete puntava a entrambi:

```
domain internetforce.com
nameserver 206.20.95.3
nameserver 206.20.95.4
```

Il firewall, DATA, USERS e le macchine dell'ufficio usavano la stessa
configurazione del resolver, con `host.conf` che ordinava `bind,hosts` sui
server (prima la risoluzione via DNS, poi il file hosts locale) e `hosts,bind`
sul firewall.

## `named.boot`

`named` doveva sapere dove trovare i propri dati e per quali zone fosse
autoritativo. In BIND 4 questo si dichiarava in `named.boot`, il file di avvio
del servizio. Le direttive principali sono:

- `directory`: la directory base dei file DNS.
- `cache .`: il file di root hints, punto di partenza per raggiungere i root
  name server.
- `primary`: questa macchina è master autoritativo per la zona e la carica da
  un file locale.
- `secondary`: questa macchina mantiene una copia autoritativa ottenuta dal
  master tramite zone transfer.

Il `named.boot` recuperato è in
[`systems/data/dns/named.boot`](../systems/data/dns/named.boot). Le righe
iniziali mostrano la struttura reale:

```
directory /usr/local/etc/named/named-data

; type    domain                    source host/file    backup file
cache     .                         root.cache
primary   internetforce.com         primary/internetforce.com
primary   intf.com                  primary/intf.com
primary   pippo.com                 primary/pippo.com
primary   internetforce.it          primary/internetforce.it
...
primary   95.20.206.IN-ADDR.ARPA    primary/db.206.20.95
```

## I root server e il file di cache

Il DNS è gerarchico: al vertice c'è la radice `.`, sotto di essa i domini di
primo livello come `com` e `it`, e sotto ancora i domini come `pippo.com` o
`internetforce.it`.

```
                    .
               root servers
                    │
          ┌─────────┴─────────┐
         com                 it
          │                   │
      pippo.com       internetforce.it
```

Il file indicato da `cache .` non è la cache ordinaria delle query: contiene i
**root hints**, cioè i nomi e gli indirizzi da cui `named` inizia a raggiungere
la radice. L'originale Internet Force è
[`systems/data/dns/named-data/root.cache`](../systems/data/dns/named-data/root.cache),
derivato da `nic.ddn.mil` e aggiornato fino ai primi anni Novanta. Elenca nove
root server, da `A.ROOT-SERVERS.NET` a `I.ROOT-SERVERS.NET`, con i relativi
record `A` (per esempio `A` → `198.41.0.4`, `B` → `128.9.0.107`). È un elenco
storico: non va sostituito con quello moderno, perché il suo valore è
documentare **quali** root hints avesse il server nel 1995–1996.

## Domini e zone

Il primario serviva tre domini Internet Force più un portafoglio di domini
clienti e virtuali:

- `internetforce.com`
- `intf.com`
- `internetforce.it`
- domini clienti/virtuali tra cui `canalemoda.com`, `sicilia.com`, `pesaro.com`,
  `pcpesaro.com`, `art-diary.com`, `creo-mi.com`, `boldyoung.com`,
  `loveisland.com`, `shiseidoit.com`, `calabria.com`, `glassonline.com`,
  `tecnos.com`, `nassetti.com`, `financialreports.com`, `net-pool.com`,
  `pippo.com`, `promotion.it` e `tera-it.com`.

`intf.com` era una zona interna parallela a `internetforce.com`: ripeteva la
stessa struttura di host e servizi e usava `MX 0` verso `users.internetforce.com`
e `MX 1` verso `data.internetforce.com` (file
[`intf.com`](../systems/data/dns/named-data/primary/intf.com)).

`cnn.it` era servito come secondario. Le zone inverse coprivano i blocchi di
indirizzi dei POP `206.20.95`, `206.20.115`, `206.20.224`, `206.20.225`,
`206.20.226` e `206.20.227`.

La zona `.com` era delegata attraverso i nameserver IOS usati dal collegamento
IDT (`styx`, `noc`, `harley`), mentre la zona `.it` usava i nameserver italiani
GARR. Queste deleghe riflettono come sono stati registrati i domini, non
qualcosa che Internet Force abbia configurato da sé.

## Registrare un dominio: InterNIC, GARR e la delega

Creare localmente una zona `pippo.com` non basta perché il nome sia
risolvibile da Internet. Il dominio deve prima essere **registrato** e
**delegato** nella gerarchia globale, e solo dopo i nameserver autoritativi
possono rispondere per esso. Nel 1995 i domini generici (`com`, `org`, `net`)
passavano attraverso InterNIC/Network Solutions; per il dominio `.it`
Internet Force interagiva con la struttura italiana collegata al GARR/Registro.

Il materiale già recuperato per `PIPPO.COM` documenta l'esito della
registrazione:

```
Record created: 10-May-95
Primary DNS:    DATA.INTERNETFORCE.COM
Secondary DNS:  HARLEY.IOS.COM
```

È presente anche una successiva richiesta `MODIFY DOMAIN pippo.com` con ACK
InterNIC. Il percorso è sempre lo stesso: richiesta di dominio →
registro/NIC → nameserver dichiarati → `named.boot` → file di zona → dominio
risolvibile.

### Come si registrava concretamente un dominio `.it`

Nel 1996 la registrazione di un dominio `.it` era una procedura in più
passaggi, nella quale la configurazione tecnica precedeva la registrazione
vera e propria.

**Per prima cosa si preparava il DNS del nuovo dominio.** Dovevano essere
già disponibili i nameserver autoritativi che avrebbero gestito la zona,
con almeno un primario e un secondario. Nelle richieste conservate da
Internet Force venivano indicati nome e indirizzo IP dei server. Per
`internetforce.it`, ad esempio, la richiesta del 21 giugno 1996 indicava
`dns.internetforce.it` e il secondario `dns.nis.garr.it`; nelle successive
registrazioni di domini ospitati da Internet Force ricorrono analogamente
il DNS Internet Force e il secondario del GARR-NIS.

**La richiesta tecnica veniva quindi inviata per posta elettronica al
GARR-NIS**, all'indirizzo `domain@nis.garr.it`, con `staff@nis.garr.it`
utilizzato nella corrispondenza con lo staff. Il “modulo” era in pratica
un oggetto strutturato destinato al database del registro. Comprendeva il
nome del dominio e dell'organizzazione, una descrizione, l'`admin-c`, uno
o più `tech-c`, il `postmaster`, lo `zone-c`, i nameserver con i relativi
indirizzi, la rete associata e le schede delle persone coinvolte con
indirizzo, telefono, fax ed email.

Quando l'organizzazione non era già registrata nel database GARR-NIS,
veniva trasmesso separatamente anche un **modulo di registrazione
dell'organizzazione** a `ORG-REG@NIS.GARR.IT`. Quello inviato da Internet
Force riportava ragione sociale, sede, provincia, CAP, paese, telefono e
fax, il dominio associato, il responsabile della directory e i riferimenti
delle persone amministrative e tecniche. La stessa sequenza è conservata,
ad esempio, nella successiva registrazione di `cnn.it`.

A quel punto iniziavano i controlli del registro. Una prima procedura
automatica, indicata nelle risposte come **GARR NIS Syntax Phase**,
verificava la correttezza formale degli oggetti ricevuti. Superato il
controllo sintattico, la richiesta passava allo staff della Registration
Authority per il **controllo semantico**, che comprendeva la verifica del
nome richiesto e il confronto con la documentazione del soggetto
registrante.

La parte elettronica non bastava. Il richiedente doveva anche
sottoscrivere la **Lettera di Assunzione di Responsabilità (LAR)** e,
nel caso di una società, fornire la documentazione societaria richiesta,
compresa la visura camerale. Per `internetforce.it` è conservata una mail
del 24 giugno 1996 nella quale Internet Force comunica al GARR-NIS di
avere disposto l'invio via fax sia della LAR sia delle informazioni
dettagliate sulla società. Il recapito riportato nelle firme del
GARR-NIS dell'epoca era presso il CNUCE-CNR di Pisa, via S. Maria 36,
fax `+39 50 904052`.

Solo dopo il superamento dei controlli amministrativi e tecnici il
dominio veniva inserito nel database GARR-NIS e la registrazione/delega
poteva essere completata. Le registrazioni successive conservate
nell'archivio mostrano chiaramente il ciclo: per `cnn.it`, per esempio,
alla richiesta del 2 settembre 1996 segue nello stesso giorno il messaggio
`Syntax Check Phase OK`; l'11 settembre arriva `Update OK` e la notifica
della creazione dell'oggetto `cnn.it` nel database. Per `promotion.it`,
la richiesta del 19 settembre supera il controllo sintattico e il nuovo
oggetto compare nel database il 24 settembre.

Il controllo non era soltanto amministrativo. Il GARR-NIS verificava
anche alcuni requisiti operativi: il 1º agosto 1996 inviò automaticamente
un messaggio a `postmaster@internetforce.it` per controllare che
l'indirizzo `postmaster@<dominio>` previsto dalle regole fosse
effettivamente raggiungibile.

La documentazione conservata mostra quindi un processo molto diverso
dall'attuale registrazione quasi istantanea tramite registrar:
**DNS già predisposto → richiesta tecnica via email → eventuale
registrazione dell'organizzazione → controllo sintattico automatico →
LAR e documentazione societaria via fax → controllo semantico della
Registration Authority → inserimento nel database e delega**.

Gli esempi conservati (`internetforce.it`, `cnn.it`, `promotion.it`), i
moduli e il test sul postmaster sono negli scambi con il GARR-NIS: vedi
[`domini_it.txt`](../artifacts/domain-registration/domini_it.txt), gli
[artefatti di registrazione domini](../artifacts/domain-registration/README.md)
e la corrispondenza
[`GARR-DOMINI_IT.mailbox`](../artifacts/email-archive/technical/GARR-DOMINI_IT.mailbox).

### Perché il `.it` era più restrittivo di `.com`/`.net`

Rispetto ai domini generici `.com`/`.net` - dove la registrazione presso InterNIC
consisteva essenzialmente nel presentare i contatti e i nameserver - il `.it` del
1996 era molto più restrittivo e amministrativamente più complesso:

- la regola generale era **un solo dominio `.it` per soggetto avente diritto**;
- le **persone fisiche** non erano ancora ammesse alla registrazione in via
  generale;
- la registrazione era rivolta a **organizzazioni o soggetti economici** con i
  necessari riferimenti legali/fiscali;
- l'assegnazione seguiva la **priorità cronologica** tra le richieste valide
  (*first come, first served*);
- servivano documentazione **amministrativa e tecnica**, e il DNS autorevole
  doveva essere configurato prima della delega;
- la **LAR** faceva parte del processo amministrativo;
- esistevano **categorie di nomi riservati**, tra cui lo spazio geografico
  italiano.

Il nome di dominio era innanzitutto un **identificatore di rete**, non un
marchio: le regole dell'epoca non imponevano che il nome coincidesse con la
ragione sociale, con un marchio registrato o con un acronimo.

Il contesto istituzionale era distinto dai suoi ruoli: la funzione di
**Registration Authority** era esercitata al **CNR-CNUCE di Pisa**, dove il
servizio **GARR-NIS** gestiva il database dei domini `.it` e la corrispondenza
con i richiedenti; la funzione di definizione delle regole - quella che sarebbe
stata in seguito formalmente costituita come **Naming Authority** italiana - era
separata dalla gestione operativa del registro. GARR era l'infrastruttura di rete
in cui il servizio operava, non un sinonimo del registro.

Questo quadro restrittivo cambiò con la **liberalizzazione entrata in vigore il
15 dicembre 1999**: per le società e i soggetti commerciali fu eliminato il
limite di un solo dominio; l'accesso fu ampliato; furono ammesse anche le persone
fisiche, inizialmente con il limite di un dominio; le procedure furono
semplificate.

Il periodo di Internet Force coincide con la prima rapida espansione del
namespace `.it`. Secondo i dati storici riportati da Stefano Trumpy, le **nuove
registrazioni durante l'anno** furono circa **1.312 nel 1995**, **5.243 nel
1996**, **14.807 nel 1997** e **16.148 nel 1998**; la registrazione `.it` restò
gratuita fino alla fine del 1997.

## Leggere una zona

Una zona DNS è un file di testo con record di tipi diversi. I più importanti
per leggere le zone Internet Force sono:

```
SOA     autorità e parametri della zona
NS      name server autoritativi
A       nome → indirizzo IPv4
CNAME   alias → nome canonico
MX      server di posta, con priorità
PTR     indirizzo → nome, nelle zone inverse
```

Ogni record ha un *owner* (il nome a cui si riferisce), una classe (qui sempre
`IN`) e un valore. Il `SOA` definisce il seriale della zona e i tempi di
refresh/retry/expire; i record `NS` elencano i nameserver autoritativi; gli `A`
e i `CNAME` mappano nomi a indirizzi o ad altri nomi; gli `MX` instradano la
posta.

## La zona `internetforce.com`

La zona recuperata è l'esempio migliore per mostrare l'infrastruttura del
provider. Il file completo è
[`systems/data/dns/named-data/primary/internetforce.com`](../systems/data/dns/named-data/primary/internetforce.com);
questo è l'inizio:

```
@  IN  SOA  dns dnsmaster.internetforce.com. (
        1996091101 ; Serial
        10800      ; Refresh 3 hours
        3600       ; Retry 1 hour
        604800     ; Expire after a week
        86400 )    ; Minimum ttl 1 day
              NS  styx.ios.com.
              NS  noc.ios.com.
              NS  harley.ios.com.
```

Il seriale `1996091101` colloca questa versione nel settembre 1996. Le stesse
`NS` IOS (`styx`, `noc`, `harley`) compaiono anche nella descrizione delle
deleghe: sono i nameserver con cui i domini erano registrati. La zona identifica
`dns` (206.20.95.3) e `dns2` (206.20.95.4), coerenti con il primario DATA e il
secondario USERS, e contiene sia gli host centrali sia le macchine d'ufficio,
oltre a `fw-data`, `fw-users`, `fw-shell`, `PcDemo` e `oracolo`.

## Nomi di host e servizi

La zona diretta elencava gli host centrali e le macchine dell'ufficio:

```
data      A  206.20.95.3
users     A  206.20.95.4
shell     A  206.20.95.5
firewall  A  206.20.95.129
dvlp      A  206.20.95.130
anna      A  206.20.95.131
franz     A  206.20.95.132
maxi      A  206.20.95.133
html      A  206.20.95.134
aps       A  206.20.95.135
cust2     A  206.20.95.136
isa       A  206.20.95.137
marco     A  206.20.95.140
```

Alias noti puntavano i servizi all'host giusto:

```
mailhost, mail   CNAME  users.internetforce.com.
loghost          CNAME  dvlp.internetforce.com.
ftp, proxy, www1 CNAME  data.internetforce.com.
www              CNAME  users.internetforce.com.
```

L'instradamento della posta usava record MX: `internetforce.com` preferiva
USERS (`MX 0`) e ripiegava su DATA (`MX 1`):

```
internetforce.com.  MX  0  users.internetforce.com.
                    MX  1  data.internetforce.com.
```

`loghost` puntava a DVLP perché il `syslog` centrale si raccoglieva su DVLP.

## La zona `pippo.com`

`pippo.com` permette invece di seguire un dominio ospitato dal provider
dall'atto di registrazione fino alla zona servita da BIND. Il file completo è
[`systems/data/dns/named-data/primary/pippo.com`](../systems/data/dns/named-data/primary/pippo.com):

```
@  IN  SOA  pippo.com dnsmaster.internetforce.com. (
        1996092401 ; Serial
        10800      ; Refresh 3 hours
        3600       ; Retry 1 hour
        604800     ; Expire after a week
        86400 )    ; Minimum ttl 1 day
              NS  harley.ios.com.
              NS  dns.internetforce.com.
              NS  dns2.internetforce.com.
pippo.com.    MX  0  internetforce.com.
www           A   206.20.95.25
dns           A   206.20.95.3
```

Alcuni dettagli legano registrazione e configurazione:

- `harley.ios.com` compare sia come `Secondary DNS` nel record InterNIC del
  10 maggio 1995 sia come `NS` della zona;
- `dns.internetforce.com` e `dns2.internetforce.com` sono DATA e USERS,
  cioè i nameserver autoritativi del provider;
- `MX 0 internetforce.com` inoltra la posta di `pippo.com` alla zona
  `internetforce.com`, che poi la smista su USERS/DATA;
- `www` risolve a `206.20.95.25`, lo stesso indirizzo che la zona inversa
  associa a `www.pippo.com`.

Va notato che i materiali sono **strati temporali diversi**: la registrazione
InterNIC è del maggio 1995, mentre il seriale di questa zona è `1996092401`,
del settembre 1996. Sono due fotografie dello stesso dominio in momenti
distinti, non un'unica istantanea.

## Reverse DNS

Il DNS resolve anche nella direzione opposta, attraverso il dominio
`in-addr.arpa` e i record `PTR`:

```
nome → IP       forward DNS
IP   → nome     reverse DNS
```

La reverse zone copriva il blocco `206.20.95` e il file è
[`systems/data/dns/named-data/primary/db.206.20.95`](../systems/data/dns/named-data/primary/db.206.20.95).
Oltre agli host centrali (`3 PTR data`, `4 PTR users`, `5 PTR shell`, ecc.),
la zona riserva gli indirizzi `.20`–`.35` ai siti web virtuali dei clienti:

```
20  PTR  www.canalemoda.com.
21  PTR  www.sicilia.com.
22  PTR  www.pesaro.com.
...
25  PTR  www.pippo.com.
...
35  PTR  www.financialreports.com.
```

Avendo un record `PTR` corrispondente a ogni nome, i log di connessione
diventavano leggibili e i pool di indirizzi ottenevano uno schema di nomi
pulito.

## Record dial-up e clienti

Ogni terminale dial-up aveva un nome diretto e un record PTR corrispondente:

- `ppp1-milano` … `ppp16-milano` → 206.20.95.70–85
- `ppp1-pesaro` … `ppp16-pesaro` → 206.20.115.2–17
- `ppp1-palermo` … `ppp16-palermo` → 206.20.224.2–17
- `ppp1-gorgonzola` … `ppp16-gorgonzola` → 206.20.225.2–17

## Host web virtuali (VIF)

Le zone dirette e inverse riservavano indirizzi per i siti web virtuali: i nomi
da `www.20` a `www.35` mappavano gli host virtuali dei clienti che DATA serviva
attraverso lo schema VIF (*virtual interface*). Questo permetteva a molti
domini clienti di condividere il server web DATA pur mantenendo indirizzi
distinti.

## Gestione delle zone

Le zone erano generate da file sorgente master da uno script (`makezones`,
versione 0.10), guidato da un `Makefile` che ricaricava anche il nameserver. Un
nuovo dominio cliente si aggiungeva copiando un master `.source` esistente,
modificandolo, aggiungendo una riga `primary` a `named.boot`, eseguendo
`makezones` e segnalando `named`. È descritto nel `new_dns-HOWTO` recuperato,
che registra anche la procedura per registrare un nuovo dominio e il suo MAC
address su `le0` presso il registry upstream.

La directory conserva anche un `named.boot.save`, versione precedente del file
di avvio: confrontandolo con quello corrente si vede l'evoluzione del
portafoglio di zone, senza dover fondere le due fotografie.

## Il percorso completo di `pippo.com`

Mettendo insieme i passaggi, la storia di un dominio ospitato è questa:

```
richiesta di registrazione
        │
        ▼
InterNIC / delega
        │
        ▼
nameserver autoritativi (harley.ios.com, dns/dns2.internetforce.com)
        │
        ▼
named.boot su DATA
        │
        ▼
zona pippo.com
        │
        ├── SOA
        ├── NS
        ├── MX
        └── A / CNAME
        │
        ▼
query da Internet
```

È questo il punto importante: DNS non era una rubrica centralizzata. Ogni
livello delegava autorità al successivo, e la zona locale di Internet Force
diventava parte di Internet solo dopo la registrazione e la delega.

## Approfondimenti

- [Aggiungere un nuovo dominio cliente: workflow](../systems/data/dns/DOMAIN-PROVISIONING-WORKFLOW.md)
  — la sequenza operativa moderna, con il [HOWTO originale](../systems/data/dns/new_dns-HOWTO.txt).
- [BIND su DATA: guida tecnica](../systems/data/dns/TECHNICAL.md) — riferimento
  tecnico più dettagliato sulle configurazioni.
- [Registrazione domini: artefatti InterNIC e GARR](../artifacts/domain-registration/README.md)
- [Configurazione DNS e zone (DATA)](../systems/data/dns/README.md)
- [Server DATA](../systems/data/README.md)
- [Sicurezza: servizi e hardening](06-security.md)

---

Vedi anche: [Panoramica dell'architettura](01-architecture.md) ·
[Posta](04-email.md) ·
[Web, FTP, news e mailing list](05-web-news-ftp.md)

---

→ [Costruire un Internet Force POP, passo per passo](00-build-an-isp.md)
