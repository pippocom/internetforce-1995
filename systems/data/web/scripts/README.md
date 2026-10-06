🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# Script Web recuperati (1995–1996)

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../../LICENSE)

Questa cartella contiene file Web/CGI sciolti recuperati dall'archivio di lavoro
storico. Sono conservati leggibili perché alcuni preservano configurazioni
specifiche di Internet Force o evidenza del flusso di sviluppo; questo **non**
significa che tutti siano stati scritti da Internet Force né che la CC BY 4.0 del
repository si applichi automaticamente a essi.

## File

### `advert.cgi` — non ridistribuito

Internet Force usava il **Random Image Displayer** di **Matt Wright** (Matt's
Script Archive) per i banner casuali dei propri siti: versione **1.2** (1995),
configurata su `www.internetforce.com/img_rand/` e `www.intf.com/...`. I termini
di Matt Wright richiedono il permesso per la ridistribuzione, quindi **il
sorgente upstream non è ridistribuito** in questo repository. L'uso storico e la
configurazione Internet Force sono documentati nell'inventario
[`systems/data/web/cgi-and-web-software.md`](../cgi-and-web-software.md).

### `guestbook.cgi` / `guestbook.doc`

Software guestbook di terze parti, conservato con la configurazione upstream
generica (`www.cs.uoregon.edu`), non una configurazione Internet Force.

### `ssis.pl`

Script SSI-substitute di terze parti di **George Burgyan** e **Gabe Schaffer**,
conservato come copia di lavoro con il contesto di authorship originale.

### `EFF/`

Copie di script e template Web EFF/Selena Sol, in gran parte materiale
upstream/di esempio. Il valore storico sta anche in `EFF/WS_FTP.LOG`, che
registra trasferimenti da `marco.intf.com:/home/ianna/eff` (30 settembre 1996),
documentando il flusso di lavoro della workstation.

## Licenza

Non esiste una licenza unica per questa cartella: ogni file mantiene
l'attribuzione dell'autore originale e **non** è relicenziato sotto CC BY 4.0.
Alcuni file possono richiedere il permesso dell'autore per la ridistribuzione.

---

Vedi anche: [Web, FTP, news e mailing list](../../../../docs/05-web-news-ftp.md) ·
[Sviluppo e DVLP](../../../../docs/07-development.md) ·
[Configurazione del server web](../README.md)
