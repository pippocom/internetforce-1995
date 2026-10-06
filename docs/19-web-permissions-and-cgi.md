🇮🇹 **Italiano** · [🇬🇧 English](19-web-permissions-and-cgi.en.md)

# Permessi web e CGI

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

## Quale problema risolve

Sul web di Internet Force convivevano pagine statiche, aree personali dei
clienti, siti virtuali e **programmi CGI**. Un CGI è un programma che il server
web esegue al posto di inviare un file html: perché funzioni servono il file
giusto **nel posto giusto** (sul server), con **proprietario** e **permessi** corretti, e un
modello di esecuzione sicuro. Questo capitolo spiega quel modello su DATA e
USERS.

## Dal documento statico all'applicazione Web

Oggi una “pagina Web” è spesso il risultato finale di una catena piuttosto
complessa: applicazioni, framework, database, template, API e codice
eseguito sia sul server sia nel browser. Il Web dei primi anni era
concettualmente molto più semplice.

Il **browser** era il client: chiedeva una risorsa attraverso HTTP,
riceveva HTML e lo interpretava per costruire ciò che l'utente vedeva.
Il **Web server** svolgeva il ruolo opposto: riceveva la richiesta,
individuava la risorsa corrispondente e la restituiva al browser.

Nel caso più comune quella risorsa era semplicemente un **file HTML già
presente sul filesystem**. Il server non doveva costruire la pagina né
interpretarne il contenuto: leggeva il file e lo inviava. Se l'HTML
conteneva immagini, era poi il browser a richiederle separatamente al
server.

Il Web nasceva quindi soprattutto come un sistema per pubblicare e
collegare **documenti**.

### HTML e immagini: quando il Web era fatto di file

Anche graficamente le pagine erano molto diverse da quelle
contemporanee. Il formato **GIF** era onnipresente per loghi, pulsanti,
icone, barre, sfondi e altri elementi dell'interfaccia, grazie alle
dimensioni contenute e alla possibilità di utilizzare una palette
indicizzata e la trasparenza. **JPEG** era già disponibile ed era
particolarmente utile per fotografie e immagini a tonalità continue, ma
buona parte della grafica tipica di un sito degli anni Novanta finiva in
file `.gif`.

A metà del decennio comparvero diffusamente anche le **GIF animate**:
più immagini memorizzate nello stesso file e visualizzate in sequenza
dal browser. Per qualche anno divennero quasi un elemento obbligatorio
del paesaggio Web, dai piccoli indicatori “new” alle animazioni
decorative.

Lo [snapshot storico di pippo.com del
1997](../systems/marco/personal-web/pippo.com-1997/snapshot/index.html)
conservato in questo repository appartiene esattamente a quella
generazione del Web: HTML, frame, immagini GIF e animazioni erano parte
della pagina, non il risultato di una moderna applicazione front-end.
Un esempio concreto è [`titolo.gif`](../systems/marco/personal-web/pippo.com-1997/snapshot/titolo.gif),
la GIF animata utilizzata nella pagina originale.

La distinzione importante è che **HTML e immagini erano normalmente file
già pronti**. Nel caso più semplice il server non generava la pagina: la
serviva.

### SSI: il server comincia a modificare il documento

Presto divenne utile produrre pagine che contenessero almeno qualche
informazione variabile senza dover scrivere un programma completo.

NCSA HTTPd supportava già i **Server-Side Includes (SSI)**, chiamati
anche *server-parsed HTML*. Invece di spedire immediatamente il file
richiesto, il server poteva riconoscere alcuni documenti come da
elaborare, spesso attraverso l'estensione `.shtml`, leggerli e
interpretare speciali direttive inserite nell'HTML prima di inviare il
risultato al browser.

Con gli SSI si potevano, per esempio, includere automaticamente il
contenuto di un altro file, mostrare una data o altre informazioni
relative al documento e, quando l'amministratore lo permetteva, persino
eseguire un comando o richiamare un programma.

Il modello cambiava quindi leggermente:

**browser → richiesta HTTP → Web server → file HTML + elaborazione SSI →
HTML risultante → browser**

Il browser continuava a ricevere normale HTML. La novità era che il file
presente sul disco non doveva più coincidere esattamente con ciò che
veniva trasmesso.

