🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# FTP pubblico (DATA)

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../LICENSE)

In questa directory erano ospitati i file e i dati del servizio FTP pubblico di
Internet Force.

La configurazione completa del servizio FTP non è sopravvissuta nel materiale
recuperato. Il funzionamento generale del servizio e il suo ruolo
nell'infrastruttura sono descritti in
[Web, FTP, news e mailing list](../../../docs/05-web-news-ftp.md). La porzione
di `inetd` che avviava l'FTP anonimo su DATA è conservata in
[`../system/inetd.conf`](../system/inetd.conf).

## Software storico conservato

| Software | Versione | File | Ruolo |
|---|---|---|---|
| wu-ftpd | 2.4.2 beta 11 | [wu-ftpd-2.4.2-beta-11.tar.Z](wu-ftpd-2.4.2-beta-11.tar.Z) | Demone FTP Unix: forniva il servizio FTP pubblico. |
| mirror | 2.3 | [mirror-2.3.tar.gz](mirror-2.3.tar.gz) | Software di mirroring/sincronizzazione FTP, usato per replicare o mantenere contenuti FTP rispecchiati. |

**wu-ftpd 2.4.2 beta 11** — `wu-ftpd-2.4.2-beta-11.tar.Z` è il pacchetto
upstream del demone FTP usato per il servizio FTP pubblico. Il `README` interno
al pacchetto riporta «RELEASE 2.4.2-BETA-10» mentre il nome del file riporta
`beta-11`; l'archivio conserva il pacchetto software storico così com'era. Il
repository non afferma che l'archivio contenga la configurazione Internet Force.

**mirror 2.3** — `mirror-2.3.tar.gz` è software di mirroring FTP. Nel materiale
recuperato non è documentato un rapporto di mirror specifico; il pacchetto è
conservato come software storico di terze parti.

Entrambi i pacchetti sono **software storico di terze parti**, ciascuno con la
propria licenza d'origine.

---

Vedi anche: [Web, FTP, news e mailing list](../../../docs/05-web-news-ftp.md) ·
[Configurazione di sistema (DATA)](../system/README.md)
