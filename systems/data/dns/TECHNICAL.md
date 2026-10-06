🇮🇹 **Italiano** · [🇬🇧 English](TECHNICAL.en.md)

# DNS tecnico: come funzionava Internet Force

> **Internet Force 1995--1996 Historical Archive**\
> Ricostruzione e documentazione tecnica basate sui materiali originali
> Internet Force conservati da **Marco Iannacone**.\
> Autore e curatore dell'archivio: **Marco Iannacone** ·
> https://pippo.com

Internet Force gestiva il proprio DNS sul server **DATA** (`206.20.95.3`),
con **USERS** (`206.20.95.4`) come secondario. Questa pagina spiega come era
configurato il servizio leggendo direttamente i file recuperati: il file di
boot di BIND, i root hints, le zone `internetforce.com` e `pippo.com`, la zona
inversa e il rapporto con la registrazione dei domini.

## 1. DATA e il DNS autoritativo

DATA era il nameserver primario di Internet Force; USERS svolgeva il ruolo di
secondario ed era raggiungibile anche come `dns2.internetforce.com`. Nelle zone
i due server compaiono come `dns` (`206.20.95.3`) e `dns2` (`206.20.95.4`).

Nella configurazione recuperata di DATA, `named` era avviato da `rc.local` come
server primario, con il file di boot passato esplicitamente:

``` text
if [ -d /usr/local/etc/named ]
then
	echo -n "PRIMARY NAME SERVER: "
	/usr/etc/named -b /usr/local/etc/named/named.boot
	echo done
elif [ -s /etc/named.boot ]
then
	echo -n "SECONDARY NAME SERVER: "
	/usr/etc/named
	echo done
fi
```

Il ramo `PRIMARY NAME SERVER` è quello che DATA eseguiva; il ramo `elif`
riguarda il caso di un server secondario, non usato su DATA. Il file di
configurazione letto da `named` è [`named.boot`](named.boot).

## 2. `named.boot`: la configurazione di BIND

Nella generazione di BIND usata all'epoca il server si configurava con un file
di boot testuale, `named.boot`; il `named.conf` con sintassi a blocchi appartiene
alle versioni successive e non compare in questo archivio. Il file recuperato
dichiara la directory di lavoro, i root hints e l'elenco delle zone:

``` text
directory /usr/local/etc/named/named-data

; type	  domain			source host/file	backup file
cache	  .				root.cache
primary   internetforce.com  			primary/internetforce.com
primary   intf.com       			primary/intf.com
primary   pippo.com                 primary/pippo.com
primary	  internetforce.it 			primary/internetforce.it
```

e, più avanti nello stesso file, le zone ottenute da altri server e la zona
inversa principale:

``` text
secondary cnn.it			206.20.228.70 secondary/cnn.it
secondary 228.20.206.IN-ADDR.ARPA       206.20.228.70 secondary/db.206.20.228
primary   95.20.206.IN-ADDR.ARPA	primary/db.206.20.95
```

Significato delle direttive, secondo la documentazione BIND e i documenti RFC
dell'epoca:

- **`directory`** — la directory di base usata per risolvere i nomi di file
  relativi; qui è `/usr/local/etc/named/named-data`, quindi i percorsi come
  `primary/internetforce.com` o `root.cache` si intendono relativi a quella
  directory.
- **`cache . root.cache`** — carica i *root hints*: il file da cui `named`
  ricava l'elenco iniziale dei server della radice (`cache` per la zona `.`).
- **`primary <zona> <file>`** — dichiara che questo server è autoritativo
  (primario/master) per la zona indicata e ne legge i dati dal file indicato.
  Nel file recuperato sono `primary` `internetforce.com`, `intf.com`,
  `pippo.com`, `internetforce.it` e molte altre zone cliente, oltre alle zone
  inverse `95.20.206.IN-ADDR.ARPA` e simili.
