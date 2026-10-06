🇮🇹 **Italiano** · [🇬🇧 English](05-web-news-ftp.en.md)

# Web, FTP, news e mailing list

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

Questa pagina copre i servizi informativi pubblici del provider. La divisione principale era:
**DATA** ospitava i servizi pubblici, in gran parte di sola lettura (FTP
anonimo, news Usenet, mailing list e siti web virtuali dei clienti), mentre
**USERS** ospitava lo spazio web per singolo cliente e la posta. Entrambi sono
descritti nei rispettivi README di sistema.

Oltre a ricostruire che cosa girava su quale host, questa pagina spiega i
meccanismi per cui nel 1995 ho voluto creare a mano la documentazione che li spiegasse: che cos'è un daemon, come un
servizio resta in ascolto su una porta, perché un web server riduce i propri
privilegi e come una sola scheda Ethernet potesse servire decine di domini
diversi. La parte centrale è il **virtual hosting basato su VIF**, il punto in
cui rete e Web si incontrano.

## World Wide Web

### Che cosa fa davvero un web server

Un **daemon** è un programma che gira in secondo piano, senza un terminale
collegato, in attesa di svolgere un compito. Un web server è un daemon che
aspetta connessioni sulla rete. In concreto, ripete sempre lo stesso ciclo:

```text
ascolta una porta TCP
      ↓
riceve una richiesta HTTP
      ↓
trova il file richiesto
      ↓
lo restituisce al browser
```

Una **porta TCP** è un numero che identifica un servizio su una macchina: il
browser sa che per il Web deve parlare con la porta 80. Il file di
configurazione principale di NCSA HTTPd descriveva proprio questo:

### ORIGINALE RECUPERATO — `httpd.conf` di USERS

```conf
ServerType standalone

Port 80

User nobody
Group #-1

ServerRoot /usr/local/etc/httpd

ErrorLog logs/error_log
TransferLog logs/access_log

ServerName www.internetforce.com
```

(`httpd.conf` di DATA è quasi identico, con `Group nogroup` e
`ServerName www1.intf.com`.)

- **`ServerType standalone`** dice che HTTPd resta in esecuzione da solo. Un
  servizio può invece essere **lanciato da `inetd`** solo quando arriva una
  connessione: lo stesso programma, due modelli di esecuzione diversi. Il Web
  era `standalone`; FTP, come vedremo, era `inetd`.
- **`Port 80`** è la porta TCP su cui arriva la richiesta HTTP.
- **`User nobody` / `Group #-1`** (o `nogroup`) dicono di abbandonare i
  privilegi. Aprire una porta sotto la 1024 richiede di partire come `root`, ma
  il lavoro ordinario viene poi svolto con un account quasi senza privilegi.
  È una regola fondamentale: un servizio esposto a Internet non deve avere più
  permessi di quelli strettamente necessari.
- **`ServerRoot`** è la directory base dell'installazione; **`ErrorLog`** e
  **`TransferLog`** registrano rispettivamente errori e richieste ricevute.
  Ancora oggi l'amministrazione di un server Web passa da questi due log.

File: [`systems/data/web/httpd.conf`](../systems/data/web/httpd.conf) ·
[`systems/users/system/httpd/httpd.conf`](../systems/users/system/httpd/httpd.conf)

### DocumentRoot e CGI

Un secondo file, `srm.conf`, definiva la struttura dei contenuti:

### ORIGINALE RECUPERATO — `srm.conf` di DATA

```conf
DocumentRoot /usr/local/etc/httpd/htdocs
UserDir public_html
DirectoryIndex welcome.html index.html

Alias /icons/ /usr/local/etc/httpd/icons/
ScriptAlias /cgi-bin/ /usr/local/etc/httpd/cgi-bin/
```

- **`DocumentRoot`** è la directory che corrisponde alla radice del sito: una
  richiesta per `/manuale.html` viene cercata in
  `/usr/local/etc/httpd/htdocs/manuale.html`.
- **`UserDir public_html`** abilita lo spazio personale di ogni account
  (`/~utente/`).
- **`DirectoryIndex`** elenca i nomi provati automaticamente quando si chiede
  una directory.
