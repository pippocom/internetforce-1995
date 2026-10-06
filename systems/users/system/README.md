🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# Configurazione di sistema (USERS)

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../LICENSE)

La configurazione del sistema operativo di USERS, più la shell ristretta dei
clienti.

| Item | Descrizione |
|---|---|
| `inetd.conf`, `services`, `shells` | I servizi di rete offerti da USERS (telnet, ident, rsh/rlogin, FTP, finger, POP3, IMAP). |
| [`rc.route`](rc.route) | La tabella di routing applicata all'avvio: una rotta host per USERS e la rotta di default verso il firewall (**originale**). |
| [`rc.local`](rc.local) | Lo script di avvio del ruolo USERS: `xtacacsd`, l'accounting dial-up `xacctd_user` e gli HTTPd utente (**originale**). |
| [`fixperms`](../../firewall/system/fixperms) | Lo script di hardening dei permessi; era byte-identico su FIREWALL e USERS, quindi è pubblicata una sola copia di riferimento (**originale**). |
| [`ftpusers`](ftpusers) | La lista degli account esclusi dal login FTP; identica su FIREWALL, DATA e USERS (**originale**). |
| [`ftp-world.txt`](ftp-world.txt) | Nota operativa sul FTP guest/confinato (`guestgroup`, jail dello `segir`/`ftp-world`); **originale sanitizzato** — i dati personali del cliente sono stati rimossi, la struttura è invariata. |
| [`quota.txt`](quota.txt) | I profili di quota disco dei clienti e l'uso di `quotacheck` (**originale**). |
| `syslog.conf` | Configurazione di logging (logging centrale verso `loghost`). |
| `httpd/` | La configurazione NCSA HTTPd per il servizio web di USERS e le pagine personali. |
| `passwd.users-jan1995` | Il database degli account clienti (gennaio 1995), circa 765 account clienti più account di sistema (**originale sanitizzato**). |
| `restricted-shell.txt` | L'ambiente shell ristretto dei clienti e il modello degli account (**originale sanitizzato**). |

`rc.route`, `rc.local`, `fixperms`, `ftpusers` e `quota.txt` sono **ORIGINALI**
recuperati senza credenziali. `ftp-world.txt` è un **ORIGINALE SANITIZZATO**
(identificativi del cliente sostituiti). `inetd.conf`, `passwd.users-jan1995` e
`restricted-shell.txt` sono **ORIGINALI SANITIZZATI**. Il modello degli account
clienti è descritto in
[Provisioning dei clienti](../../../docs/12-customer-provisioning.md); quote e
FTP anche in
[Operazioni e backup](../../../docs/14-operations-and-backup.md). Gli hash
delle password sono sintetici ma mantengono il formato DES canonico, così i file
degli account restano leggibili come lo erano.
