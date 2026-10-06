🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# DVLP — host di sviluppo e build

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../LICENSE)

DVLP era la macchina dove software e configurazione erano compilati e testati prima di
essere installati ai server di produzione. Tenerla separata era una parte deliberata
del disegno di sicurezza.

![Scheda DVLP nella Systems Overview 1995](../../images/crops/dvlp.png)

*Ritaglio da [`images/internetforce_server_map.png`](../../images/internetforce_server_map.png) (Systems Overview 1995).*

## Piattaforma

- Sun SPARCstation 4, SunOS 4.1.4, 32 MB di RAM.
- Indirizzo `206.20.95.130`, sulla LAN dell'ufficio. **Non** era su un segmento
  firewall dedicato e **non** era l'host SHELL pianificato.
- Un lettore CD-ROM e un disco SCSI; l'unità a nastro usata per i backup era
  collegata qui.

## Ruolo

DVLP era la macchina di build e staging:

- sorgenti e software erano ottenuti dai siti Internet/FTP dell'epoca e
  compilati localmente su DVLP;
- `/cisco` conservava le configurazioni dei router;
- il contenuto web era testato qui prima del rilascio a USERS o DATA;
- solo i componenti runtime necessari erano trasferiti in produzione.

I server di produzione tenevano quindi un insieme minimo di software -
compilatori e strumenti di sviluppo restavano su DVLP.

## Trasferimento e accesso

Software e file si spostavano verso gli host di produzione sul servizio FTP
interno nella prima fase, con **SSH/SCP** aggiunti nel 1996 come sostituti
sicuri. Il servizio FTP di DVLP era ristretto alla rete dell'ufficio.

## Configurazioni dei router

La directory `/cisco` di DVLP è dove erano conservate le configurazioni Cisco.
Le copie canoniche pubblicate stanno con i sistemi pertinenti -
[l'uplink](../cisco-2501-uplink/README.md) e i [POP](../pops/README.md) - così
il repository tiene una sola sede per ogni configurazione.

## Backup su nastro (DAT)

DVLP era anche il punto operativo dei backup. A DVLP era collegata l'unità
**DAT** usata per le copie su nastro dei sistemi centrali (`/dev/rst0`, oppure
`/dev/nrst0` per accodare senza riavvolgere). Gli host di produzione - DATA,
USERS e FIREWALL - erano letti attraverso la rete interna e scritti sul nastro
da qui; per questo DVLP era anche `loghost` centrale.

La procedura completa (`gtar`/`dump`, ripristino, ordine di avvio) è in
[Operazioni e backup](../../docs/14-operations-and-backup.md); il quadro di
provenienza dei nastri e del recupero del 2026 è in
[Provenienza dell'archivio](../../docs/archive-provenance.md). Il ruolo DAT è
riassunto anche in [`BACKUP.md`](BACKUP.md).

I nastri operativi appartenevano a Internet Force e rimasero all'azienda. Una
cassetta separata, contenente una copia della workstation `marco`, fu invece
conservata da Marco e recuperata nel 2026 con un drive DAT compatibile;
purtroppo solo una parte degli archivi Sun recuperati è risultata parzialmente leggibile.

## Servizi e configurazione

| Servizio / ruolo | Descrizione | Configurazione / evidenza | Documentazione |
|---|---|---|---|
| Host di sviluppo e build | Preparazione e compilazione del software prima della produzione. | *descrizione nel README* | [Sviluppo](../../docs/07-development.md) |
| Compilatori e ambiente di build | Toolchain mantenuta fuori dai server di produzione. | *nessuna configurazione recuperata* | [Sviluppo](../../docs/07-development.md) · [Inventario software](../../docs/11-software-inventory.md) |
| Perl e strumenti di supporto | Script operativi e di provisioning. | [`../../artifacts/scripts/expire.pl`](../../artifacts/scripts/expire.pl) · [`../../artifacts/scripts/`](../../artifacts/scripts/README.md) · [`../../artifacts/tools/`](../../artifacts/tools/README.md) | [Sviluppo](../../docs/07-development.md) |
| Codice sorgente locale | Area di sviluppo generale su `/cisco` e dintorni. | *nessun archivio di sorgenti pubblicato* | [Sviluppo](../../docs/07-development.md) |
| Strumenti di configurazione router | Conservazione delle configurazioni Cisco e procedura per un nuovo POP. | [`../pops/CISCO-add_new_pop-HOWTO.txt`](../pops/CISCO-add_new_pop-HOWTO.txt) · [`../pops/`](../pops/README.md) | [Router e WAN](../../docs/16-router-and-wan.md) |
| Deployment e modifiche di sistema | Modifiche preparate qui e applicate agli host di produzione. | [`../../artifacts/scripts/system.modification-after_OSINSTALLATION.txt`](../../artifacts/scripts/system.modification-after_OSINSTALLATION.txt) | [Sviluppo](../../docs/07-development.md) |
| Backup su nastro (DAT) e `loghost` | Punto operativo dei backup dei sistemi centrali. | [`BACKUP.md`](BACKUP.md) | [Operazioni e backup](../../docs/14-operations-and-backup.md) |

> Nota storica: DVLP era l'host Sun di sviluppo/build; la workstation Linux
> `marco` serviva a sperimentazione, amministrazione e test. **Non faceva parte
> del flusso operativo una cross-compilazione Linux → SunOS.**

## Strumenti Unix e di sicurezza storici

In questa area sono conservati due pacchetti di terze parti recuperati,
dall'ambiente Unix/SunOS:

| Software | Versione | File | Ruolo |
|---|---|---|---|
| chrootuid | 1.2 | [chrootuid1.2.shar.Z](chrootuid1.2.shar.Z) | Esegue un programma con un'identità utente ridotta e in un ambiente `chroot`. **L'archivio recuperato è di 0 byte: il contenuto non è sopravvissuto.** |
| COPS | ~1992, configurazione locale 1996 | [cops-perl.intf.tar.z](cops-perl.intf.tar.z) | Software di terze parti per la verifica della sicurezza Unix, in una installazione configurata localmente. |

**chrootuid 1.2** — il pacchetto serve a eseguire un servizio o un processo in un
ambiente ristretto (`chroot`) sotto un'identità utente specificata. Veniva
utilizzato sui users e data per tutti i servizi quali server web e ftp e per le
home degli utenti; L'archivio recuperato è comunque vuoto (0 byte), quindi il
suo contenuto non è disponibile.

**COPS** — COPS (Computer Oracle and Password System) è software di terze parti
di auditing della sicurezza Unix; **non** è stato sviluppato da Internet Force e
**non** faceva parte di Check Point FireWall-1. L'archivio rappresenta
un'installazione COPS configurata localmente e contiene anche configurazione
locale (`cops.cf`, `cops.cf.orig`). È software di terze parti con licenza
propria.

## Contenuti correlati in quest'area

- `build/` — area di build e gestione sorgenti (nessun file recuperato).
- [`BACKUP.md`](BACKUP.md) — DVLP e i backup su DAT (sintesi e link).

---

Vedi anche: [Sviluppo](../../docs/07-development.md) ·
[Operazioni e backup](../../docs/14-operations-and-backup.md) ·
[Provenienza dell'archivio](../../docs/archive-provenance.md)