Era una prima forma molto semplice di elaborazione **server-side**.

### CGI: una URL poteva eseguire un programma

Il passo successivo era molto più potente. Con la **Common Gateway
Interface (CGI)** una richiesta HTTP poteva avviare un vero programma
sul server.

CGI non era un linguaggio di programmazione: era un'interfaccia fra il
Web server e un programma esterno. Il server passava al programma le
informazioni relative alla richiesta, attraverso variabili d'ambiente
e, a seconda del metodo utilizzato, lo standard input. Il programma
eseguiva la propria logica e scriveva sullo standard output la risposta
da restituire al client, normalmente intestazioni HTTP/CGI seguite da
HTML.

Il programma poteva essere scritto in C, Perl, shell o qualunque altro
linguaggio disponibile sul sistema.

La directory `cgi-bin` divenne il luogo tipico nel quale installare
questi programmi, ma non era una proprietà intrinseca dello standard
CGI: era il Web server a decidere quali directory o file potessero
essere eseguiti come CGI.

Su Unix questo introduceva immediatamente anche una questione di
**permessi**. Il file doveva essere eseguibile dall'utente con cui
girava il Web server, la directory doveva essere configurata per
consentirne l'esecuzione e il programma poteva accedere soltanto alle
risorse che i permessi Unix gli consentivano di leggere o modificare.

Una URL non identificava quindi più necessariamente un documento:

**browser → richiesta HTTP → Web server → programma CGI → HTML generato
→ browser**

Quello che il browser vedeva rimaneva HTML. Ma quel documento poteva
non essere mai esistito come file.

Internet Force utilizzò e sviluppò CGI proprio per aggiungere
interattività ai siti; alcuni degli script e delle relative informazioni
sopravvivono nella [documentazione del software Web
recuperato](../systems/data/web/cgi-and-web-software.md).

### PHP/FI: il programma entra nella pagina

CGI aveva però un modello molto netto: da una parte il documento HTML,
dall'altra un programma che generava HTML.

Un'altra idea cominciò a imporsi quasi contemporaneamente: mantenere la
pagina simile a un normale documento HTML, ma inserirvi direttamente
**istruzioni da eseguire sul server**.

PHP nacque inizialmente proprio come una raccolta di programmi CGI. Nel
1995 FI (*Forms Interpreter*) introdusse una sintassi incorporata
nell'HTML; nel 1996 PHP/FI riunì quelle idee in quello che stava ormai
diventando un vero linguaggio di scripting per il Web.

Internet Force installò **PHP/FI nel marzo 1996**, inizialmente
utilizzandolo come CGI. In quel modello il Web server riconosceva le
pagine da elaborare e le passava al programma PHP/FI; il parser eseguiva
le istruzioni incorporate e produceva l'HTML che veniva infine inviato
al browser.

Il modello diventava quindi:

**browser → Web server → pagina con HTML + codice server-side → PHP/FI →
HTML risultante → browser**

Per il browser non cambiava quasi nulla. Continuava a ricevere HTML. La
trasformazione fondamentale avveniva **prima, sul server**.

Era il passaggio dal documento statico a qualcosa che cominciava ad
assomigliare a una vera applicazione Web.

### Da CGI ai moduli del Web server

CGI aveva anche un costo: nel modello classico una richiesta richiedeva
l'avvio di un processo esterno. Con l'aumentare della complessità e del
traffico divenne naturale integrare più strettamente queste funzioni nel
Web server.

Apache, che in Internet Force sostituì successivamente NCSA HTTPd,
disponeva di un'architettura modulare. Già nel 1996 PHP/FI poteva essere
compilato anche come **modulo Apache**: in quel caso il parser non
veniva più avviato come programma CGI separato, ma eseguiva direttamente
all'interno del processo `httpd`.

Le diverse tecniche non si sostituirono ordinatamente una dopo l'altra.
HTML statico, SSI, CGI e scripting embedded continuarono a convivere.
Rappresentano però bene la direzione dell'evoluzione:

**file statico → documento elaborato dal server → programma che genera
HTML → codice incorporato nella pagina → logica integrata nel Web
server**

