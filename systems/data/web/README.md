🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# Configurazione del server web (DATA)

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../LICENSE)

La configurazione NCSA HTTPd per DATA (`www1.intf.com` e gli host virtuali dei
clienti).

| File | Descrizione |
|---|---|
| `httpd.conf` | Configurazione principale del server: porta, server root, host virtuali. |
| `srm.conf` | Document root, alias, mappatura CGI, indicizzazione delle directory. |
| `access.conf` | Regole di accesso alle directory. |
| `mime.types` | Mappa dei tipi MIME. |

Questi sono **ORIGINALI SANITIZZATI**. Al lancio DATA eseguiva NCSA HTTPd; la
successiva migrazione ad Apache è descritta in
[Web, FTP, news e mailing list](../../../docs/05-web-news-ftp.md).

## Software storico conservato

| Software | Versione | File | Ruolo |
|---|---|---|---|
| script-vari | raccolta | [script-vari.tar.z](script-vari.tar.z) | Raccolta storica di strumenti Web/CGI di vari autori (ftpmail, analog, curl, guestbook.cgi, …). Il ruolo locale esatto non è stabilito dalla documentazione sopravvissuta. |
| Script CGI recuperati | — | [`scripts/`](scripts/README.md) | File Web/CGI recuperati (guestbook, SSI, EFF/Selena Sol, log di trasferimento). |

Gli script CGI di **Matt Wright** usati nell'ambiente web sono documentati a
parte, **senza ridistribuire i sorgenti**, in
[Script di Matt Wright](matt-wright-scripts.md).

---

Vedi anche: [Software CGI e web](cgi-and-web-software.md) ·
[Script Web recuperati](../../../systems/data/web/scripts/README.md)
