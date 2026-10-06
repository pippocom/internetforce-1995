# Quando il sistema operativo si estendeva attraverso la rete: il caso VIF

Nel 1995 "installare una funzione nel sistema operativo" poteva significare
qualcosa di molto diverso da scaricare un aggiornamento ufficiale.

Il pacchetto VIF conservato nell'archivio Internet Force mostra un percorso
quasi completo attraverso il quale una necessità tecnica:

```text
una scheda Ethernet
        +
più indirizzi IP
```

passa dalla ricerca accademica alle discussioni pubbliche su Internet, viene
adattata da amministratori in organizzazioni diverse, trasformata in un
modulo kernel più facile da installare e infine arriva nella configurazione
operativa di un ISP.

Il punto non è sostenere che Sun sviluppasse SunOS pubblicamente.

Il punto, più interessante, è che **il sistema operativo realmente usato da
un amministratore poteva estendersi grazie a codice, patch e conoscenza che
circolavano pubblicamente sulla rete**.

VIF è un caso quasi didattico.

---

## 1. Il limite iniziale: SunOS non faceva ciò che serviva

Internet Force aveva bisogno di ospitare molti domini Web sulla stessa Sun.

Con HTTP/1.0 il virtual hosting richiedeva normalmente un indirizzo IP
differente per ciascun sito.

La macchina aveva però una sola Ethernet fisica.

Su SunOS 4.1.x non era disponibile nativamente il modello di alias IP che
sarebbe poi comparso in Solaris 2.x.

Serviva quindi una nuova capacità nel networking stack:

```text
le0
 ├── indirizzo reale
 ├── indirizzo virtuale 1
 ├── indirizzo virtuale 2
 └── ...
```

Quella capacità non arrivò a Internet Force attraverso un aggiornamento Sun.

Arrivò attraverso la rete.

---

## 2. 1991: ricerca accademica

Il file `README.ji` conservato nella distribuzione attribuisce l'idea originale
a **John Ioannidis**.

Nel messaggio del 13 febbraio 1992 Ioannidis spiega che VIF nasceva dal suo
lavoro di dottorato e rimanda a un paper presentato a **SIGCOMM 1991**.

Lo stesso paper era disponibile tramite anonymous FTP:

```text
cs.columbia.edu:/pub/ji/sigcomm*.ps.Z
```

Il punto di partenza è quindi ricerca accademica, ma il risultato non rimane
chiuso nel paper: codice e spiegazione vengono messi direttamente in
circolazione.

---

## 3. 1992: Usenet e mailing list come luogo di sviluppo

L'intestazione conservata nel pacchetto è:

```text
From: ji@polaris.ctr.columbia.edu (John Ioannidis)
Subject: Multiple IP addresses on a single Ethernet interface
Date: 13 Feb 92 19:33:56 GMT
```

Ioannidis apre osservando che il tema ricorre:

```text
comp.protocols.tcp-ip
and other newsgroups
```

e racconta di aver ricevuto una richiesta proveniente dalla mailing list:

```text
namedroppers
```

La domanda era elementare e molto concreta:

```text
si possono assegnare più indirizzi IP
a un singolo controller di rete?
```

La risposta pratica di Ioannidis non è una descrizione astratta.

Contiene:

- spiegazione del problema;
- comandi `ifconfig`;
- route;
- ARP;
- modifiche alla configurazione del kernel;
- codice C del driver.

In altre parole, il messaggio di rete è contemporaneamente:

```text
discussione
+
documentazione
+
patch
+
distribuzione del software
```

Prima di repository pubblici, issue tracker e pull request, molta collaborazione
tecnica avveniva esattamente così.

---

## 4. Il VIF originale modificava il kernel

La versione descritta nel materiale di Ioannidis richiedeva di aggiungere alla
configurazione del kernel una riga come:

```text
pseudo-device vif4
```

e di registrare il sorgente:

```text
netinet/if_vif.c optional vif device-driver
```

Seguivano modifiche a `conf.c`, compilazione del kernel e reboot.