- **`secondary <zona> <indirizzo-master> <file>`** — dichiara una zona di cui
  questo server non è master: la copia viene ottenuta periodicamente dal server
  master indicato con il trasferimento di zona, e conservata nel file di backup.
  Nel file recuperato questo vale per `cnn.it` e per la sua zona inversa,
  ottenute dal master `206.20.228.70`.

Lo stesso schema compare in [`named.boot.save`](named.boot.save), una variante
precedente del file di boot: contiene le stesse direttive `directory`, `cache` e
`primary` per un insieme di zone in parte diverso e senza le due `secondary`.
Non è la configurazione attiva ma documenta l'evoluzione dell'elenco delle zone.

## 3. Root hints: come il resolver trovava la radice

La direttiva `cache . root.cache` indica il file dei root hints. Il file
recuperato è [`named-data/root.cache`](named-data/root.cache):

``` text
.               99999999        IN	NS	A.ROOT-SERVERS.NET.
.		99999999	IN	NS	B.ROOT-SERVERS.NET.
.               99999999        IN	NS	C.ROOT-SERVERS.NET.
.               99999999        IN	NS	D.ROOT-SERVERS.NET.
.               99999999        IN	NS	E.ROOT-SERVERS.NET.
.               99999999        IN	NS	F.ROOT-SERVERS.NET.
A.ROOT-SERVERS.NET.	99999999	IN	A        198.41.0.4
B.ROOT-SERVERS.NET.	99999999	IN	A        128.9.0.107  ; BIND
```

I record `NS` con owner `.` elencano i server della radice; i record `A` con lo
stesso nome forniscono gli indirizzi, necessari perché il resolver possa
contattare quei server senza dover prima risolvere un altro nome (i cosiddetti
*glue records*).

Il TTL è un valore molto alto, `99999999` secondi: questi dati servivano solo a
bootstrapare la risoluzione e venivano poi sostituiti dalla lista corrente dei
root server ottenuta interrogando la radice, quindi si voleva che restassero a
lungo nella cache. Secondo la documentazione dell'epoca, un record senza TTL
esplicito eredita il *minimum* dello `SOA` della zona, ma qui il TTL è indicato
esplicitamente.

Questi sono i root hints **storici** dell'epoca: nomi, indirizzi e TTL vanno
letti come tali e non vanno aggiornati con i root server attuali. L'archivio
conserva anche [`named-data/root.cache.orig`](named-data/root.cache.orig), una
variante precedente con i vecchi nomi dei server della radice (`ns.nic.ddn.mil.`,
`kava.nisc.sri.com.`, `aos.brl.mil.` e altri), utile a mostrare come questa lista
sia cambiata nel tempo.

## 4. La zona `internetforce.com`

La zona principale è [`named-data/primary/internetforce.com`](named-data/primary/internetforce.com).
Comincia con `SOA` e `NS`:

``` text
@  IN	SOA	dns dnsmaster.internetforce.com. (
		1996091101	 ; Serial
		10800		 ; Refresh 3 hours
		3600		 ; Retry 1 hour
		604800		 ; Expire after a week
		86400 )	 ; Minimum ttl 1 day
				NS	styx.ios.com.
				NS	noc.ios.com.
				NS	harley.ios.com.
```

Lo `SOA` (*Start Of Authority*) apre la zona e ne definisce i parametri
autorevoli. Secondo la terminologia dei documenti dell'epoca:

- **owner** `@` — la zona corrente (`internetforce.com.`).
- **origin / primary master** `dns` — il nome del server su cui risiede il file
  master; relativo alla zona significa `dns.internetforce.com.`.
- **person / responsible party** `dnsmaster.internetforce.com.` — la casella del
  responsabile della zona, scritta con un punto al posto della chiocciola
  (`dnsmaster@internetforce.com`).
- **serial** `1996091101` — il numero di versione della zona, da incrementare a
  ogni modifica; la forma usata qui è `AAAAMMGGnn`.