- **`Alias`** serve a mappare una parte dell'URL su una directory diversa.
- **`ScriptAlias`** individua la directory **CGI**: i programmi lì contenuti
  non vengono restituiti come file, ma **eseguiti** dal server per generare
  dinamicamente la risposta. Nel 1995 buona parte del Web dinamico funzionava
  esattamente così.

Il resto della configurazione completava il quadro: `access.conf` regolava i
permessi delle directory (con `allow`/`deny`), `mime.types` mappava le
estensioni sui tipi MIME, `defa_srm.conf` serviva una pagina di errore
personalizzata (`ErrorDocument 404 /errore.html`) e `imagemap.conf` elencava le
mappe delle immagini cliccabili. Oltre ai CGI, NCSA HTTPd poteva servire file
con **server-side includes** (`.shtml`).

File: [`systems/data/web/srm.conf`](../systems/data/web/srm.conf) ·
[`systems/data/web/access.conf`](../systems/data/web/access.conf) ·
[`systems/data/web/mime.types`](../systems/data/web/mime.types) ·
[`systems/users/system/httpd/srm.conf`](../systems/users/system/httpd/srm.conf) ·
[`systems/users/system/httpd/access.conf`](../systems/users/system/httpd/access.conf) ·
[`systems/users/system/httpd/defa_srm.conf`](../systems/users/system/httpd/defa_srm.conf) ·
[`systems/users/system/httpd/imagemap.conf`](../systems/users/system/httpd/imagemap.conf)

### Il server al lancio, e il passaggio ad Apache

Al lancio il server web era **NCSA HTTPd** (versione 1.4/1.5), il server web
Unix di riferimento prima di Apache. Girava su due host:

- **USERS** — il sito principale `www.internetforce.com` e le pagine personali
  dei clienti, nella directory `public_html` di ogni account. Un'area CGI
  `/tools/` forniva funzioni comuni come un contatore di pagine e banner
  pubblicitari.
- **DATA** — `www1.intf.com` e una parte dei siti virtuali dei clienti.

Con la crescita del web, **Marco sostituì NCSA HTTPd con Apache**, che si era
affermato come il nuovo server web Unix di riferimento. Il materiale di
riferimento Xpert nell'archivio include una prima struttura di configurazione
Apache (Apache 1.1), che fu uno dei riferimenti usati all'epoca. La migrazione
fa parte dell'evoluzione del 1996.

### Sperimentazioni Web: VRML

Internet Force non si limitava alla realizzazione e all'hosting di pagine Web
convenzionali. Il lavoro sul Web comprendeva anche sperimentazioni con
tecnologie allora emergenti: nello screenshot pubblicato da *Internet & Musica*
è visibile una sezione realizzata in **VRML** (Virtual Reality Modeling
Language), una delle prime sperimentazioni italiane con ambienti Web
tridimensionali.

Era il **1995-96**, quasi un decennio prima di Second Life: un piccolo esempio
del livello di curiosità e competenza tecnica che Internet Force applicava non
soltanto all'infrastruttura di rete, ma anche alla costruzione e sperimentazione
di nuove esperienze Web.

→ Contesto e reperto:
[`artifacts/press/internet-e-musica-provider-review/`](../artifacts/press/internet-e-musica-provider-review/README.md)
([scansione originale](../artifacts/press/internet-e-musica-provider-review/internet-e-musica-internet-force.pdf)).

## Hosting web virtuale (VIF)

### Il problema: una macchina, molti domini

Internet Force ospitava molti domini di clienti su poche macchine. Oggi è
normale che decine di siti puntino allo stesso indirizzo IP; nel 1995 non lo
era. Le prime implementazioni HTTP non potevano sapere con certezza **quale
nome DNS il browser avesse usato** per arrivare al server, quindi il metodo
affidabile era assegnare a ogni sito il proprio indirizzo IP, anche se tutti
quei indirizzi finivano fisicamente sulla stessa Sun.

La documentazione Apache conservata nel bundle Xpert lo dice in modo diretto:

```text
Due to limitations in the HTTP/1.0 protocol, the web server must have a
different IP address for each virtual host.
```

Da qui una catena di problemi che vanno risolti uno dopo l'altro.

### Primo passaggio: DNS

Per `pippo.com` il DNS doveva dire:

```dns
www      A  206.20.95.25
```

Ogni sito aveva il suo indirizzo. L'archivio conserva la sequenza completa:

```text
206.20.95.20  www.canalemoda.com
206.20.95.21  www.sicilia.com
...
206.20.95.25  www.pippo.com
...
206.20.95.35  www.financialreports.com
```

Il DNS risolve quindi il problema del **nome**, ma non ancora quello della
macchina: la Sun possiede davvero tutti quegli indirizzi?

File: [`pippo.com`](../systems/data/dns/named-data/primary/pippo.com) ·
[`db.206.20.95`](../systems/data/dns/named-data/primary/db.206.20.95)

### Secondo passaggio: VIF dà alla Sun molti indirizzi

La macchina aveva una **sola scheda Ethernet fisica, `le0`**, ma doveva
rispondere come se ne avesse molte. Su **SunOS 4.1.3/4.1.4** non esisteva il
modello nativo di alias IP che sarebbe poi comparso in Solaris 2.x.

La soluzione che **Yahel Ben-David di Xpert UNIX Systems** passò a Marco era un
pacchetto chiamato **VIF, Virtual Interface**: codice kernel che aggiungeva al
networking stack nuove interfacce logiche.

```text
le0      ← Ethernet fisica (un solo MAC address)

vif0     ← interfaccia IP virtuale
vif1     ← interfaccia IP virtuale
vif2     ← interfaccia IP virtuale
...
```

Dal punto di vista dei protocolli IP, `vif0` e `vif1` si comportavano come vere
interfacce, alle quali si poteva assegnare un indirizzo con `ifconfig`. La
versione 1.10 conservata nel bundle lo riassume così:

```text
This code lets you have multiple IP addresses for a single interface.
```

Il bundle è **originale**; la sua descrizione completa, provenienza e contenuto
stanno in [`systems/sun-vif/README.md`](../systems/sun-vif/README.md), che è la
fonte autorevole. Qui ne riprendiamo solo il minimo per capire il Web hosting.

### Che cos'è un modulo kernel caricabile, e che cosa fa `modload`

Un **modulo kernel caricabile** è codice compilato che può essere inserito in un
kernel già in esecuzione, senza ricostruire e reinstallare l'intero sistema
operativo. Il comando che lo carica è `modload`.

Il codice originale di John Ioannidis, nella prima forma, richiedeva invece di
modificare la configurazione del kernel (`pseudo-device vif4`) e di ricompilare
il kernel. La versione arrivata a Internet Force, ripulita da Steinar Haug, si
compilava in un modulo `vif.o` e si caricava dinamicamente:

### ORIGINALE RECUPERATO — `Makefile.sun` (bundle VIF)

```make
CFLAGS = -O -DDETACH -DKERNEL -DINET -D`arch -k`

all:	vif.o

vif.o:	if_vif.o wrapper.o
        ld -o vif.o -r if_vif.o wrapper.o

install: vif.o
        modload vif.o -entry _vif_vdcmd -exec `pwd`/vif_exec
```

La parte decisiva è `-DKERNEL`: stiamo compilando **codice destinato al
kernel**, non un normale programma. Il target `install` carica il modulo e
subito dopo esegue `vif_exec`.

### `/dev/vif` e le interfacce `vifN`

### ORIGINALE RECUPERATO — `vif_exec` (bundle VIF)

```sh
rm -f /dev/vif
mknod /dev/vif c $4 0
echo > /dev/vif
netstat -ian
```

- **`/dev/vif`** è un **device file**: il punto di contatto fra lo spazio utente
  e il driver appena caricato nel kernel.
- **`mknod`** crea quel device; la scrittura `echo > /dev/vif` provoca
  l'apertura del driver e l'**attach** delle interfacce virtuali.
- Dopo l'attach, `netstat -ian` mostra `le0`, `lo0` e le nuove `vif0`, `vif1`,
  `vif2`… Le VIF esistono, ma non hanno ancora un indirizzo.

### `ifconfig`, host route e ARP pubblicato

Gli indirizzi si assegnano con il normale `ifconfig`. Lo script recuperato
`VIF.RC` automatizza l'intera operazione:

### ORIGINALE RECUPERATO — `VIF.RC` (bundle VIF)