Quindi il contributo che circolava sulla rete non era semplicemente una
utility.

Modificava il networking stack del sistema operativo.

L'amministratore prendeva un Unix commerciale e gli aggiungeva una capacità
che quel sistema non offriva nativamente.

---

## 5. 1994: il codice passa di mano e viene adattato a SunOS 4.1.x

Dentro `VIF_MAN.GZ`, `mip.txt` conserva un'altra stratificazione.

L'header del forward è:

```text
From: bob@comlab.gtri.gatech.edu (Bob Baggerman)
Subject: Re: Multiple IP addresses for one network port (part 1) (fwd)
Date: Thu, 22 Dec 1994 16:58:23 -0500 (EST)
```

All'interno compare un messaggio di **Chuck Smoko** dello stesso giorno.

Smoko spiega di avere trovato quel materiale "on the net" alcuni anni prima
e di averlo usato su una Sun 4.1.x, apportando le correzioni necessarie.

Il file `VIF-INFO.TXT` sintetizza la genealogia così:

```text
materiale originario: John Ioannidis
correzioni SunOS 4.1.x: Chuck Smoko
raccolta/condensazione: Bob Baggerman
```

Questo è interessante perché la storia del software rimane incorporata nel
software stesso.

Non abbiamo soltanto il sorgente finale.

Abbiamo ancora parte della conversazione che spiega **da dove viene e perché è
cambiato**.

---

## 6. 1995: Steinar Haug lo trasforma in un modulo più operativo

La distribuzione `VIF-1_10.GZ` attribuisce la versione successiva a
**Steinar Haug**.

La modifica decisiva per SunOS è descritta nel README:

```text
made it modloadable (and unloadable) on SunOS 4.1.3/4.1.4
```

Questa è un'evoluzione sostanziale.

Prima:

```text
modifica configurazione kernel
       ↓
compila kernel
       ↓
installa
       ↓
reboot
```

Dopo:

```text
compila vif.o
       ↓
modload
       ↓
driver attivo
```

Il `Makefile.sun` della 1.10 costruisce:

```text
vif.o
```

e lo carica con:

```sh
modload vif.o -entry _vif_vdcmd -exec `pwd`/vif_exec
```

La funzione non è ancora parte del sistema operativo standard, ma diventa
molto più semplice da installare e rimuovere.

---

## 7. Il changelog è una piccola rete sociale tecnica

Il file `CHANGES` della versione 1.10 registra contributi provenienti da
persone e organizzazioni diverse.

Nel luglio 1995 troviamo:

```text
correzione degli argomenti modload
→ Suresh Khatry

port Ultrix
→ Phil Brandenberger

fix ARP HP-UX
→ Steve Taylor

correzione di un kernel mbuf leak
→ Dieter Dworkin Muller
```

Il pacchetto cita anche un secondo port Ultrix disponibile via FTP.

Non esiste un'unica organizzazione che controlla questo percorso.

Il software evolve perché qualcuno:

```text
lo scarica
→ lo prova
→ trova un problema
→ lo modifica
→ rimanda la correzione
→ qualcun altro la integra
```

Il meccanismo è sorprendentemente familiare a chi oggi usa GitHub.

Mancano però quasi tutti gli strati di piattaforma che oggi consideriamo
normali: niente pull request, CI, package registry o issue tracker.

Ci sono posta elettronica, Usenet, FTP e file di testo.

---

## 8. Estate 1995: la funzionalità cambia ancora

Il `CHANGES` documenta:

```text
950327/Version 1.01
950731/Version 1.10
```

In pochi mesi il pacchetto riceve:

- fix;
- port verso altri Unix;
- documentazione aggiuntiva;
- correzioni di bug kernel;
- modalità di installazione più pratica.

È una forma di evoluzione software distribuita, con Internet che svolge allo
stesso tempo il ruolo di:

```text
forum tecnico
canale di distribuzione
archivio software
canale di feedback
rete professionale
```

---

## 9. Da Internet a Xpert, da Xpert a Internet Force

