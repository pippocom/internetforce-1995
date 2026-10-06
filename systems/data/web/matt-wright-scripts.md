🇮🇹 **Italiano** · [🇬🇧 English](matt-wright-scripts.en.md)

# Script di Matt Wright (Matt's Script Archive)

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../LICENSE)

Questa pagina documenta gli script CGI di **Matt Wright** (Matt's Script Archive)
presenti nel materiale di backup recuperato, **senza ridistribuirne il
sorgente**. Fa da riferimento di dettaglio alla voce generale in
[Software CGI e web](cgi-and-web-software.md).

## Nota su licenza e ridistribuzione

I sorgenti originali degli script di Matt Wright recuperati nei backup non sono
redistribuiti in questo repository. I termini originali di distribuzione non
consentono di ripubblicarli qui. Questa pagina ne documenta quindi la presenza,
la funzione e l'uso storico, rimandando all'archivio ufficiale per il software.

In particolare, l'archivio recuperato `Matt.script.tot.tar.gz` (che contiene la
raccolta `total/`) resta nel materiale di lavoro privato del curatore e **non**
viene copiato nell'albero pubblico. Anche le copie individuali `rand_image` e
`ssi_image` - che fanno parte della stessa raccolta - non sono pubblicate.

## Inventario degli script recuperati

La raccolta recuperata `total/` comprende i seguenti script (nome e versione
come dichiarati dal `README` della raccolta). La funzione è descritta al livello
del nome/uso d'epoca; non si aggiungono dettagli implementativi non attestati.

| Script | Versione | Funzione | Uso locale Internet Force |
|---|---|---|---|
| Guestbook | 2.3.1 (29/10/1995) | Libro degli ospiti via CGI. | Non attestato nella raccolta pubblica; esiste una copia leggibile `guestbook.cgi` documentata in [Software CGI e web](cgi-and-web-software.md). |
| Free for All Link Page | 2.2 (17/07/1996) | Pagina di link gestita via CGI. | Nessuna evidenza di attivazione locale. |
| WWWBoard | 2.0 ALPHA 2 (25/11/1995) | Bacheca/discussioni via CGI. | Nessuna evidenza di attivazione locale. |
| FormMail | 1.5 (05/02/1996) | Inoltro via email del contenuto di un form. | Nessuna evidenza di attivazione locale. |
| Random Image Displayer | 1.2 (17/07/1995) | Immagine/banner casuale a ogni caricamento. | **Attestato**: configurato localmente come `advert.cgi` per i banner (vedi [Software CGI e web](cgi-and-web-software.md)). |
| SSI Random Image Displayer | 1.2 (04/11/1995) | Variante con Server Side Includes. | Nessuna evidenza di attivazione locale. |
| Random Link Generator | 1.0 (30/07/1995) | Link casuale. | Nessuna evidenza di attivazione locale. |
| Animation | 1.2 (21/11/1995) | Animazione lato server (server-push). | Nessuna evidenza di attivazione locale. |
| Countdown | 1.2.1 (08/10/1995) | Conto alla rovescia. | Nessuna evidenza di attivazione locale. |
| Counter | 1.1.1 (11/01/1996) | Contatore di accessi. | Nessuna evidenza di attivazione locale. |
| Simple Search | 1.0 (16/12/1995) | Ricerca semplice nel sito. | Nessuna evidenza di attivazione locale. |
| TextCounter | 1.2 (10/05/1996) | Contatore testuale. | Nessuna evidenza di attivazione locale. |
| Random Text | 1.0 (13/07/1996) | Testo casuale. | Nessuna evidenza di attivazione locale. |
| HTTP Cookie Library | 1.1.1 (15/07/1996) | Libreria Perl per i cookie HTTP. | Nessuna evidenza di attivazione locale. |
| TextClock | 1.0.2 (15/07/1996) | Orologio testuale. | Nessuna evidenza di attivazione locale. |
| Credit Card Verifier | 1.02 (01/07/1996) | Verifica del checksum dei numeri di carta. | Nessuna evidenza di attivazione locale. |
| Book 'em Dan-O | 1.01 (07/07/1996) | Utilità CGI della raccolta. | Nessuna evidenza di attivazione locale. |

## Uso nell'ambiente web/CGI di Internet Force

L'unico uso locale attestato con chiarezza nei reperti è il **Random Image
Displayer**, configurato come `advert.cgi` con `basedir =
http://www.internetforce.com/img_rand/` e un insieme di immagini locali; i
dettagli sono in [Software CGI e web](cgi-and-web-software.md). Gli altri script
della raccolta sono conservati come software d'epoca recuperato; non si afferma
un loro uso specifico senza evidenza.

## Archivio ufficiale

Il software è pubblicato dall'autore sul sito ufficiale **Matt's Script Archive**:

<https://www.scriptarchive.com/>

Le pagine per i singoli script sono disponibili su quel sito. La versione oggi
disponibile non è necessariamente identica a quella storica usata da Internet
Force.

---

Vedi anche: [Software CGI e web](cgi-and-web-software.md) ·
[Web, FTP, news e mailing list](../../../docs/05-web-news-ftp.md)
