# Persone, macchine e workflow

> **Internet Force 1995--1996 Historical Archive**\
> Ricostruzione e documentazione tecnica basate sui materiali originali
> Internet Force conservati da **Marco Iannacone**.\
> Autore e curatore dell'archivio: **Marco Iannacone** ·
> https://pippo.com\
> Licenza: [CC BY 4.0](../LICENSE)

[English version](15-people-and-workflows.en.md)

## 1. Perché documentare anche le persone

L'infrastruttura di Internet Force non era fatta soltanto di Sun, Cisco,
modem e linee seriali. La rete dell'ufficio mostra anche come il lavoro
veniva distribuito tra persone, workstation e sistemi centrali.

Gli hostname sono, in questo senso, una sorta di **organigramma
fossile**. I server principali avevano nomi funzionali (`data`, `users`,
`dvlp`); molte workstation dell'ufficio portavano invece il nome
dell'utilizzatore (`anna`, `franz`, `laura`, `alice`, `salvatore`,
`maus`, `pascal`, `marco`) oppure della funzione (`html`). `maxi` era la
workstation portatile utilizzata dal principale commerciale.

Questa pagina ricostruisce il rapporto tra persone, macchine e processi
operativi. Le specifiche hardware sono riportate quando recuperate dalla
documentazione o ricostruite con sufficiente precisione; dove il dato
non è ancora disponibile non viene inventato.

## 2. Office LAN

La rete dell'ufficio occupava la subnet pubblica **206.20.95.128/25**.
Era collegata al firewall tramite `le0` (`206.20.95.129`) e utilizzava
un hub Ethernet 10Base-T, identificato nella documentazione come un
**3Com LinkBuilder FMS II**.

  ------------------------------------------------------------------------
  Host                                IP Sistema /        Ruolo principale
                                         hardware
  ---------------- --------------------- ---------------- ----------------
  `anna`                 `206.20.95.131` modello non      segreteria e
                                         identificato     primo livello
                                                          customer support

  `franz`                `206.20.95.132` Macintosh,       direzione
                                         modello non      commerciale, PR,
                                         identificato     pubblicità,
                                                          promozione e
                                                          partnership

  `maxi`                 `206.20.95.133` PowerBook 190    area commerciale:
                                         16 MB RAM        abbonamenti
                                                          B2B/B2C, siti Web
                                                          e sviluppi
                                                          applicativi

  `html`                 `206.20.95.134` Macintosh,       authoring HTML
                                         modello non
                                         identificato

  `laura`                `206.20.95.135` Power Macintosh  redazione / DTP
                                         9500, 2 GB,
                                         probabilmente 32
                                         MB RAM

  `alice`                `206.20.95.136` Power Macintosh  redazione / DTP
                                         9500, 2 GB

  `salvatore`            `206.20.95.137` Power Macintosh, art direction /
                                         modello non      grafica
                                         identificato,
                                         probabilmente 32
                                         MB RAM

  `maus`                 `206.20.95.138` Power Macintosh  supporto tecnico
                                         8500, 16 MB RAM, hardware
                                         1 GB             dell'ufficio

  `pascal`               `206.20.95.139` Power Macintosh  direttore IT
                                         9500, 2 GB

  `marco`                `206.20.95.140` 486DX Linux, 16  system & network
                                         MB RAM, 1 GB     administration
                                         SCSI
  ------------------------------------------------------------------------

Dei Power Macintosh 9500 recuperati dall'inventario, tutti disponevano
di **2 GB di disco**; uno aveva **32 MB di RAM**. Con buona probabilità
la configurazione più potente era `laura`, una delle workstation DTP principali.
`salvatore`, anch'essa una workstation da power user, disponeva probabilmente di 32 MB, ma
Marco non ha saputo ricostruire il modello preciso del Power Macintosh.

## 3. Ruoli tecnici e organizzativi

### Pascal --- direzione IT

`pascal` era utilizzato dal **direttore IT**. Il ruolo derivava da
competenze tecniche trasversali sui sistemi dell'ufficio, in particolare
ambienti Windows e Macintosh, oltre che dall'esperienza professionale.

La direzione IT non coincideva però con la responsabilità specialistica
dell'infrastruttura Internet. Su numerosi domini tecnici Pascal si
confrontava con Marco; attività specialistiche come il successivo
progetto Windows NT e Oracle non rientravano nelle sue competenze
operative.

### Marco --- system & network administration