- **refresh** `10800` — ogni quanto, in secondi, un secondario deve controllare
  presso il primario se la zona è cambiata (3 ore).
- **retry** `3600` — dopo quanto ritentare se il controllo fallisce (1 ora).
- **expire** `604800` — dopo quanto, senza riuscire ad aggiornarsi, la copia del
  secondario va considerata scaduta (una settimana).
- **minimum** `86400` — il TTL minimo applicato ai record privi di TTL esplicito
  (un giorno).

I record `NS` elencano i nameserver autorevoli per la zona. Il server primario
`dns.internetforce.com` è il master locale, mentre `styx.ios.com`, `noc.ios.com`
e `harley.ios.com` appartengono all'upstream IDT: sono i nameserver autorevoli
dichiarati per la zona e corrispondono, in parte, ai server indicati al registro
durante la registrazione.

Sotto la parte autorevole, la zona contiene i record di servizio:

``` text
mailhost     CNAME  users.internetforce.com.
mail     CNAME  users.internetforce.com.
loghost     CNAME  dvlp.internetforce.com.
ftp     CNAME  data.internetforce.com.
www     CNAME  users.internetforce.com.
news     CNAME  news.ios.com.
proxy     CNAME  data.internetforce.com.
dns      A  206.20.95.3
dns2      A  206.20.95.4
internetforce.com.      MX  0  users.internetforce.com.
        MX  1  data.internetforce.com.
        A  206.20.95.4
```

- **A** (*Address*) — associa un nome host a un indirizzo IPv4. Qui `dns` punta a
  `206.20.95.3` (DATA) e `dns2` a `206.20.95.4` (USERS). Più in basso la zona
  elenca anche gli host di servizio e infrastrutturali (`data`, `users`, `shell`,
  `firewall`, `dvlp`, `marco`, `oracolo`, …) e gli indirizzi dei pool dial-up
  `pppN-<pop>`.
- **CNAME** (*Canonical Name*) — crea un alias verso un nome canonico. `mailhost`,
  `mail`, `ftp`, `www`, `proxy` e `www1` sono alias di servizio (`www` è alias di
  `users.internetforce.com.`), mentre `loghost` punta a `dvlp`. `news` è un caso
  particolare, descritto più sotto.
- **MX** (*Mail eXchanger*) — indica dove consegnare la posta del dominio. Il
  valore numerico è la preferenza: più basso = preferito. Qui la posta di
  `internetforce.com.` va prima a `users.internetforce.com.` (preferenza 0) e poi,
  come alternativa, a `data.internetforce.com.` (preferenza 1). Le righe senza
  owner ripetono l'owner precedente (`internetforce.com.`).

Un record senza TTL esplicito, come in questa zona, eredita il *minimum* dello
`SOA`; tutti i nomi sono relativi alla zona tranne quelli terminati con un punto.

### La zona `internetforce.com` in una versione precedente

L'archivio conserva anche [`named-data/primary/internetforce.com.old`](named-data/primary/internetforce.com.old),
una versione precedente della stessa zona. Il numero di serie la colloca prima
della versione corrente: `1995101801` (18 ottobre 1995) contro `1996091101`
(11 settembre 1996), e in questa copia lo `SOA` indica come origin
`dns.internetforce.com.` e tra i record `NS` compaiono anche
`dns.internetforce.com.` e `dns2.internetforce.com.`.

Il cambiamento più evidente riguarda il record di news:

- nella versione precedente (`.old`): `news CNAME data.internetforce.com.` — il
  nome `news` era un alias del server locale DATA;
- nella versione corrente: `news CNAME news.ios.com.` — il nome `news` punta al
  server di news dell'upstream IDT.

Le due versioni non vanno unite: descrivono due momenti diversi della stessa
zona. Il valore presente nel file corrente è quello associato al numero di serie
`1996091101`; quello nel file `.old` al numero `1995101801`.

