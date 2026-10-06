🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# Script operativi

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../LICENSE)

Si tratta degli script e delle note procedurali (create da Xpert o da Marco) che gestivano il servizio giorno per giorno.

| File | Scopo |
|---|---|
| `adduser` | Creare un account cliente, home, jail e quota. |
| `backup_su_nastro.sh` | Backup completo su nastro di tutti gli host. |
| `expire.pl` | Elaborazione di scadenza account/avvisi per l'area di login web. |
| `create.m-list.index.sh` | Rigenerare gli indici delle mailing list. |
| `MakeDNS.txt` | Note sulla procedura di generazione delle zone DNS. |
| `system.modification-after_OSINSTALLATION.txt` | Checklist delle modifiche applicate a un nuovo server SunOS. |
| `log-files._archive-HOWTO.txt` | Procedura di archiviazione dei log. |
| `IP_ADDRESS_NOTI_DEBUG.txt` | Note sull'allocazione/notifica degli indirizzi IP. |
| `user_rename.txt` | Procedura per rinominare un account. |
| `email_to_all.txt` | Procedura di posta massiva. |
| `automatic_mirror-HOWTO.txt` | Mirroring pianificato di un sito web esterno. |
| `crontab_users_data.txt` | I job `cron` di root su USERS e DATA: pulizia dei file `.nfs*`, `newsyslog`, statistiche web, mirroring (**originale**). |

Questi sono **ORIGINALI SANITIZZATI** (password e credenziali di posta
sostituite), con l'eccezione di `crontab_users_data.txt`, che è un
**ORIGINALE** recuperato senza credenziali. La logica operativa è invariata.
Supportano [Provisioning dei clienti](../../docs/12-customer-provisioning.md) e
[Operazioni e backup](../../docs/14-operations-and-backup.md).
