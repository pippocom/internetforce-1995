🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# Configurazione di sistema (FIREWALL)

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../LICENSE)

| File | Descrizione |
|---|---|
| `passwd` | Il database degli account del FIREWALL (**originale sanitizzato**). |
| [`fixperms`](fixperms) | Lo script di hardening dei permessi (proprietà dei binari, rimozione dei bit setuid/setgid, protezione dei file di configurazione); era byte-identico su FIREWALL e USERS, quindi questa è la copia di riferimento pubblicata (**originale**). |

`passwd` è un **ORIGINALE SANITIZZATO**: nomi utente e struttura degli account
sono invariati; i campi password portano hash sintetici (gli account bloccati
mantengono `*`) e i campi nome sono sostituiti con "utente anonimizzato". L'host
firewall aveva i soliti account di servizio UNIX e nessun account cliente.
`fixperms` è un **ORIGINALE** recuperato senza credenziali; è discusso in
[Sicurezza](../../../docs/06-security.md). La lista `ftpusers`, identica su
FIREWALL, DATA e USERS, è pubblicata come copia di riferimento in
[`../users/system/ftpusers`](../../users/system/ftpusers).