```sh
ETH_ADDR=`ifconfig le0 | awk '/ether/ { print $2 }'`
N=0; export N
for VIF_HOST in $VIF_HOSTS; do
        ifconfig vif$N $VIF_HOST up
        for BAD_ROUTE in `netstat -r | awk '/vif'$N'/ { print $1 }'`; do
                route delete $BAD_ROUTE $VIF_HOST
        done
        route add host $VIF_HOST $VIF_HOST 0
        arp -s $VIF_HOST $ETH_ADDR pub
        N=`expr $N + 1`
done
```

- **`ifconfig vifN <IP> up`** assegna l'indirizzo all'interfaccia virtuale e la
  attiva.
- **`route add host ...`** è la **host route**. Una VIF non rappresenta un nuovo
  cavo Ethernet: vogliamo dire soltanto "questo singolo indirizzo appartiene a
  questa macchina", non "tutta la rete di quell'indirizzo è raggiungibile
  attraverso `vif0`". `ifconfig` tende a creare anche una route di rete spuria,
  che lo script cancella.
- **ARP** è il protocollo con cui, su Ethernet, si chiede "chi possiede
  l'indirizzo IP X?" e si riceve in risposta un **MAC address**. Il problema è
  che sulla rete esiste fisicamente solo `le0`, con un solo MAC. Lo script legge
  quel MAC e poi pubblica un'associazione ARP **statica** per ogni indirizzo
  virtuale (`arp -s ... pub`): così la Sun risponde ai riscontri ARP per tutti i
  suoi IP, pur avendo una sola scheda.

```text
206.20.95.25 ─┐
206.20.95.26 ─┤
206.20.95.27 ─┼──> stesso MAC address di le0
...           ─┘
```

Il `VIF.RC` recuperato contiene nomi placeholder (`myhost-vif0`,
`myhost-vif1`): è lo script originale del pacchetto, non l'elenco operativo
Internet Force degli indirizzi `.20–.35`.

### Far sopravvivere la configurazione a un reboot: `rc.local`

Configurare le VIF a mano sarebbe servito solo fino al riavvio successivo. Il
documento `VIF.HTM` del bundle mostra la procedura pratica per SunOS 4.x:

```sh
install -m 0755 vif.o vif.rc /etc
echo /etc/vif.rc >> /etc/rc.local
```

`/etc/rc.local` è lo script di avvio che SunOS esegue al termine del boot.
Aggiungendovi `vif.rc`, ogni riavvio ripete l'intera sequenza: `modload`,
creazione di `/dev/vif`, attach delle `vifN`, `ifconfig` degli IP, host route,
ARP pubblicati. A quel punto la macchina è di nuovo pronta a rispondere a tutti
i suoi indirizzi virtuali.

### La catena lato rete: il firewall

Non basta che la Sun sappia rispondere: anche il router/firewall deve sapere
**dove** mandare il traffico diretto a quegli indirizzi. Il file `rc.route`
assegna ogni IP virtuale al segmento giusto:

### ORIGINALE RECUPERATO — `rc.route`

```sh
route add host data fw-data 0
route add host 206.20.95.20 fw-data 0
route add host 206.20.95.29 fw-data 0
route add host 206.20.95.32 fw-data 0
route add host 206.20.95.33 fw-data 0
...
route add host users fw-users 0
route add host 206.20.95.25 fw-users 0
...
```

Gli IP `.20`, `.29`, `.32`, `.33` sono instradati verso **DATA**, mentre la
maggior parte (`.21–.28`, `.30`, `.31`) verso **USERS**. Questo spiega anche
come mai i siti virtuali fossero **divisi fra i due server**: le configurazioni
NCSA corrispondono esattamente a questa ripartizione.

File: [`rc.route`](../systems/firewall/network/rc.route)

### NCSA VirtualHost: scegliere il sito in base all'IP di destinazione

Il pacchetto arriva ora alla Sun giusta e all'indirizzo giusto; HTTPd deve
ancora capire **quale directory servire**. NCSA HTTPd usava a questo scopo le
sezioni `<VirtualHost IP>`:

### ORIGINALE RECUPERATO — sito `www.pippo.com` (USERS)

```conf
<VirtualHost 206.20.95.25>
ServerName www.pippo.com
ServerAdmin webmaster@internetforce.com
ResourceConfig conf/defa_srm.conf
DocumentRoot /usr/local/etc/httpd/htdocs/ianna/
ErrorLog logs/pippo.error_log
TransferLog logs/pippo.access_log
</VirtualHost>
```