Il passaggio successivo non è documentato nei messaggi del pacchetto, ma è
parte della memoria diretta dell'archivio Internet Force.

Durante il lavoro con **Xpert UNIX Systems** in Israele, **Yahel Ben-David**
fornì il bundle VIF a Marco Iannacone per risolvere il problema operativo del
virtual hosting sulle Sun Internet Force.

La catena completa può quindi essere rappresentata così:

```text
ricerca accademica
John Ioannidis
SIGCOMM 1991
      │
      ▼
Usenet / mailing list
1992
      │
      ▼
codice sorgente + spiegazione
      │
      ▼
Chuck Smoko
adattamenti SunOS 4.1.x
1994
      │
      ▼
Bob Baggerman
forward / raccolta del materiale
1994
      │
      ▼
Steinar Haug
modulo caricabile, port, fix, README
1995
      │
      ▼
Yahel Ben-David / Xpert
      │
      ▼
Marco Iannacone / Internetforce
1995
      │
      ▼
SunOS 4.1.4 in produzione
```

È difficile trovare un reperto che mostri meglio come circolava la conoscenza
tecnica su Internet prima del Web moderno.

---

## 10. E poi il sistema operativo assorbe la funzione

Il README della versione 1.10 contiene un'altra informazione notevole:

```text
Solaris 2.x: You don't need vif,
since the operating system already has the necessary functionality.
```

La sintassi riportata è:

```sh
ifconfig IF:N ip-address up
```

Ma il README aggiunge una precisazione:

```text
not supported by Sun
not mentioned in the man pages
```

Quindi la situazione diventa:

```text
SunOS 4.1.x
→ serve un'estensione kernel esterna

Solaris 2.x
→ la funzione esiste già nel sistema operativo
  ma inizialmente è poco documentata / non supportata
```

Questo non dimostra che Sun abbia preso il codice VIF o che VIF abbia causato
l'implementazione di Solaris.

Sarebbe una conclusione che il reperto non supporta.

Dimostra però qualcosa di altrettanto interessante: **una necessità tecnica che
gli utenti Unix avevano risolto autonomamente con codice di rete compare poco
dopo come funzionalità disponibile nel sistema operativo successivo**.

---

## 11. "Evoluzione dell'OS" significava anche evoluzione dell'OS realmente usato

Quando diciamo che un sistema operativo "evolve", oggi pensiamo soprattutto a:

```text
nuova release del vendor
→ update
→ nuova funzione
```

Nell'ecosistema Unix degli anni Novanta c'era anche un altro livello.

Il sistema operativo installato in produzione poteva diventare qualcosa di
diverso dalla distribuzione originale attraverso:

```text
driver
patch
daemon
utility
moduli kernel
script
```

scritti altrove e recuperati dalla rete.

Nel nostro caso:

```text
SunOS 4.1.4 originale
        +
VIF
        =
SunOS capace di gestire gli IP virtuali
necessari all'hosting Internetforce
```

Questa è un'affermazione più precisa del dire che "SunOS era open source".

Non lo era.

Ma **l'ambiente Unix operativo poteva essere esteso dall'esterno**, e la rete
era il mezzo attraverso cui il codice e le competenze necessarie si
propagavano.

---

## 12. Internet costruiva Internet

VIF chiude quasi un piccolo circuito storico.

Internet Force aveva bisogno di una funzione per costruire un servizio
Internet.

La soluzione era nata dalla ricerca sulle reti, era stata discussa su Internet,
distribuita via FTP, modificata da persone collegate attraverso Internet e
infine utilizzata per permettere a un ISP di pubblicare più siti su Internet.

```text
Internet
   ↓
diffonde conoscenza e codice
   ↓
estende Unix
   ↓
permette di costruire un ISP
   ↓
che offre nuovi servizi Internet
```

Il repository Internet Force conserva quindi non solo **la configurazione di un
ISP**, ma anche un esempio concreto del modello collaborativo attraverso il
quale una parte dell'infrastruttura Internet dell'epoca veniva costruita.