Internet Force attraversò proprio questa transizione. Il Web partì con
**NCSA HTTPd** e pagine HTML preparate manualmente; quando serviva
interattività venivano sviluppati CGI; nel marzo 1996 arrivò **PHP/FI**;
successivamente NCSA HTTPd fu sostituito da **Apache** e l'ambiente Web
continuò a evolvere verso applicazioni collegate anche a dati
persistenti.

In pochi anni il Web server era passato dall'essere soprattutto un
distributore di file a diventare un ambiente nel quale il documento
poteva essere composto, modificato o generato al momento della
richiesta. Il browser continuava a ricevere HTML: ciò che stava
cambiando radicalmente era ciò che succedeva **prima, sul server**.

## Come lo implementava Internet Force

- Le pagine venivano modificate, caricate su **DVLP** per il test e poi rilasciate
  su **USERS** (pagine personali) o **DATA** (siti clienti/virtuali): vedi
  [Sviluppo e DVLP](07-development.md).
- La mappatura CGI era definita nella configurazione NCSA HTTPd (`srm.conf`): la
  directory degli script e il loro alias pubblico.
- La coerenza dei permessi era mantenuta con uno script di sistema, `fixperms`,
  che riportava i binari di sistema al proprietario corretto e correggeva i casi
  segnalati dal controllo di sicurezza (Tiger/COPS).
- I CGI di terze parti effettivamente usati da Internet Force sono documentati
  nell'inventario dedicato, con nome, versione (dove nota), ruolo storico,
  configurazione/personalizzazione locale e link upstream ufficiale.

## Componenti e host

- **DATA** — server web centrale (`www1.intf.com`), siti clienti e virtuali.
- **USERS** — pagine personali degli utenti.
- **DVLP** — test dei contenuti prima della pubblicazione.

## Evidenza rappresentativa

Esempio dallo script di sistema recuperato `fixperms`, che impone il proprietario
corretto sui binari:

```sh
BINDIR="/etc /sbin /usr/bin /usr/etc /usr/lib"
for d in $BINDIR
do
        chown root `find $d \! -perm -4000 -a -perm -0111 -a -type f -print`
        chgrp staff `find $d \! -perm -2000 -a -perm -0111 -a -type f -print`
done
```

→ Script completo: [`systems/firewall/system/fixperms`](../systems/firewall/system/fixperms)
→ Configurazione CGI del server web:
[`systems/data/web/srm.conf`](../systems/data/web/srm.conf) ·
[`systems/users/system/httpd/srm.conf`](../systems/users/system/httpd/srm.conf)

## CGI di terze parti usati da Internet Force

L'uso storico è documentato senza ridistribuire il codice upstream:

- **Matt Wright — Random Image Displayer** (`advert.cgi`), versione 1.2, usato per
  i banner casuali dei siti Internet Force. I termini di Matt Wright richiedono il
  permesso per la ridistribuzione, quindi il sorgente **non** è pubblicato;
  l'uso e la configurazione sì. Link ufficiale:
  <https://www.scriptarchive.com/>.
- Altri script di terze parti conservati come copie di lavoro
  (`guestbook.cgi`, `ssis.pl`) e materiale EFF/Selena Sol.

Inventario completo: [`systems/data/web/cgi-and-web-software.md`](../systems/data/web/cgi-and-web-software.md).

## Aspetti di sicurezza

L'esecuzione di CGI come utente del server web, la proprietà dei file e il
confinamento degli account sono trattati in [Sicurezza](06-security.md). In
particolare il modello `chroot` / restricted-shell e la lista `ftpusers`
mostrano come Internet Force riducesse i privilegi dei processi esposti.

## Materiale originale correlato

- [`systems/data/web/cgi-and-web-software.md`](../systems/data/web/cgi-and-web-software.md) — inventario CGI.
- [`systems/data/web/scripts/`](../systems/data/web/scripts/README.md) — script recuperati.
- [`systems/firewall/system/fixperms`](../systems/firewall/system/fixperms) — permessi.
- [`docs/05-web-news-ftp.md`](05-web-news-ftp.md) — server web e hosting virtuale.

---

← [Costruire un POP](00-build-an-isp.md) ·
Precedente: [Web server](05-web-news-ftp.md) ·
Prossimo: [Virtual hosting (VIF)](../systems/sun-vif/README.md) →
