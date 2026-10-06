🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# Configurazione di sistema (DATA)

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../LICENSE)

| File | Descrizione |
|---|---|
| `passwd` | Il database degli account di DATA (**originale sanitizzato**). |
| [`rc.route`](rc.route) | La tabella di routing applicata all'avvio: una rotta host per DATA e una rotta di default verso il firewall (**originale**). |
| [`rc.local`](rc.local) | Lo script di avvio specifico del ruolo di DATA: i servizi avviati al boot, incluso il proxy cache e il web virtuale (**originale**). |
| [`inetd.conf`](inetd.conf) | Lo snapshot base di `inetd` più la porzione "DATA SERVER" con il servizio FTP anonimo (wu-ftpd) (**originale**). |

`rc.route`, `rc.local` e `inetd.conf` sono **ORIGINALI** recuperati: non
contengono credenziali. `inetd.conf.DATA` è la stessa porzione "DATA SERVER"
recuperata anche come file separato e per questo non è duplicata qui. Il
contenuto FTP è descritto anche in
[Web, FTP, news e mailing list](../../../docs/05-web-news-ftp.md).

`passwd` è un **ORIGINALE SANITIZZATO**: nomi utente e struttura degli account
sono invariati; i campi password portano hash sintetici (gli account bloccati
mantengono `*`) e i campi nome sono sostituiti con "utente anonimizzato". Gli
account di sistema di DATA erano i soliti account di servizio UNIX più gli
account di servizio web e FTP. La lista `ftpusers` era identica su FIREWALL,
DATA e USERS; la copia pubblica di riferimento è in
[`systems/users/system/ftpusers`](../../users/system/ftpusers).
