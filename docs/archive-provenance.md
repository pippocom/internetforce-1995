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

All’autore è invece “rimasta” una singola cassetta DAT sulla quale, all’epoca, era stata effettuata una copia della workstation **`marco`**; la cassetta è sopravvissuta per quasi trent’anni. Il nastro originale era stato scritto con un’unità DAT Sun collegata via SCSI a **DVLP**, il sistema SunOS usato per i backup.

Nel 2026 è stata letta con un drive DAT USB noleggiato, collegato a una macchina Linux. Il contenuto è stato estratto con `tar`, usando anche `gzip` dove occorreva identificare o verificare la compressione. Il recupero ha restituito numerosi materiali aggiuntivi: copie di configurazioni, documentazione, posta, sorgenti, utility e file personali di lavoro che non erano presenti nel primo insieme di backup già disponibile.

## Recupero incompleto

Parte del contenuto del DAT consiste in archivi `tar` creati dalla macchina Sun **DVLP** o comunque transitati attraverso quell’ambiente.

I risultati del recupero sono stati misti: alcuni file sono stati estratti
normalmente, altri risultano a dimensione zero, altri ancora appaiono come
archivi `.tar.Z` che non è più stato possibile aprire; in alcuni casi il
materiale è emerso solo come frammenti binari o testuali danneggiati o con nomi
poco significativi.

Per interpretare questi frammenti - header, stringhe e possibili strutture dei
file - è stato talvolta usato come ausilio **DeepSeek** tramite **OpenCode**.
L’interpretazione assistita dall’IA è servita a capire e identificare quanto
recuperato, a modificarne il formato per renderlo leggibile o a estrarre documenti parziali,
mai per fabbricare silenziosamente file storici mancanti.

La causa esatta non è stata ancora determinata: potrebbe dipendere dallo stato fisico del supporto, dalla modalità con cui i dati furono scritti, dalla variante/implementazione di `tar` utilizzata, da una parziale incompatibilità del DAT noleggiato,  o da una combinazione di questi fattori. Per questo il repository non attribuisce automaticamente il problema a una specifica incompatibilità software.

## Come interpretare le assenze

Una conseguenza importante è che:

> **l’assenza di un file dall’archivio recuperato non implica che quel file non sia mai esistito.**

In particolare, directory incomplete, file a zero byte e frammenti di alberi possono comunque conservare informazioni utili su nomi, struttura e workflow originali.

Dove serve, una nota può descrivere lo stato di un file - recuperato integralmente, solo in parte, troncato o illeggibile - per orientare il lettore. È una descrizione di che cosa è sopravvissuto, non del valore storico del documento.

## Un archivio in evoluzione

Il recupero del DAT nel 2026 spiega perché nuovi reperti continuano ad aggiungersi alla ricostruzione iniziale. Ogni nuovo elemento viene confrontato con le altre fonti e inserito nel repository.

Per le copie parziali dei sorgenti di Hypertxt presenti sulla workstation `marco`, vedere anche [Provenienza dei sorgenti Hypertxt](../systems/marco/hypertxt/PROVENANCE.md).

## Input della ricostruzione

La ricostruzione ha riorganizzato in questo repository materiale confluito da alcuni archivi di input forniti dal curatore; i wrapper originali non sono pubblicati. Le guide tecniche sono state redatte confrontandole con i file dell’archivio di riferimento privato del curatore, che non è pubblicato.