Marco Iannacone lavorava per Internet Force come **consulente
full-time**, con compenso mensile fisso e responsabilità continuativa
per l'amministrazione dei sistemi Unix e dell'infrastruttura di rete del
provider.

Il [contratto di consulenza del 1996](../artifacts/company/marco-iannacone-consulting-contract-1996/README.md) conservato nell'archivio documenta formalmente questo rapporto professionale.

Il suo perimetro comprendeva i server SunOS, i servizi Internet, la rete
Cisco, i POP, autenticazione, DNS, mail, Web, sicurezza e monitoraggio.
La workstation `marco` era un PC 486DX con Linux Slackware 2.1, 16 MB di RAM
e 1 GB di storage SCSI; da qui venivano svolte anche attività di
monitoraggio SNMP tramite tkined.

Quando Internet Force aveva necessità esterne all'incarico ordinario, i
soci chiedevano separatamente a Marco disponibilità e competenze. Queste
attività diventavano consulenze aggiuntive. Due esempi sono lo sviluppo
del software **Easy!**, richiesto da Internet Force per semplificare
l'accesso ai servizi, e il progetto **Windows NT + Oracle** nato da una
richiesta di un cliente.

### Maus --- supporto hardware

`maus`, un Power Macintosh 8500 con 16 MB di RAM e disco da 1 GB, era
utilizzato per il **supporto tecnico dell'hardware dell'ufficio**, con
particolare attenzione alle macchine della redazione.

La redazione comprendeva anche altre persone dedicate soprattutto alla
rivista cartacea e meno direttamente coinvolte nelle attività
Internet Force documentate in questo archivio.

### Laura e Alice --- redazione e DTP

`laura` e `alice` erano Power Macintosh 9500 utilizzati dalla redazione.
Le workstation disponevano di una suite professionale di desktop
publishing e grafica comprendente **QuarkXPress, Adobe PageMaker, Adobe
Photoshop e Adobe Type Manager**.

La redazione produceva sia contenuti destinati al Web sia una rivista
stampata. Il lavoro editoriale e grafico era quindi parte di un ambiente
che univa produzione cartacea e pubblicazione Internet.

### Salvatore --- art direction e grafica

`salvatore` era una workstation Power Macintosh utilizzata per **art
direction e produzione grafica**. Da qui venivano preparate le immagini
e gli asset finali destinati ai siti Web e agli altri materiali
dell'azienda.

Il modello esatto del Power Macintosh non è ancora stato identificato.

### HTML --- authoring Web

`html` era la workstation dedicata alla **realizzazione manuale delle
pagine HTML**. Nel 1995 la produzione di un sito significava in larga
misura scrivere direttamente markup, integrare testi e asset grafici e
verificare il risultato con i browser dell'epoca.

### Maxi --- area commerciale

`maxi` era la workstation dell'**area commerciale**. Il ruolo è
documentato dalla ricostruzione organizzativa: vendita degli abbonamenti
annuali Internet sia **B2B sia B2C**, vendita di siti Web, sviluppi
applicativi e altri servizi professionali offerti da Internet Force.

L'hardware è invece una ricostruzione mnemonica: con buona probabilità
si trattava di un **PowerBook 190 con 16 MB di RAM**.

### Anna --- segreteria e customer support di primo livello

`anna` (`206.20.95.131`) era la macchina della **segreteria**. Qui
venivano caricate nel gestionale le schede dei nuovi clienti ricevute
dall'area commerciale, collegando quindi il processo di vendita al
provisioning amministrativo e tecnico degli abbonamenti; i dati raccolti
venivano poi inviati a Marco per l'attivazione tecnica degli account su
`users`.

La segreteria svolgeva inoltre una funzione di **primo livello del
customer support**, gestendo la posta di supporto indirizzata al
customer service e instradando verso il livello tecnico i problemi che
richiedevano interventi sull'infrastruttura o sui servizi.

### Franz --- direzione commerciale e relazioni esterne

`franz` (`206.20.95.132`) era la workstation del **direttore
commerciale**, una giornalista che curava anche i rapporti con la
stampa.

Il ruolo comprendeva **public relations, pubblicità, promozione e
partnership**, oltre al coordinamento commerciale. La macchina era un
Macintosh; il modello esatto non è stato identificato. `franz`
non compare nella tavola grafica dell'Office LAN per scelta di sintesi,
ma è documentato qui perché fa parte della ricostruzione organizzativa
dell'ufficio.

## 4. Il workflow di produzione Web

