🇮🇹 **Italiano** · [🇬🇧 English](archive-provenance.en.md)

# Provenienza dell’archivio e recupero dei materiali

> **Internet Force 1995–1996 Historical Archive**\
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.\
> Autore e curatore dell’archivio: **Marco Iannacone** · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

Il repository non deriva da un singolo backup completo dell’infrastruttura Internet Force. È stato ricostruito da Marco a partire da materiali sopravvissuti in luoghi diversi e recuperati progressivamente.

Questa provenienza spiega perché alcuni insiemi di file sono molto completi mentre altri sono frammentari.

## I backup operativi di Internet Force

Internet Force utilizzava un’unità DAT collegata al server **DVLP** per i backup su nastro dei sistemi. I nastri impiegati per queste procedure erano proprietà dell’azienda e rimasero a Internet Force; non fanno parte dell’archivio oggi disponibile.

La documentazione recuperata conserva comunque tracce delle procedure stesse, compresi riferimenti a `gtar`, `dump` e all’uso di DVLP come punto operativo per le copie su nastro.

## La cassetta DAT “rimasta”

Mi era invece "rimasta" una singola cassetta DAT sulla quale, all'epoca, avevo effettuato una copia della workstation **`marco`**; la cassetta è sopravvissuta per quasi trent'anni. Il nastro originale era stato scritto con un’unità DAT Sun collegata via SCSI a **DVLP**, il sistema SunOS usato per i backup.

Nel 2026 ho letto la cassetta con un drive DAT USB che avevo noleggiato, collegato a una macchina Linux. Ho estratto il contenuto con `tar`, usando anche `gzip` dove occorreva identificare o verificare la compressione. Il recupero ha restituito numerosi materiali aggiuntivi: copie di configurazioni, documentazione, posta, sorgenti, utility e file personali di lavoro che non erano presenti nel primo insieme di backup già disponibile.

Per i dettagli tecnici sulla scelta del drive DDS, sull'uso storico di **GNU tar** su SunOS, sul blocking dei record e sulla lettura del nastro da Linux, vedere [Recuperare nel 2026 un DAT DDS-1 scritto nell'ambiente SunOS](dat-tape-recovery.md).

## Recupero incompleto

Parte del contenuto del DAT consiste in archivi `tar` creati dalla macchina Sun **DVLP** o comunque transitati attraverso quell’ambiente.

I risultati del recupero sono stati misti: alcuni file sono stati estratti
normalmente, altri risultano a dimensione zero, altri ancora appaiono come
archivi `.tar.Z` che non è più stato possibile aprire; in alcuni casi il
materiale è emerso solo come frammenti binari o testuali danneggiati o con nomi
poco significativi.

Per interpretare questi frammenti — header, stringhe e possibili strutture dei
file — ho usato talvolta **DeepSeek** tramite **OpenCode** come ausilio.
L’interpretazione assistita dall’IA è servita a capire e identificare quanto
recuperato, a modificarne il formato per renderlo leggibile o a estrarre documenti parziali,
mai per fabbricare silenziosamente file storici mancanti.

La causa esatta non è stata ancora determinata: potrebbe dipendere dallo stato fisico del supporto, dalla modalità con cui i dati furono scritti, dalla variante/implementazione di `tar` utilizzata, da una parziale incompatibilità del DAT noleggiato, o da una combinazione di questi fattori. Per questo il repository non attribuisce automaticamente il problema a una specifica incompatibilità software.

## Come interpretare le assenze

Una conseguenza importante è che:

> **l’assenza di un file dall’archivio recuperato non implica che quel file non sia mai esistito.**

In particolare, directory incomplete, file a zero byte e frammenti di alberi possono comunque conservare informazioni utili su nomi, struttura e workflow originali.

Dove serve, una nota può descrivere lo stato di un file - recuperato integralmente, solo in parte, troncato o illeggibile - per orientare il lettore. È una descrizione di che cosa è sopravvissuto, non del valore storico del documento.

## Materiali conservati da altre persone

L'archivio continua ad ampliarsi anche grazie a materiali originali conservati da persone che parteciparono a Internet Force. Nel 2026 **Pascal Schait**, socio fondatore e Technical Director della società, ha fornito diversi reperti:

- il **Listino Aziende del 15 giugno 1996**, che documenta l'offerta commerciale di connettività, IP statici e LAN, domini, DNS, realizzazione di pagine Web e hosting;
- fotografie del **packaging originale del Welcome Kit v1.0**, inclusi confezione, manuale e floppy fisici;
- una raccolta di **comunicati stampa contemporanei** di Internet Force, con alcune parti oscurate nella copia ricevuta;
- una **presentazione Net Way / Steve Maoz del 21 settembre 1995**, relativa alla fase di progettazione e avvio, anch'essa con alcune parti oscurate nella copia ricevuta;
- il **verbale dell'assemblea ordinaria del 24 settembre 1996**, relativo alla situazione patrimoniale, alle alternative di ricapitalizzazione/liquidazione e alla decisione di chiusura; nella copia ricevuta i nomi dei partecipanti e altre informazioni risultano oscurati.

I materiali sono conservati nelle aree:
[`artifacts/company/business-services-price-list-1996/`](../artifacts/company/business-services-price-list-1996/README.md),
[`artifacts/customer-welcome-kit/`](../artifacts/customer-welcome-kit/README.md),
[`artifacts/press/`](../artifacts/press/README.md),
[`artifacts/company/bp/`](../artifacts/company/bp/README.md) e
[`artifacts/company/bankruptcy-1996/`](../artifacts/company/bankruptcy-1996/README.md).

Le parti oscurate vengono conservate esattamente come ricevute: il repository
non tenta di ricostruire o inferire il testo censurato. Quando un'informazione
deriva invece dalla testimonianza diretta di Marco Iannacone, viene indicata
come tale e non attribuita al contenuto visibile del documento.

## Un archivio in evoluzione

Il recupero del DAT nel 2026 e l'emersione di altri materiali conservati dai protagonisti dell'epoca spiegano perché nuovi reperti continuino ad aggiungersi alla ricostruzione iniziale. Ogni nuovo elemento viene confrontato con le altre fonti e inserito nel repository con la propria provenienza.

Per le copie parziali dei sorgenti di Hypertxt presenti sulla workstation `marco`, vedere anche [Provenienza dei sorgenti Hypertxt](../systems/marco/hypertxt/PROVENANCE.md).

## L'articolo Codemotion e il repository

Nell'ottobre 2026 Marco Iannacone ha pubblicato su Codemotion l'articolo
[*Archeologia di un ISP: come funzionava davvero un Internet provider nel 1995*](../publications/codemotion-2026/README.md)
insieme al repository Internet Force 1995–1996 e ai dati della ricostruzione. L'articolo racconta il recupero dell'archivio e il funzionamento dell'infrastruttura; una copia digitale dell'edizione italiana è conservata nel repository insieme ai collegamenti alle edizioni Codemotion.

## Input della ricostruzione

Per questa ricostruzione ho riorganizzato nel repository materiale confluito da alcuni archivi di input; i wrapper originali non sono pubblicati. Ho redatto le guide tecniche confrontandole con i file del mio archivio di riferimento privato, che non è pubblicato.