### Nomi alternativi nei reperti DNS

Le zone e le tabelle `/etc/hosts` recuperate etichettano alcuni indirizzi della
LAN dell'ufficio anche con nomi aggiuntivi o alternativi, tra cui `aps`, `cust2`
e `isa`. Sono uno **strato di denominazione storica** presente nel materiale di
configurazione; non sostituiscono la nomenclatura reader-facing della
ricostruzione. Vedi la [README della LAN dell'ufficio](../../office-lan/README.md)
e [Persone, macchine e workflow](../../../docs/15-people-and-workflows.md).

## 5. La zona `pippo.com`

Il dominio `pippo.com` era ospitato sullo stesso DNS. La zona recuperata è
[`named-data/primary/pippo.com`](named-data/primary/pippo.com):

``` text
@  IN	SOA	pippo.com dnsmaster.internetforce.com. (
		1996092401	 ; Serial
		10800		 ; Refresh 3 hours
		3600		 ; Retry 1 hour
		604800		 ; Expire after a week
		86400 )	 ; Minimum ttl 1 day
				NS	harley.ios.com.
				NS	dns.internetforce.com.
				NS	dns2.internetforce.com.
pippo.com.      MX  0  internetforce.com.
www      A  206.20.95.25
dns      A  206.20.95.3
```

Valgono le stesse letture dei record viste per `internetforce.com`: `SOA` con
serial `1996092401`, tre `NS` (il secondario dell'upstream `harley.ios.com` e i
due server Internet Force `dns`/`dns2`), un `MX` che rimanda la posta del dominio
a `internetforce.com.`, e i record `A` per `www` (`206.20.95.25`) e `dns`.

Il collegamento con il processo di registrazione è diretto: `pippo.com` è il
dominio la cui registrazione InterNIC e la cui delega sono documentate negli
scambi conservati. La zona locale e il record di registro sono due facce dello
stesso procedimento; il rapporto è descritto nella sezione 8.

## 6. Reverse DNS: `206.20.95.in-addr.arpa`

Alla risoluzione inversa (da indirizzo a nome) è dedicata la zona
[`named-data/primary/db.206.20.95`](named-data/primary/db.206.20.95), dichiarata
in `named.boot` come `primary 95.20.206.IN-ADDR.ARPA`. Dopo `SOA` e `NS`, la zona
contiene record `PTR`:

``` text
3      PTR  data.internetforce.com.
4      PTR  users.internetforce.com.
5      PTR  shell.internetforce.com.
129      PTR  firewall.internetforce.com.
130      PTR  dvlp.internetforce.com.
```

- **`in-addr.arpa`** è il dominio speciale usato per la risoluzione inversa degli
  indirizzi IPv4. Gli ottetti dell'indirizzo vengono invertiti: l'indirizzo
  `206.20.95.3` diventa il nome `3.95.20.206.in-addr.arpa`, e la zona
  `206.20.95.in-addr.arpa` copre la rete `206.20.95.0/24`. Per questo i record
  hanno owner breve (`3`, `4`, `129`): sono relativi alla zona inversa.
- **PTR** (*Pointer*) — punta dal nome inverso al nome canonico dell'host. Qui
  `3` → `data.internetforce.com.`, `4` → `users.internetforce.com.`, e così via.

La relazione con il DNS diretto è complementare: un record `A` traduce un nome in
un indirizzo, un record `PTR` traduce quell'indirizzo nel nome. La zona inversa
recuperata copre gli host di servizio e infrastrutturali; altre sezioni dello
stesso file contengono anche i `PTR` dei siti virtuali (`www.canalemoda.com.`,
`www.pippo.com.`, …) e dei pool dial-up. Non ogni record `A` delle zone dirette
ha necessariamente un `PTR` corrispondente: la corrispondenza va letta caso per
caso nei file recuperati.

## 7. Primary e secondary

Un dominio è servito da più nameserver per garantirne la raggiungibilità. Il
**primario** (master) conserva la copia di riferimento della zona; il
**secondario** (slave) ne mantiene una copia che aggiorna periodicamente
chiedendola al master (*zone transfer*, il trasferimento di zona `AXFR`). I
parametri `refresh`, `retry` ed `expire` dello `SOA` regolano proprio questo
meccanismo: ogni quanto il secondario controlla, dopo quanto ritenta e dopo
quanto la sua copia scade se non riesce ad aggiornarsi.

Nel `named.boot` di DATA il ruolo di master è dichiarato con `primary` per le
zone Internet Force e per quelle ospitate, mentre due zone sono ottenute da un
altro server con `secondary`:

``` text
secondary cnn.it			206.20.228.70 secondary/cnn.it
secondary 228.20.206.IN-ADDR.ARPA       206.20.228.70 secondary/db.206.20.228
```

Qui `cnn.it` e la sua zona inversa non sono masterizzate da DATA: la copia
viene trasferita dal server `206.20.228.70` (`cnn-server.cnn.it`) e conservata
sotto `named-data/secondary/`. Questa è l'evidenza, nel file recuperato, del
comportamento di secondario secondo la sintassi BIND dell'epoca.

Per quanto riguarda USERS come secondario di Internet Force, la documentazione
sopravvissuta lo identifica come `dns2.internetforce.com` e i record `NS` lo
elencano come nameserver autorevole; tuttavia **non è stata recuperata una
configurazione `named.boot` di USERS**, e il blocco di avvio di `named` nel
`rc.local` di USERS risulta commentato. Il ruolo di secondario è quindi
documentato dalle zone e dai riferimenti `NS`, ma la configurazione secondaria
completa di USERS non è disponibile nell'archivio, e non ne viene qui ricostruita
una. Allo stesso modo, per le zone `secondary` recuperate non sopravvive una
configurazione con parametri o restrizioni di trasferimento di zona: il
materiale conservato mostra la sintassi `secondary` del file di boot, non
eventuali ACL di trasferimento.

## 8. Dalla registrazione alla delega DNS

La configurazione locale delle zone e la registrazione dei domini erano due
parti dello stesso processo operativo. Perché un dominio risolvesse, il registro
doveva delegarlo ai nameserver autorevoli, e quei nameserver dovevano essere
configurati e funzionanti. L'archivio conserva entrambi i lati.

### Domini `.com` / `.net` — InterNIC e IDT

Per i domini internazionali la richiesta andava a **InterNIC/Network Solutions**;
la procedura e i moduli sono documentati in
[Registrazione dei domini — `.com`/`.net`](../../../artifacts/domain-registration/domini_com_net.txt)
e negli scambi conservati. Il ruolo dell'upstream **IDT** (Internet Online
Services) è quello di nameserver secondario: nelle mail conservate IDT forniva il
secondario `harley.ios.com`, che compare infatti tra i record `NS` delle zone
`internetforce.com` e `pippo.com`.