Il meccanismo, descritto in `NCSA.HTM`, è semplice: alla ricezione di una
connessione il server usa `getsockname()` per scoprire **su quale indirizzo
locale** è arrivata, cerca quell'indirizzo nella tabella e applica di
conseguenza `ServerName`, `ServerAdmin` e `DocumentRoot`. Il bundle Xpert
contiene anche i sorgenti `NCSA_PAT.Z` compilati con
`-DAPB_BIND_ADDRESS -DAPB_VIRTUAL_HOST`.

I siti virtuali vivono quindi nelle configurazioni reali: `www.art-diary.com`,
`www.sicilia.com`, `www.pesaro.com`, `www.creo-mi.com`, `www.pippo.com` e altri
su USERS; `www.canalemoda.com`, `www.shiseidoit.com`, `www.nassetti.com`,
`www.net-pool.com` su DATA. La catena, finalmente completa, è:

```text
www.pippo.com
      ↓ DNS A record
206.20.95.25
      ↓ routing del firewall (fw-users)
Sun USERS
      ↓ VIF 206.20.95.25
NCSA <VirtualHost 206.20.95.25>
      ↓
/usr/local/etc/httpd/htdocs/ianna/
```

È il genere di meccanismo che oggi un pannello di hosting nasconde dietro un
pulsante "Add domain". Nel 1995 bisognava costruire ogni livello.

Un esempio concreto e consultabile è lo snapshot del sito personale
[`pippo.com` del 1997](../systems/marco/personal-web/pippo.com-1997/README.md):
conserva il `VirtualHost` storico di `www.pippo.com`, il contatore CGI servito
da `pointest.com` (il dominio associato al POP di Gorgonzola, inizialmente
ospitato su DATA) e il percorso personale `/~ianna/`.

Nel flusso operativo, i contenuti statici dei clienti erano caricati su DATA e
le pagine personali su USERS; le pagine erano sempre testate su DVLP prima del
rilascio. DATA inoltre rispecchiava almeno un sito esterno (le pagine
"annabella" di Areacom) con un job `webcopy` pianificato, e faceva girare
regolari job di statistiche.

### Che cosa è originale e che cosa è ricostruito

È importante non confondere i due piani:

- Il **bundle VIF è originale**: comprende `VIF-1_10.GZ`, `VIF.RC`, `VIF.HTM`,
  `/dev/vif`, `Makefile.sun`, `NCSA.HTM`, `NCSA_PAT.Z`. Gli estratti di questa
  pagina vengono da lì. Vedi [`systems/sun-vif/`](../systems/sun-vif/README.md).
- Lo **script di avvio VIF effettivamente usato in produzione da Internet Force
  non è stato recuperato**. Il `VIF.RC` sopravvissuto è lo script modello del
  pacchetto, con nomi placeholder: non è l'elenco `.20–.35`.
- La sequenza SunOS di `ifconfig`/route sopra è quindi **procedura del
  pacchetto**, non un file operativo Internet Force. Non presenteremo una
  ricostruzione come se fosse un originale.

### Epilogo: il sistema operativo assorbe la funzione

Il README di VIF 1.10 contiene una nota storicamente notevole:

```text
Solaris 2.x: You don't need vif,
since the operating system already has the necessary functionality.
```

con la sintassi `ifconfig IF:N ip-address up`, aggiungendo però che la funzione
era **non documentata e non supportata ufficialmente**. Ciò che su SunOS 4.1.x
richiedeva codice kernel esterno, compilazione e `modload`, nella generazione
successiva era già nativo. Non possiamo dedurne che Solaris abbia copiato VIF,
ma possiamo osservare direttamente l'evoluzione del problema. La storia completa
di questa circolazione di codice è in
[`09-historical-notes.VIF-NETWORK-EVOLUTION.md`](09-historical-notes.VIF-NETWORK-EVOLUTION.md).

## FTP

### Pubblico, autenticato e confinato

Prima che il Web diventasse il modo universale di distribuire file, **FTP, File
Transfer Protocol**, era uno degli strumenti fondamentali di Internet:
permetteva di collegarsi a un server, esplorare directory e trasferire file. Un
ISP poteva usarlo in tre modi, spesso insieme:

```text
FTP anonymous
→ accesso pubblico senza account personale

FTP autenticato
→ login con credenziali reali

FTP chrooted / guest
→ accesso autenticato ma confinato a una parte del filesystem
```

Internet Force usava **wu-ftpd**. Su DATA l'area anonima stava sotto
`/usr/local/ftp`, con un albero `/pub` **solo download** (file leggibili da
tutti, directory non scrivibili dal pubblico) e una directory separata **solo
upload** (dove i file potevano essere depositati ma non riletti). USERS forniva
il normale FTP autenticato, così ogni cliente poteva caricare le proprie
pagine. DVLP permetteva FTP solo dalla rete dell'ufficio, per i test.

### `inetd` → `tcpd` → `ftpd`

A differenza del Web, FTP non restava in ascolto da solo. La riga recuperata da
`inetd.conf` descrive una piccola catena di programmi:

### ORIGINALE RECUPERATO — `inetd.conf` di USERS

```conf
#   Wu-ftpd for anonymous and/or real (chrooted) FTP access.
ftp	stream	tcp	nowait	root	/usr/etc/tcpd	/usr/local/etc/ftpd
```

```text
connessione TCP sulla porta FTP
        ↓
inetd
        ↓
tcpd
        ↓
/usr/local/etc/ftpd (wu-ftpd)
```

- **`inetd`** è il *super-server*: resta in ascolto per molti servizi e avvia il
  programma appropriato solo quando arriva una connessione.
- **`tcpd`** è il wrapper di sicurezza (TCP wrappers): prima di avviare il
  daemon vero applica controlli di accesso e logging.
- **`ftpd`** è il vero server FTP.

File: [`inetd.conf`](../systems/users/system/inetd.conf)

### Perché `ftpd` poteva non comparire in `ps`

Poiché `ftpd` viene creato da `inetd` solo al momento della connessione, non era
necessario vedere un processo `ftpd` in esecuzione continua: bastava vedere
`inetd` in attesa. È una differenza pratica importante quando si legge la lista
dei processi di una macchina dell'epoca.

### `ftpusers`: escludere gli account di sistema

FTP non deve accettare qualunque account presente in `/etc/passwd`.
Internet Force manteneva una deny-list `ftpusers`:

### ORIGINALE RECUPERATO — `ftpusers`

```text
root
nobody
daemon
sys
bin
uucp
news
majordomo
operator
```

La lista pubblicata (identica su FIREWALL, DATA e USERS) è in
[`systems/users/system/ftpusers`](../systems/users/system/ftpusers).

Se un account compare qui, non può essere usato per entrare via FTP. Il caso più
ovvio è `root`: consentire un login FTP diretto come root sarebbe stato un
rischio enorme. In generale gli account di servizio hanno troppo potere per
essere ammessi a "solo" FTP.

### Che cosa cambia `chroot`

Supponiamo di voler dare a un cliente accesso FTP a una propria directory. La
soluzione ingenua - un normale login Unix - gli mostrerebbe l'intero filesystem
della macchina. L'approccio più sicuro è far sembrare una sottodirectory come se
fosse **l'intero filesystem**: questo è il principio di **chroot**.

```text
vista normale                 vista dopo chroot
/                             /
├── bin                       ├── etc
├── etc                       ├── bin
├── usr          ────>        ├── home
├── var                       └── ftp-world
└── users
```

Il processo confinato non vede normalmente nulla sopra quel punto. Non è un
container moderno né una sandbox perfetta, ma è un meccanismo molto efficace per
ridurre ciò che un servizio o un account può raggiungere.

### `guestgroup` e un caso Internet Force reale

Il file `ftp-world.txt` documenta un account guest con questa home:

### ORIGINALE RECUPERATO — `ftp-world.txt`

```text
/users/01/segir/./ftp-world:/ftponly
```

La sintassi ha un significato preciso: la parte prima di `/./` è la **radice del
chroot** (`/users/01/segir`), quella dopo è la **directory iniziale** dopo il
login (`/ftp-world`). Lo stesso documento registra una direttiva reale di
`ftpaccess`:

```conf
guestgroup users www world
```

