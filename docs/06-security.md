🇮🇹 **Italiano** · [🇬🇧 English](06-security.en.md)

# Sicurezza

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

La sicurezza era trattata come requisito architetturale in Internet Force, non
come qualcosa aggiunto dopo il lancio. D'altronde l'israeliana Xpert Unix System a cui era stato affidata la consulenza per
la realizzazione di Internet Force, era costituita da ex hacker che avevano messo a disposizione del business le loro
competenze.
La sicurezza in Internet Force era implementata by design e può essere riassunta in tre livelli: il
firewall centrale, la segmentazione dei server centrali e l'hardening dei
singoli host UNIX.

Alla base c'era ovviamente una pratica quotidiana: l'**hardening**. Un server Internet
del 1995 non nasceva "web server" o "mail server"; si partiva da un sistema UNIX
general purpose e lo si riduceva al ruolo che doveva svolgere. Questa pagina
spiega sia il risultato (la policy FireWall-1, i servizi offerti, il non uso di
NIS/NFS) sia il metodo con cui una macchina appena installata diventava un
componente affidabile della rete.

## Hardening: ridurre Unix al ruolo della macchina

Un'installazione UNIX general purpose nasce per essere flessibile e contiene
molto più di quanto serva a un server esposto a Internet:

- servizi di rete;
- tool di sviluppo;
- shell;
- RPC;
- utility amministrative;
- programmi con privilegi speciali;
- daemon pensati per ambienti universitari o LAN fidate.

Tutto questo è **superficie d'attacco**: ogni programma in ascolto, ogni account,
ogni permesso ampio e ogni binario privilegiato è una possibilità in più che un
attaccante può provare a sfruttare. L'hardening è la riduzione di quella
superficie fino a ciò che serve realmente.

Dopo l'installazione del sistema operativo iniziava quindi una seconda fase, fatta
di domande:

```text
cosa serve?
cosa non serve?
chi deve poterlo usare?
da quali macchine?
con quali privilegi?
quale parte del filesystem deve vedere?
```

Internet Force separava i ruoli:

```text
DATA      → Web, DNS primario, FTP, mailing list
USERS     → autenticazione, posta, home utenti, POP3/IMAP
DVLP      → sviluppo, compilazione, strumenti amministrativi
FIREWALL  → filtraggio e segmentazione
```

Gli strumenti di sviluppo erano concentrati su DVLP, invece di trattare ogni
server di produzione come una macchina su cui compilare e sperimentare. Da
questa separazione discende una regola semplice:

> se un programma non serve al ruolo della macchina, non dovrebbe essere
> disponibile lì senza motivo.

### I reperti non sono tutti dello stesso momento

L'archivio recuperato trent'anni dopo non è la fotografia di un singolo giorno.
Contiene file appartenenti a **strati temporali diversi**:

```text
installazione iniziale
      ↓
messa in produzione
      ↓
hardening
      ↓
modifiche successive
      ↓
espansioni 1996
```

Per questo un `inetd.conf` che abbiamo recuperato **non** va letto automaticamente come
"la configurazione definitiva" o come l'esposizione finale dopo l'hardening. Può
fotografare una fase precedente, una configurazione base poi modificata o uno
snapshot intermedio. La prassi operativa era però chiara: le macchine
di produzione venivano sottoposte a hardening e ridotte al ruolo necessario.
Alcuni reperti mostrano direttamente come questo avveniva; altri vanno letti
come esempi, non come istantanee tutte dello stesso istante.

Per non confondere i livelli conviene tenere separati:

```text
configurazione presente nei file
        ↓
processi effettivamente in esecuzione
        ↓
servizi realmente raggiungibili dalla rete
```

## Il firewall