Materiale originale collegato:

- [Registrazione dei domini (indice)](../../../artifacts/domain-registration/README.md);
- [`DOMAIN.mailbox`](../../../artifacts/email-archive/technical/DOMAIN.mailbox) — notifiche e moduli InterNIC (`pippo.com`, `shiseidoit.com`);
- [`DOMAIN-IDT.mailbox`](../../../artifacts/email-archive/technical/DOMAIN-IDT.mailbox) — registrazioni `.com` e richieste a IDT per il secondario;
- [`IDT.mailbox`](../../../artifacts/email-archive/technical/IDT.mailbox) — altri scambi con IDT.

### Domini `.it` — GARR / Registro

Per i domini italiani la richiesta seguiva il percorso del **GARR-NIS**, il
servizio che gestiva il registro `.it` dell'epoca. La procedura e i dati
richiesti sono documentati in
[Registrazione dei domini `.it`](../../../artifacts/domain-registration/domini_it.txt);
gli scambi con GARR documentano l'invio della richiesta, i controlli e la
registrazione.

Materiale originale collegato:

- [`GARR-DOMINI_IT.mailbox`](../../../artifacts/email-archive/technical/GARR-DOMINI_IT.mailbox) — registrazioni `.it` presso il GARR-NIS;
- [`ITALIAN_POSTMAST.mailbox`](../../../artifacts/email-archive/technical/ITALIAN_POSTMAST.mailbox) — lista dei postmaster GARR.