I membri dei gruppi indicati vengono trattati come **guest** e confinati nella
gerarchia prevista. Questo è uno dei reperti più chiari del fatto che il
confinamento riguardasse **anche gli account utente**, non solo il processo FTP.
La nota operativa originale completa (con gli identificativi del cliente
rimossi) è in
[`systems/users/system/ftp-world.txt`](../systems/users/system/ftp-world.txt).
Il file `ftpaccess` Internet Force completo non è sopravvissuto: mostriamo solo
la direttiva attestata, senza inventare il resto.

### Perché dentro la jail servono `passwd` e `group`

Se il processo vede una nuova `/`, anche `/etc/passwd` non è più il vero file
della macchina. Per questo i jail FTP contenevano piccoli file locali:

```text
/usr/localftp/etc/passwd
/usr/localftp/etc/group
```

L'archivio conserva interventi sui loro owner e permessi. È un dettaglio molto
didattico: una jail chroot non era una funzione magica da attivare. Bisognava
**costruire un piccolo filesystem coerente** - directory, file, owner e
permessi - dentro il quale il servizio potesse vivere.

### Chroot, restricted shell e shell "solo FTP"

Il confinamento degli utenti non si esauriva nel solo FTP. Altri reperti
documentano account con shell limitate (`/bin/nosh`, `/bin/lynx`) e una
soluzione basata su tcsh/restricted shell. Le tecniche sono diverse e spesso
combinate:

```text
chroot
    → limita la parte di filesystem visibile

restricted shell
    → limita comandi e comportamento della sessione

/ftponly o /bin/nosh
    → impedisce o restringe il normale login interattivo
```

La shell `/ftponly` dell'account dell'esempio serve proprio a questo: segnala
che l'account non è pensato per aprire una shell Unix interattiva, ma solo per
un uso controllato (FTP, o un menu). Per questo esiste una shell "solo FTP":
per distinguere un account di servizio da un account di login.

### Cosa non dobbiamo dedurre

Il confinamento non dipendeva da un unico meccanismo e non va generalizzato
oltre le prove. Non abbiamo reperti equivalenti che dimostrino un chroot
operativo per ogni daemon principale (BIND, Sendmail, NCSA HTTPd, XTACACS,
POP3/IMAP). Per NCSA HTTPd, ad esempio, il file recuperato mostra l'esecuzione
come utente non privilegiato (`User nobody`), che è una riduzione dei privilegi
ma **non** dimostra di per sé un chroot. La formulazione corretta è:

> Internet Force applicava il principio del confinamento sia ai servizi sia agli
> account utente, usando chroot quando appropriato e combinandolo con restricted
> shell, account non privilegiati, permessi Unix, tcp_wrappers e policy di rete.

## News Usenet

DATA gestiva il servizio news Usenet. Gli articoli erano alimentati dal server
del provider upstream `news.ios.com`, motivo per cui il nome
`news.internetforce.com` si risolveva su quel server per i client di lettura. La
regola 12 della rule base di FireWall-1 registra esplicitamente il feed
(`news.ios.com -> data : nntp`). I clienti leggevano le news via NNTP dopo aver
stabilito la sessione dial-up.

## Mailing list

Majordomo, in esecuzione su DATA, forniva il servizio di mailing list. Gli alias
recuperati mostrano le liste `intf-list`, `coach`, `marketing-l` (con edizione
digest) e `cosmo-answer`. Ogni lista aveva i soliti alias Majordomo per
iscrizione, approvazione, richieste e archivio, e le iscrizioni erano approvate
con comando di posta. Gli archivi delle liste erano convertiti in HTML con un
flusso basato su Hypermail. Le procedure per clienti e staff per iscrivere e
rimuovere indirizzi sopravvivono nel materiale di formazione recuperato.

## Aggiunte successive

Nel 1996 l'ambiente guadagnò un **proxy cache CERN httpd 3.0** (un host UNIX
separato che faceva da cache HTTP per la rete) e, come esperimento, un server
web su Windows NT con backend Oracle. Il proxy è descritto nell'inventario
software e nella pagina di sicurezza.

---

Vedi anche: [Server DATA](../systems/data/README.md) ·
[Server USERS](../systems/users/README.md) ·
[VIF — Virtual Interface per SunOS 4.x](../systems/sun-vif/README.md) ·
[Inventario software](11-software-inventory.md)

---

→ [Costruire un Internet Force POP, passo per passo](00-build-an-isp.md)