Il gateway era un Sun SPARCstation 5 con SunOS 4.1.4 e **Check Point
FireWall-1 2.0a**, amministrato tramite la sua interfaccia grafica X11. Aveva
cinque interfacce Ethernet (vedi
[Panoramica dell'architettura](01-architecture.md)): il lato world/backbone, due
segmenti dedicati per DATA e USERS, un segmento predisposto per l'host SHELL
pianificato e la LAN dell'ufficio.

Lo screenshot recuperato di FireWall-1 è la rule base originale
(`/usr/local/etc/fw/conf/final1.W`). Le regole, in ordine, sono:

| # | Sorgente | Destinazione | Servizi | Azione |
|---|---|---|---|---|
| 1 | Any | Any | domain, ident | accept |
| 2 | Any | servers | icmp echo-reply/request, http, smtp | accept |
| 3 | intf.com | intf.com | Any | accept |
| 4 | intf.com | servers | ftp, nntp | accept |
| 5 | clients | intf.com | Any | accept |
| 6 | clients, officenet | servers | ftp, nntp, pop-2, pop-3 | accept |
| 7 | ts | users | tacacs | accept |
| 8 | ts | Shell | telnet | accept |
| 9 | Shell | users | NFS | accept |
| 10 | dvlp, marco | servers | telnet | accept |
| 11 | dvlp | firewall | telnet, FW1, FW1_log | accept |
| 12 | news.ios.com | data | nntp | accept |
| 13 | xpert.com | dvlp, marco | talk, deslogin | accept |
| 14 | dvlp, marco | marco, dvlp | X11 | accept |
| 15 | Any | Any | Any | STOP |

La policy vale la pena leggerla come sintesi di come era usata la rete: il
pubblico può raggiungere DNS/ident e i servizi web/posta pubblicati sui server;
le reti dei clienti e dell'ufficio possono raggiungere FTP, news, POP e altri
servizi; gli access server raggiungono USERS per l'autenticazione TACACS; l'host
di sviluppo e la workstation di Marco sono le sorgenti di amministrazione;
`xpert.com` ha accesso di supporto remoto a DVLP e Marco; e tutto ciò che non è
esplicitamente permesso viene scartato dalla regola finale STOP.

Lo screenshot originale della rule base è conservato come artefatto primario:
[FW-policy.gif](../systems/firewall/checkpoint/FW-policy.gif) (vedi anche
[Check Point FireWall-1](../systems/firewall/checkpoint/README.md)). La
descrizione d'insieme del gateway è in
[Sistema firewall](../systems/firewall/README.md).

### Tre regole che riassumono le relazioni esterne

Tre regole rendono bene l'insieme delle relazioni esterne documentate dalla policy:

- **Regola 7 — `ts -> users : tacacs`**: mostra il ramo dell'autenticazione centralizzata. Gli access server dial-up (`ts`) interrogavano USERS via TACACS, senza che il traffico Internet ordinario degli abbonati dovesse attraversare il server.
- **Regola 12 — `news.ios.com -> data : nntp`**: documenta il collegamento NNTP con il feed Usenet esterno `news.ios.com` (vedi [Web, FTP, news e mailing list](05-web-news-ftp.md)).
- **Regola 13 — `xpert.com -> dvlp, marco : talk, deslogin`**: autorizzava `xpert.com` verso `dvlp` e `marco` per `talk` e `deslogin`, documentando l'accesso remoto del fornitore tecnico attraverso un meccanismo di login cifrato (`deslogin`).

Nel loro insieme, queste regole mostrano in un'unica policy l'autenticazione centralizzata, il rapporto con il servizio Usenet esterno e l'accesso remoto del fornitore tecnico.

### Percorso di amministrazione

La console del firewall era usata dall'ambiente protetto dell'ufficio. La
regola 11 lascia che DVLP raggiunga il firewall per telnet, il canale di
gestione di FireWall-1 (`FW1`) e il suo canale di logging (`FW1_log`); la
regola 14 elenca sia `dvlp` sia `marco` come sorgenti e come destinazioni per
X11 (`dvlp, marco -> marco, dvlp`), quindi consentiva il traffico X11 tra DVLP
e la workstation di Marco nelle due direzioni. La regola 10 lascia
che DVLP e Marco raggiungano i server via telnet. In pratica il firewall era
amministrato dalla workstation Linux di Marco e da DVLP, interamente su
interfacce interne, e mai su Internet pubblica.

### Le regole SHELL pianificate

Le regole 8 e 9 appartengono all'host SHELL pianificato, che fu predisposto nel
DNS e nel firewall ma mai messo in esercizio. La regola 9 in particolare
(`Shell -> users : NFS`) esiste perché il disegno dello shell avrebbe montato le
home da USERS via NFS; poiché SHELL non fu mai realizzato, quel percorso non fu
mai esercitato.

## Autenticazione centralizzata

XTACACS su USERS centralizzava l'autenticazione per ogni POP dial-up. Le regole
7 e 10 esprimono i due percorsi legati all'autenticazione: access server verso
USERS per TACACS e telnet amministrativo. Vedi
[Autenticazione (XTACACS)](10-authentication-tacacs.md).

## Servizi di rete: `inetd` e la minimizzazione

Su UNIX molti piccoli servizi di rete non giravano continuamente come processi
indipendenti. Erano gestiti da `inetd`, il cosiddetto *Internet super-server*:

```text
inetd ascolta la porta
      ↓
arriva una connessione
      ↓
inetd avvia il daemon corretto
      ↓
il daemon serve il client
```

Questo modello ha una conseguenza importante per chi legge i reperti. Una
process list molto corta poteva convivere con più servizi configurati in
`inetd.conf`: non vedere `telnetd`, `ftpd` o `rshd` in `ps` **non** significa
automaticamente che quei servizi non fossero disponibili, perché potevano
essere creati solo all'arrivo di una connessione. Un solo `inetd` in memoria e
un `inetd.conf` relativamente ricco non sono quindi in contraddizione.

Un `inetd.conf` SunOS descrive ciò che `inetd` era preparato a gestire in quello
strato. La raggiungibilità reale dipendeva anche da `tcp_wrappers`, dal routing,
da FireWall-1 e dalla fase temporale della configurazione.

Il file base del firewall elenca i servizi interni e quelli di amministrazione
([systems/firewall/network/inetd.conf](../systems/firewall/network/inetd.conf)):

```conf
telnet  stream  tcp  nowait  root  /usr/etc/tcpd   /usr/etc/in.telnetd
shell   stream  tcp  nowait  root  /usr/etc/tcpd   /usr/etc/in.rshd
login   stream  tcp  nowait  root  /usr/etc/tcpd   /usr/etc/in.rlogind
auth    stream  tcp  nowait  sys   /usr/etc/in.identd  in.identd
```

Letto riga per riga:

- `telnet`, `shell` (rsh) e `login` (rlogin) non lanciano il daemon
  direttamente: passano prima da `/usr/etc/tcpd`, il wrapper di controllo
  accessi (vedi più sotto). Il commento originale nel file dice che ogni server
  base consente telnet "for administration purpose".
- `auth` avvia `in.identd`: il servizio RFC931 di identificazione, considerato
  obbligatorio per la gestione dei log.
- La prima parte del file elenca i servizi `internal` di `inetd` (`time`,
  `echo`, `discard`, `daytime`, `chargen`): piccoli responder di rete che non
  lanciano programmi esterni.

L'`inetd.conf` di USERS mostra anche la specializzazione per ruolo. Dopo il
marker `##END` compare la porzione specifica della macchina
([systems/users/system/inetd.conf](../systems/users/system/inetd.conf)):

```conf
##END
#   USERS SERVER portion
ftp     stream  tcp  nowait  root  /usr/etc/tcpd  /usr/local/etc/ftpd
finger  stream  tcp  nowait  root  /usr/local/etc/fingerd  /usr/local/etc/fingerd -b
imap    stream  tcp  nowait  root  /usr/etc/tcpd  /usr/local/etc/imapd
pop3    stream  tcp  nowait  root  /usr/etc/tcpd  /usr/local/etc/popper
```

Il commento sopra `##END` spiega che le porzioni aggiuntive vengono aggiunte in
coda al file **durante il boot**. La macchina quindi partiva da una base comune
e aggiungeva i servizi coerenti con il proprio ruolo: DATA l'FTP anonimo, USERS
POP3/IMAP, finger, FTP autenticato e gli helper RPC. Lo stesso file elenca anche
gli helper NFS `mountd`/`rquotad`; la sezione [NIS e NFS](#nis-e-nfs-furono-deliberatamente-evitati)
spiega perché, nonostante la riga presente, nessun server NFS risultasse in
esercizio.

I nomi e le porte usati da questi servizi sono nella tabella di sistema
[systems/users/system/services](../systems/users/system/services) (per esempio
`telnet 23/tcp`, `finger 79/tcp`, `pop3 110/tcp`, `imap 143/tcp`, `tacacs
49/udp`).

### `tcpd`: mettere un controllo davanti al daemon

Molte righe di `inetd.conf` non lanciano direttamente il servizio: il programma
avviato è prima `tcpd`, e soltanto dopo `in.telnetd`, `in.rshd`, `ftpd` e così
via. `tcpd`, parte dei **TCP Wrappers**, introduce un livello di controllo e di
logging davanti al daemon:

```text
client
  ↓
inetd
  ↓
tcpd
  ↓
controllo accesso / logging
  ↓
telnetd / ftpd / ...
```

Quindi anche quando il servizio esiste, non significa che qualunque host possa
necessariamente usarlo.

### Installato non significa attivo: la workstation `marco`

La workstation Linux `marco` conserva un file di startup in cui molti servizi
sono esplicitamente lasciati spenti
([systems/marco/system/rc.inet2](../systems/marco/system/rc.inet2)):

```sh
# Start the SUN RPC Portmapper.
#if [ -f ${NET}/rpc.portmap ]; then
#   ${NET}/rpc.portmap
#fi

# # Start the NAMED/BIND name server.
# if [ -f ${NET}/named ]; then
#   ${NET}/named
# fi

# # Start the ROUTEd server.
# if [ -f ${NET}/routed ]; then
#   ${NET}/routed -g -s
# fi

# # Start the RWHO server.
# if [ -f ${NET}/rwhod ]; then
#   ${NET}/rwhod -t -s
# fi
```

Le righe iniziano con `#`, quindi sono commentate: il sistema possiede il
software, ma non lo avvia. Anche il blocco NIS è commentato. È un ottimo
esempio della differenza fra **programma installato** e **servizio effettivamente
attivo**, ed è coerente con la funzione originaria di `marco`: una workstation
sperimentale sulla quale si poteva installare, rimuovere, rompere e ricostruire
il sistema senza compromettere le Sun di produzione.

## Telnet e l'accesso amministrativo

Guardando con occhi moderni, vedere Telnet attivo può sembrare un errore. Nel
1995 non lo era: Telnet era uno degli strumenti normali con cui si
amministravano sistemi UNIX remoti, e Internet Force lo usava. La sicurezza non
consisteva nel fingere che il servizio non esistesse, ma nel limitarne
l'accesso.

FireWall-1 consentiva i percorsi amministrativi soltanto dalle macchine
autorizzate, come `marco` e DVLP (regole 10 e 11). Quindi:

```text
Telnet attivo sul server
        ≠
Telnet aperto a Internet
```

Il percorso era piuttosto:

```text
workstation amministrativa autorizzata
      ↓
policy FireWall-1
      ↓
tcpd / servizio Telnet
      ↓
server
```

In una fase successiva Marco sostituì Telnet con **SSH**, che cifra la sessione e
quindi anche le credenziali, mentre Telnet trasmette il traffico in chiaro. La
sequenza storica corretta è:

```text
fase iniziale
Telnet + restrizioni firewall
      ↓
fase successiva
SSH
```

L'archivio recuperato non contiene una configurazione SSH che permetta di datare
con precisione il singolo passaggio: la transizione è registrata come evoluzione
operativa e nella cronologia del 1996, non come
una riga di uno degli `inetd.conf` recuperati. Per questo **SSH e SCP sono
presentati come sostituti sicuri adottati nella fase successiva**, senza
attribuirne una data a uno snapshot specifico.

## Hardening degli host

Anche gli host UNIX erano irrobustiti:

- **tcpd (TCP wrappers)** avvolgeva i servizi lanciati da `inetd` (telnet,
  shell/rsh, login/rlogin, finger, ftp) sui server, fornendo logging e controllo
  degli accessi.
- **`ftpusers`** negava il login FTP agli account di sistema (`root`, `daemon`,
  `bin`, `sys`, `uucp`, `news`, `majordomo`, `operator`, `nobody`).
- **`fixperms`** veniva eseguito per stringere i permessi: `/etc/hosts.equiv` e
  `.rhosts` erano resi di sola lettura, il kernel era protetto e i bit
  set-user-id erano rimossi da strumenti come `mail`, `cu`, `tip` e
  `sendmail.mx`.
- **`/etc/hosts.equiv`** era vuoto, quindi non era concessa la fiducia basata
  sull'host.
- Il firewall e i server usavano un **ordine di resolver ristretto** e servizi
  in esecuzione minimi.

Il diario delle modifiche post-installazione documenta anche interventi minori
ma concreti, per esempio la rimozione del permesso di scrittura per tutti sul
file del messaggio di login:

```text
chmod 666 /etc/motd   →   chmod 664 /etc/motd
```

e, su DATA, la rimozione della possibilità di eseguire `uudecode` da `/bin`
(un tool in grado di ricostruire binari a partire da testo codificato):

```text
In /bin/ tolta la possibilita' di eseguire uudecode.

-rwxr--r--  1 root staff 16384 Oct 14 1994 uudecode*
```

(estratto da
[system.modification-after_OSINSTALLATION.txt](../artifacts/scripts/system.modification-after_OSINSTALLATION.txt)).

### Permessi, setuid e privilegi minimi

Per leggere l'hardening servono due concetti di base di UNIX.

**I permessi.** Ogni file ha un proprietario e tre terne di bit
(lettura/scrittura/esecuzione) per proprietario, gruppo e altri. Cambiarli
significa cambiare *chi* può fare *cosa*. Esempi dallo script
[`fixperms`](../systems/firewall/system/fixperms) (FIREWALL e USERS ne
conservavano copie byte-identiche; è pubblicata una sola copia di riferimento):

```sh
chmod 0700 /vmunix
chmod 0400 /.rhosts
chmod 0600 /etc/fstab
chmod 0400 /etc/hosts.equiv
```

Riga per riga:

- `chmod 0700 /vmunix` — il kernel diventa leggibile, scrivibile ed eseguibile
  **solo dal proprietario** (root): nessun altro utente lo tocca.
- `chmod 0400 /.rhosts` — la fiducia basata su host diventa **solo lettura**, e
  solo per root.
- `chmod 0600 /etc/fstab` — il file che descrive i mount diventa leggibile e
  scrivibile **solo dal proprietario**: nessun altro utente può alterare cosa
  viene montato dove.
- `chmod 0400 /etc/hosts.equiv` — anche questo file di fiducia fra macchine
  diventa di sola lettura.

La logica è sempre la stessa:

```text
file importante
      ↓
meno utenti possono modificarlo
      ↓
meno modi esistono per cambiare il comportamento del sistema
```

**Il setuid.** UNIX permette ad alcuni eseguibili di partire con i privilegi del
*proprietario del file* invece che con quelli dell'utente che li lancia. È il
meccanismo **setuid**. È utile, ma pericoloso: un programma setuid root contiene
implicitamente la promessa che quel codice possa fare cose che l'utente normale
non potrebbe fare. Più programmi del genere esistono, maggiore è la superficie
d'attacco. Nello stesso `fixperms` compaiono quindi righe come:

```sh
chmod u-s /usr/bin/mail
chmod u-s /usr/bin/chsh
chmod u-s /usr/bin/chfn
chmod u-s /usr/ucb/rdist
chmod u-s /usr/etc/shutdown
chmod u-s /usr/lib/sendmail.mx
```

`chmod u-s` **toglie il bit setuid**: quei programmi, quando possibile, non
partono più con privilegi speciali. È hardening molto concreto: non una policy
astratta, ma bit cambiati sul filesystem. Lo stesso script assegna inoltre a
`root` la proprietà dei binari non setuid e al gruppo `staff` i binari non
setgid, riducendo le proprietà privilegiate sparse sul sistema.

### Il web server non gira come root

Un altro principio è che **anche quando un servizio deve esistere, non significa
che debba girare come root**. Il concetto di **superuser** (root) è quello
dell'account che può fare qualsiasi cosa sul sistema; il principio del
**privilegio minimo** dice che ogni processo e ogni account dovrebbero avere
solo i poteri necessari al proprio compito.

NCSA HTTPd era configurato esattamente così
([systems/users/system/httpd/httpd.conf](../systems/users/system/httpd/httpd.conf)):

```conf
User nobody
Group nogroup
```

Il web server svolge quindi il lavoro ordinario come account poco privilegiato.
Se un bug consente a qualcuno di controllare il processo HTTPd, l'attaccante non
ottiene automaticamente tutti i poteri del superuser. Gli account di servizio
dei server seguono la stessa idea e hanno shell non interattive o confinate:
nelle password database sanitizzate compaiono `nobody`, `daemon`, `bin`, `news`,
`majordomo` e gli altri account di sistema con shell come `/bin/nosh`
([systems/firewall/system/passwd](../systems/firewall/system/passwd),
[systems/data/system/passwd](../systems/data/system/passwd)).

## Confinamento: `chroot`, restricted shell e account

Non basta decidere "chi può entrare". Anche un utente autorizzato non deve
necessariamente vedere tutto il filesystem, e lo stesso vale per un servizio
compromesso. La strategia è ridurre il mondo visibile al processo.

### Cosa vuol dire `chroot`

Normalmente un processo vede `/` come radice dell'intero filesystem. Con
`chroot`, una sottodirectory viene resa la nuova `/` per quel processo e per i
suoi figli:

```text
filesystem reale:            dopo il confinamento il processo vede:
/users/01/segir/             /
├── etc/                     ├── etc/
├── bin/                     ├── bin/
├── home/                    ├── home/
└── ftp-world/               └── ftp-world/
```

Ciò che sta sopra `/users/01/segir` non fa più parte della normale vista di
quella sessione. Nel 1995 era un meccanismo molto utile per limitare i danni
potenziali di un account o di un servizio esposto. Non va però reinterpretato
come un container moderno: `chroot` riduceva la vista del filesystem, ma non
costituiva da solo una sandbox assoluta.

### Esempio reale: FTP su USERS

Il confinamento FTP non è una ricostruzione moderna: è documentato nella
configurazione. L'`inetd.conf` di USERS lo dice esplicitamente
([systems/users/system/inetd.conf](../systems/users/system/inetd.conf)):

```conf
# Wu-ftpd for anonymous and/or real (chrooted) FTP access.
ftp stream tcp nowait root /usr/etc/tcpd /usr/local/etc/ftpd
```

Un account reale aveva una home con la convenzione guest/chroot di wu-ftpd:

```text
/users/01/segir/./ftp-world:/ftponly
```

La parte prima di `./` identifica il punto che diventa la nuova radice
(`/users/01/segir`); la directory dopo `./` (`ftp-world`) è la directory iniziale
della sessione; `/ftponly`, elencata anche tra le shell valide
([systems/users/system/shells](../systems/users/system/shells)), impedisce una
normale shell interattiva. Il cliente vede soltanto il piccolo ambiente che gli è
stato assegnato.

### Account confinati e jail filesystem

La stessa procedura di creazione account applicava il confinamento. Lo script
`adduser` conservato in
[systems/users/system/restricted-shell.txt](../systems/users/system/restricted-shell.txt)
costruisce una piccola radice per ogni cliente:

```sh
mkdir $USERBASE/$login                  # jail root
homedir=$USERBASE/$login/./home         # home
mkdir $homedir
...
# create jailed password file
jailpasswd=$USERBASE/$login/etc/passwd
echo "root:*:0:0:root:/:/dev/null" > $jailpasswd
echo "$login:*:$newuid:$USERGID:$realname:/home:$USERSHELL" >> $jailpasswd
```

Riga per riga:

- `mkdir $USERBASE/$login # jail root` — la home del cliente è anche la radice
  di un piccolo filesystem confinato.
- `homedir=$USERBASE/$login/./home` — la stessa convenzione `..././...` di
  wu-ftpd separa la radice del chroot dalla directory iniziale.
- `etc/passwd` **dentro la jail** — il servizio confinato ha una copia minima
  del file degli account (qui solo `root` e il cliente) invece di esporre
  l'`/etc/passwd` reale della macchina.

Su DATA il diario di installazione registra la correzione di ownership di un
piccolo `etc` dentro l'ambiente FTP:

```text
/usr/localftp/etc/passwd
/usr/localftp/etc/group
```

passati da `bin.ftp` a `root.ftp`. La presenza di `passwd` e `group` dentro
`/usr/localftp` è coerente con il classico anonymous-FTP chroot: il servizio
dispone nel proprio filesystem confinato dei pochi file necessari senza esporre
l'`/etc` reale. È l'idea di una **jail** UNIX dell'epoca: non una checkbox, ma
una gerarchia di directory, file, ownership e permessi da costruire.

Gli account con accesso fortemente confinato usavano shell dedicate:

```text
/bin/nosh    → impedisce una normale shell interattiva
/bin/lynx    → accesso limitato (per esempio solo navigazione/testo)
/ftponly     → solo FTP, nessuna shell
```

### Chroot non è restricted shell

Internet Force usava anche configurazioni di restricted shell e account con shell
come `/bin/nosh` e `/bin/lynx`. Questi meccanismi perseguono lo stesso obiettivo
generale - confinare - ma lavorano a livelli differenti:

```text
chroot            → limita la parte di filesystem visibile
restricted shell  → limita i comandi che l'utente può eseguire
/bin/nosh         → impedisce una normale shell interattiva
account non privilegiato → limita i poteri del processo
```

Spesso la sicurezza nasceva proprio dalla combinazione di più strumenti.

### Tutti i servizi erano chrooted?

No, almeno non sulla base dei reperti disponibili. Abbiamo evidenza diretta del
chroot nel mondo FTP e del confinamento degli account. Per altri daemon come
BIND, Sendmail, NCSA HTTPd, XTACACS, POP3 o IMAP non abbiamo materiale
sufficiente per affermare che **ogni singolo servizio** girasse sempre dentro un
chroot.

La formulazione storicamente corretta è:

> Internet Force applicava sistematicamente il principio del confinamento,
> usando `chroot` quando appropriato e combinandolo con restricted shell,
> account non privilegiati, permessi UNIX, `tcp_wrappers` e policy di rete.

È più preciso e spiega meglio il metodo.

## NIS e NFS furono deliberatamente evitati

Internet Force **non** usava deliberatamente NIS né NFS in produzione. Entrambi
erano ben noti per ampliare la superficie d'attacco di un ambiente UNIX esposto a Internet, ed erano considerati troppo rischiosi per i server centrali.

I file recuperati lo riflettono. Nessun dominio NIS è servito e nessun
`ypbind`/`ypserv` gira. Nessun server NFS gira: la lista dei processi vivi su
USERS non mostra né `nfsd` né `rpc.mountd`; il blocco NFS-server in
`/etc/rc.local` è condizionato a `/etc/exports`, che non esiste, quindi non
viene mai eseguito; l'altro blocco NFS-server è materiale SunOS commentato.
`/etc/fstab` non ha mount NFS e la tabella dei filesystem montati mostra solo
filesystem locali. I processi `biod`, `rpc.lockd` e `rpc.statd` sono helper
standard di client/RPC e non indicano uso attivo di NFS - gli stessi servizi
erano soggetti alla regola finale STOP del firewall. L'unico artefatto NFS di
qualche sostanza è la regola SHELL pianificata descritta sopra.

Il suo effetto principale era la semplicità operativa: ogni server teneva i
propri dati e autenticava localmente, con XTACACS unico servizio di credenziali
condiviso. I residui in `/etc/xtab` sono stato generato residuo dai default di
SunOS e non hanno mai riflesso un servizio NFS funzionante.

## Ambito del firewall

Vale la pena essere precisi su cosa sorvegliava il firewall. Il suo compito
erano i server centrali e la LAN dell'ufficio - le macchine che esponevano
servizi e che quindi avevano bisogno di protezione - con un'interfaccia e una
policy separate per ciascuno (DATA, USERS, lo SHELL pianificato e la rete
dell'ufficio). I clienti dial-up non rientravano in quella categoria: una
sessione cliente non espone alcun servizio proprio, quindi non c'era nulla da
proteggere dal lato client. Il traffico dei clienti viaggiava sul
world/backbone fino al 2501 centrale e da lì verso IDT.

## Difesa in profondità

Alla fine il modello può essere visto come una serie di cerchi concentrici:

```text
servizi realmente necessari
        ↓
account con privilegi minimi
        ↓
chroot / restricted shell
        ↓
permessi UNIX e rimozione di setuid inutili
        ↓
tcp_wrappers
        ↓
separazione build/produzione
        ↓
routing e segmentazione
        ↓
FireWall-1
        ↓
successiva sostituzione di Telnet con SSH
```

Se un livello fallisce, quello successivo continua a limitare ciò che può
accadere. È la lezione più moderna che emerge da configurazioni vecchie di
trent'anni: il principio della **defence in depth** era già riconoscibile, anche
se gli strumenti avevano nomi meno alla moda. Nessun singolo `inetd.conf`
descrive da solo la pratica di sicurezza del provider: la descrive la
combinazione di questi livelli.

## Cosa portarsi a casa

Dopo aver installato UNIX su una macchina esposta a Internet non bastava
chiedersi:

```text
funziona?
```

Bisognava chiedersi:

```text
quali servizi servono davvero?
chi può raggiungerli?
con quali privilegi girano?
quale parte del filesystem vedono?
quali programmi privilegiati posso eliminare?
da quali macchine è permessa l'amministrazione?
cosa succede se un singolo livello viene compromesso?
```

Soltanto dopo queste domande una Sun poteva diventare un server di produzione
dell'ISP. Ed è questo il senso del percorso: non imparare a memoria una
configurazione SunOS del 1995, ma capire il ragionamento con cui quella macchina
veniva trasformata da UNIX appena installato a componente affidabile di una rete
Internet.

---

Vedi anche: [Panoramica dell'architettura](01-architecture.md) ·
[Web, FTP, news e mailing list](05-web-news-ftp.md) ·
[Operazioni e backup](14-operations-and-backup.md) ·
[Sistema firewall](../systems/firewall/README.md)

---

→ [Costruire un Internet Force POP, passo per passo](00-build-an-isp.md)
