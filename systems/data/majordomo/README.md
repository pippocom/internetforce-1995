🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# Liste di distribuzione (Majordomo) — DATA

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../LICENSE)

Majordomo girava su DATA e gestiva le mailing list di Internet Force. In questa
directory è conservato il software storico recuperato, insieme al materiale
operativo specifico dell'ISP.

## Software storico conservato

| Software | Versione | File | Ruolo |
|---|---|---|---|
| Majordomo | 1.92 | [Majordomo.tar.z](Majordomo.tar.z) | Gestione delle liste di distribuzione. |
| Hypermail | 1.02 | [hypermail.102.tar](hypermail.102.tar) | Conversione degli archivi delle liste in pagine HTML. |

**Majordomo 1.92** — `Majordomo.tar.z` è il pacchetto upstream del gestore di
mailing list. Il file interno `majordomo_version.pl` dichiara la versione
`1.92`. L'archivio recuperato contiene anche la **configurazione locale delle
liste di Internet Force** (`lists/intf-list`, `lists/coach`,
`lists/cosmo-answer`, `lists/marketing-l` e `digests/marketing-l-digest`) e
materiale operativo in `dati-utili/` e `archives/`. Il materiale operativo
specifico dell'ISP è in [`coach.txt`](coach.txt) (template di iscrizione alla
lista `Coach`) e [`HOWTO-create.m-list.txt`](HOWTO-create.m-list.txt) (ricetta
operativa che invoca Hypermail per l'archivio `cosmo-answer`), e in
[Liste di distribuzione](../../../docs/20-mailing-lists-majordomo.md).

**Hypermail 1.02** — `hypermail.102.tar` è il software che trasformava gli
archivi delle liste di posta in pagine HTML consultabili dal Web; era il passo
finale del flusso di archiviazione delle liste descritto in
[`HOWTO-create.m-list.txt`](HOWTO-create.m-list.txt). Non è un componente
generico del server web.

Entrambi i pacchetti sono **software storico di terze parti**, ciascuno con la
propria licenza d'origine.

---

Vedi anche: [Liste di distribuzione](../../../docs/20-mailing-lists-majordomo.md) ·
[Server DATA](../README.md)