La realizzazione dei siti seguiva un processo separato dalla produzione
sui server pubblici.

1.  La redazione preparava testi e contenuti; la direzione artistica
    produceva gli asset grafici.
2.  Sulla workstation `html` venivano costruite manualmente le pagine
    HTML.
3.  I file venivano scambiati attraverso un'area FTP interna predisposta
    su `dvlp`.
4.  I siti completati venivano depositati in una cartella denominata
    `siti`.
5.  Marco recuperava il materiale, verificava completezza e
    funzionamento e provvedeva alla pubblicazione su `data`.
6.  Quando un progetto richiedeva interattività, Marco sviluppava i
    relativi CGI.

Il personale editoriale non effettuava quindi direttamente il deployment
sui sistemi di produzione. Esisteva una separazione pratica tra
authoring, area di scambio/revisione e pubblicazione sul server
pubblico, senza naturalmente utilizzare la terminologia CI/CD che
sarebbe arrivata molto più tardi.

Nel marzo 1996 Marco installò **PHP/FI**. Successivamente venne
installato anche **Postgres95** su `data`, il nome che il database portava
allora e da cui sarebbe nato PostgreSQL. L'ambiente Web evolse quindi
dall'HTML statico scritto a mano ai CGI, poi allo scripting server-side
e infine ad applicazioni collegate a un database.

## 5. Provisioning e supporto degli abbonati

Il ciclo di vita di un nuovo abbonato coinvolgeva sia l'area commerciale
sia l'infrastruttura tecnica.

Dopo la vendita e la raccolta dei dati necessari, l'account veniva
creato su `users`, con login, home directory, mailbox, quota e ambiente
previsto per l'utente. Al cliente venivano forniti il materiale di
configurazione, il Welcome Kit e il numero telefonico del POP da
utilizzare.

Durante la connessione, la chiamata raggiungeva un modem libero
attraverso il gruppo di ricerca telefonico, quindi il Cisco 2511.
L'access server interrogava centralmente `users` tramite XTACACS per
autenticare l'utente. L'assistenza all'utente e il supporto d'ufficio
potevano coinvolgere più persone; i problemi relativi all'infrastruttura
Unix, alla rete e ai servizi centrali arrivavano a Marco. Quando
necessario, esisteva inoltre un livello di confronto specialistico
esterno con Xpert UNIX Systems a Tel Aviv.

## 6. Un ufficio multipiattaforma

L'Office LAN era volutamente eterogenea. Macintosh System 7.5.x era
ampiamente utilizzato per redazione, grafica, commerciale e produzione
Web; Linux era la piattaforma della workstation tecnica di Marco; i
sistemi centrali utilizzavano SunOS.

Nel 1996 si aggiunse `oracolo` (`206.20.95.142`), una macchina **Windows
NT + Oracle** nata da un progetto di consulenza richiesto da un cliente.
Internet Force chiese a Marco se fosse disponibile a occuparsene; non
avendo precedenti esperienze operative con quella piattaforma, studiò NT
e Oracle e realizzò il progetto come attività aggiuntiva rispetto
all'incarico ordinario di system administrator.

## 7. I nomi delle macchine

Nel mondo Unix era comune assegnare agli host nomi appartenenti a un
universo condiviso: mitologia, astronomia, letteratura o fantascienza.

Marco propose inizialmente nomi tratti dal **Signore degli Anelli**;
come seconda scelta l'**Olimpo greco** e come terza **Star Wars**. I
soci considerarono la convenzione troppo giocosa per l'azienda e
preferirono nomi funzionali per i server (`data`, `users`, `dvlp`) e
nomi legati agli utilizzatori per le workstation.

La prima eccezione significativa arrivò con il progetto Oracle. Marco
assegnò personalmente alla nuova macchina Windows NT il nome `oracolo`,
senza sottoporre questa volta la scelta a ulteriori comitati.

## 8. Cosa raccontano questi host

La rete dell'ufficio documenta qualcosa che le sole configurazioni dei
router non mostrano: Internet Force era contemporaneamente provider,
ambiente editoriale, laboratorio Web e società di servizi tecnici.

Nella stessa LAN convivevano produzione della rivista, grafica
professionale, authoring HTML, attività commerciale, supporto hardware,
amministrazione Unix e sviluppo software. I file `hosts`, le
configurazioni e i materiali recuperati permettono quindi di ricostruire
non soltanto **quali macchine esistevano**, ma **come il lavoro
attraversava quelle macchine**.
