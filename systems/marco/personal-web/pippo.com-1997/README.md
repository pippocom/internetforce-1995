🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# pippo.com — snapshot Web del 1997

> **Internet Force 1995–1996 Historical Archive**\
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.\
> Autore e curatore dell’archivio: **Marco Iannacone** · https://pippo.com
> Licenza: [CC BY 4.0](../../../../LICENSE)

Questa directory conserva una copia offline di **pippo.com** ricostruita da catture della Wayback Machine del 1997.

Non è un dump del filesystem del server Internet Force: è uno **snapshot Web archiviato**, formato dalle risorse che Internet Archive riuscì a catturare. Il file [`snapshot/MANIFEST.tsv`](snapshot/MANIFEST.tsv) conserva per ogni elemento URL originale, timestamp di cattura, tipo MIME, stato, digest e URL archivio.

La cattura principale è dell'11 maggio 1997; alcune risorse hanno timestamp differenti, come normalmente accade in un mirror costruito a partire da un archivio Web.

## Un sito personale dentro l'ecosistema Internet Force

`pippo.com` era il dominio personale di Marco Iannacone e il sito era ospitato sull'infrastruttura Internet Force. La stessa home personale era inoltre raggiungibile tramite `/~ianna/` sui domini Internet Force:

```text
http://www.intf.com/~ianna/
http://www.internetforce.com/~ianna/
```

Lo snapshot conserva direttamente un collegamento alla prima forma; la seconda era quella utilizzata anche nella firma professionale dell'epoca. `intf.com` e `internetforce.com` erano entrambi domini attivi sullo stesso server.

Per questo lo snapshot viene conservato come artefatto autonomo anziché essere collocato fisicamente sotto `systems/marco/` o `systems/data/`: il contenuto è personale, ma il reperto documenta anche il servizio Web e l'hosting dell'ISP.

## Un piccolo campionario del Web 1995–1997

Nel codice sopravvivono molte tecniche caratteristiche dell'epoca:

- layout a **frame** e fallback `<NOFRAMES>`;
- pagine separate in italiano e inglese;
- JavaScript che scriveva messaggi scorrevoli nella **status bar** del browser;
- audio `.au`;
- form inviato a un programma **CGI**;
- contatore di visite CGI;
- orologio generato lato server;
- collegamento a un **Finger Gateway**;
- file ZIP scaricabili direttamente dal sito;
- immagini GIF usate come elementi di navigazione e grafica.

`index.html` conserva ancora il commento:

```html
<!-- Ianna's Home Page version 0.2 - 10/10/1995 -->
```

Lo snapshot del 1997 contiene quindi anche parti della struttura nata nel 1995.

## La GIF animata

[`snapshot/titolo.gif`](snapshot/titolo.gif) è la testata animata realizzata da Marco Iannacone.

Il file è una GIF **460×59 pixel composta da 8 frame**. Una testata animata costruita manualmente era, nel 1995–1996, uno degli strumenti con cui si cercava di introdurre movimento e identità grafica nelle pagine Web prima della disponibilità delle tecniche di animazione oggi comuni.

## Il contatore CGI

La barra inferiore della home contiene:

```html
Experimental page: accessed
<img src="http://www.pointest.com/cgi-bin/Count.cgi?df=marco.dat|dd=C&ft=0">
times, since 31-12-1995.
```

Il numero non è incorporato nell'HTML: veniva generato dinamicamente dal CGI e quindi non è stato preservato nello snapshot statico. Il contatore aveva superato circa **290.000 accessi**.

`pointest.com` non era un servizio Web scelto casualmente. Era il dominio associato al POP Internet Force di **Gorgonzola**. Marco Iannacone vi aveva installato il CGI di conteggio nell'ambito di una consulenza; nella configurazione iniziale anche `pointest.com` era ospitato sul server **DATA**.

Lo stesso host CGI veniva usato anche dal form di contatto:

```html
<form method="POST"
      action="http://www.pointest.com/cgi-bin/cgiemail/pippo/write.cgi">
```

e dal contatore della pagina Web di Hypertxt (`hyper.dat`).

## Altri legami con l'infrastruttura Internet Force

Lo snapshot conserva ulteriori riferimenti ai servizi dell'ISP:

```text
http://www.intf.com/tools/finger.query
```

per il Finger Gateway, e:

```text
http://www.intf.com/~ianna/
```

come URL della home personale.

Questi riferimenti rendono il sito utile non solo come reperto personale, ma anche come esempio concreto di come virtual hosting, home personali e CGI venissero combinati nell'infrastruttura Internet Force.

## Hypertxt nel sito del 1997

Lo snapshot comprende anche la pagina Web ufficiale di **MaISoft Hypertxt** e diversi pacchetti ZIP scaricabili.

Tre file presenti nello snapshot:

```text
hyper140.zip
hyper141.zip
hyper14b.zip
```

sono byte-per-byte identici e contengono un `FILE_ID.DIZ` che dichiara **Hypertxt 1.41**. Questo è un dettaglio storico importante: il nome `hyper14b.zip` era già in uso nel marzo 1997 come nome di download, ma nello snapshot conservato non contiene una release 1.44b.

La pagina `hypertxt/index.html` indica inoltre:

```text
Upload ultima versione: 2 Aprile 1997
```

e descrive la 1.41 come ultima release disponibile in quel momento.

Questi elementi vanno letti insieme agli altri materiali Hypertxt conservati nel repository, senza utilizzare il solo nome del file ZIP come prova della versione contenuta.

## Stato di conservazione

La directory [`snapshot/`](snapshot/) conserva le risorse così come recuperate dal mirror Wayback, senza modernizzare HTML, link, CGI o form.

I riferimenti a servizi dinamici oggi non più disponibili sono quindi lasciati intenzionalmente nel codice: sono parte del reperto storico.

Sono stati esclusi dal repository solo metadati locali creati dal filesystem del Mac usato per assemblare il pacchetto (`.DS_Store`, `__MACOSX`), che non appartengono al sito storico.

Vedere anche [`snapshot/MANIFEST.tsv`](snapshot/MANIFEST.tsv) per i metadati delle risorse recuperate (URL, timestamp, tipo/status e riferimenti all'archivio Web).
