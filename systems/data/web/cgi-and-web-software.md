🇮🇹 **Italiano** · [🇬🇧 English](cgi-and-web-software.en.md)

# Software CGI e web usato da Internet Force

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../LICENSE)

Questa pagina documenta l'ecosistema di software CGI e utilità web usato sui
server Internet Force (in particolare DATA/USERS): cosa era usato, versione,
scopo, evidenza recuperata, eventuale configurazione o personalizzazione locale e
stato di ridistribuzione. I file leggibili recuperati sono in
[`systems/data/web/scripts/`](../../../systems/data/web/scripts/README.md).

## Inventario

| Software | Versione | Autore/fonte | Scopo in Internet Force | Evidenza recuperata | Configurazione/personalizzazione locale | Link upstream | Ridistribuzione |
|---|---|---|---|---|---|---|---|
| Random Image Displayer (`advert.cgi`) | 1.2 (1995) | Matt Wright — Matt's Script Archive | Banner immagine casuali per le pagine dei clienti | Copia locale configurata (privata) | `basedir = http://www.internetforce.com/img_rand/`; immagini `cosmopolitan.jpg`, `meazzi.jpg`, `per.jpg`; URL verso `www.intf.com/…` | <https://www.scriptarchive.com/> | **Non ridistribuito** (permesso richiesto) |
| Matt's Script Archive — collezione `total` | 1996 | Matt Wright | Raccolta di script CGI (counter, guestbook, wwwboard, `rand_image`, `ssi_image`, formmail, …) | Archivio `Matt.script.tot.tar.gz` (privato) | — | <https://www.scriptarchive.com/> | **Non ridistribuito** |
| `rand_image` | — | Matt Wright | Immagine casuale | Archivio `rand_image.tar.gz` (privato) | — | <https://www.scriptarchive.com/> | **Non ridistribuito** |
| `ssi_image` | — | Matt Wright | Immagine casuale via SSI | Archivio `ssi_image.tar.gz` (privato) | — | <https://www.scriptarchive.com/> | **Non ridistribuito** |
| `guestbook.cgi` | v2.20 | Terze parti | Libro degli ospiti | File leggibile `guestbook.cgi` | Configurazione upstream generica (`www.cs.uoregon.edu`), non Internet Force | — | Non CC BY; attribuzione conservata |
| `ssis.pl` | 1.1.3 (1995) | George Burgyan, Gabe Schaffer | Sostituto delle SSI | File leggibile `ssis.pl` | Copia di lavoro | — | Non CC BY |
| Script/template EFF/Selena Sol | 1995 | EFF / Selena Sol | Script e template web | Cartella `EFF/` | Materiale di esempio/upstream | — | Non CC BY |

## Note

- **Matt's Script Archive:** Internet Force ne usava in particolare il *Random
  Image Displayer*, configurato localmente per i propri banner. I termini di Matt
  Wright richiedono il permesso per la ridistribuzione del sorgente, quindi in
  questo repository **non viene pubblicato codice di Matt Wright**: se ne
  documentano soltanto l'uso e la configurazione. L'eventuale versione oggi
  disponibile su `scriptarchive.com` non è necessariamente identica a quella
  storica usata da Internet Force. L'elenco dettagliato degli script recuperati
  (nome, versione, funzione) e il contesto di licenza/ridistribuzione sono in
  [Script di Matt Wright](matt-wright-scripts.md).
- **Pointest (contatore e form):** lo snapshot del sito personale
  [`pippo.com` 1997](../../../systems/marco/personal-web/pippo.com-1997/README.md)
  conserva chiamate a un CGI di conteggio (`Count.cgi`) e a `cgiemail` servite da
  `pointest.com`; si veda anche il
  [POP di Gorgonzola](../../pops/gorgonzola/README.md).
- Nessuna password o credenziale è riprodotta in questa pagina.

---

Vedi anche: [Configurazione del server web](README.md) ·
[Web, FTP, news e mailing list](../../../docs/05-web-news-ftp.md) ·
[Script Web recuperati](../../../systems/data/web/scripts/README.md)