Il percorso complessivo, dall'alto verso il basso, era:

``` text
richiesta del dominio
      ↓
corrispondenza di registrazione / delega (InterNIC o GARR)
      ↓
dichiarazione dei nameserver autorevoli
      ↓
configurazione BIND locale (named.boot + zone)
      ↓
record della zona (SOA, NS, A, MX, CNAME, PTR)
```

Questa è la parte in cui il procedimento amministrativo e l'implementazione
tecnica del DNS si toccavano: la stessa coppia di nameserver indicata al registro
compare come record `NS` nella zona locale.

## 9. Configurazioni originali complete

File di configurazione e zone recuperati:

- file di boot: [`named.boot`](named.boot) e la variante [`named.boot.save`](named.boot.save);
- zona principale `internetforce.com`: [`named-data/primary/internetforce.com`](named-data/primary/internetforce.com) e la versione precedente [`named-data/primary/internetforce.com.old`](named-data/primary/internetforce.com.old);
- zona `pippo.com`: [`named-data/primary/pippo.com`](named-data/primary/pippo.com);
- zona inversa principale: [`named-data/primary/db.206.20.95`](named-data/primary/db.206.20.95);
- root hints: [`named-data/root.cache`](named-data/root.cache) e la variante [`named-data/root.cache.orig`](named-data/root.cache.orig);
- materiale delle zone secondarie: [`named-data/secondary/`](named-data/secondary/) (`cnn.it`, `db.206.20.227`, `db.206.20.228`, `tera-it.com`);
- directory delle zone primarie: [`named-data/primary/`](named-data/primary/).

Non è disponibile una configurazione `named.boot` di USERS: il ruolo di
secondario è documentato dalle zone e dai record `NS`, non da un file di
configurazione sopravvissuto.

## 10. Riferimenti tecnici storici

Per il significato delle direttive di BIND e dei record DNS si fa riferimento
alla documentazione storica dell'epoca:

- **RFC 1033**, *Domain Administrators Operations Guide* (M. Lottor, novembre
  1987), <https://www.rfc-editor.org/rfc/rfc1033.txt> — formato del file di boot
  di BIND (`cache`, `primary`), file dei root hints, e semantica dei record
  `SOA`, `NS`, `A`, `CNAME`, `MX`, `PTR` e del dominio `IN-ADDR.ARPA`.
- **RFC 1034**, *Domain Names — Concepts and Facilities* (P. Mockapetris,
  novembre 1987), <https://www.rfc-editor.org/rfc/rfc1034.txt> — zone, autorità,
  delegazione, nameserver primari/secondari e trasferimento di zona.
- **RFC 1035**, *Domain Names — Implementation and Specification* (P.
  Mockapetris, novembre 1987), <https://www.rfc-editor.org/rfc/rfc1035.txt> —
  definizione dei record e del formato dei messaggi DNS.

I file di configurazione e le zone di Internet Force restano la fonte primaria
per ciò che il provider configurava realmente; i documenti sopra servono a
spiegare il significato delle direttive e dei record.

## Continua l'esplorazione

-   [DNS](README.md) e [DNS: la documentazione narrativa](../../../docs/03-dns.md)
-   [Registrazione domini InterNIC/GARR](../../../artifacts/domain-registration/README.md)
-   [Unix e configurazione di un host](../../../docs/01-architecture.md)
