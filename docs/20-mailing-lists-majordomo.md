🇮🇹 **Italiano** · [🇬🇧 English](20-mailing-lists-majordomo.en.md)

# Mailing list (Majordomo)

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

## Quale problema risolve

Oltre alle caselle personali, Internet Force offriva **mailing list** gestite:
iscrizione, approvazione, distribuzione ai membri e archivi consultabili. La
posta di una lista non è posta personale: richiede un agente che gestisca i
membri e ridistribuisca i messaggi.

## Come lo implementava Internet Force

**Majordomo** girava su **DATA** e forniva il servizio di mailing list. Si
integrava con **Sendmail** tramite alias di posta: ogni lista aveva gli alias
standard (posta alla lista, richieste, iscrizione, approvazione, archivio), e le
iscrizioni erano approvate **con comando inviato via posta** (non con un'interfaccia web).
Gli archivi delle liste erano convertiti in **HTML** con un flusso basato su
Hypermail.

Liste note dai reperti: **`intf-list`**, **`coach`**, **`marketing-l`** (con
edizione digest) e **`cosmo-answer`**.

## Componenti e host

- **DATA** — esecuzione di Majordomo e archivi delle liste.
- **Sendmail** — consegna e alias (vedi [Posta](04-email.md)).

## Evidenza rappresentativa

Il materiale recuperato documenta l'uso reale delle liste, ad esempio la richiesta
di iscrizione alla lista `coach` (`systems/data/majordomo/coach.txt`) e
la procedura per creare una lista
(`systems/data/majordomo/HOWTO-create.m-list.txt`).

→ Materiale completo: [`systems/data/majordomo/`](../systems/data/majordomo/README.md)
→ Indice degli archivi HTML: [`artifacts/scripts/create.m-list.index.sh`](../artifacts/scripts/create.m-list.index.sh)

### Esempio ricostruito (alias di lista)

Dai reperti sopravvivono i **nomi** delle liste e il modello di gestione, ma non
un file `aliases` completo. Il blocco seguente è quindi **RICOSTRUITO** e non è
un file recuperato; usa solo nomi di lista e il modello Majordomo documentati:

```text
# Esempio ricostruito
coach:              "|/usr/local/majordomo/wrapper resend -l coach coach-out"
coach-out:          :include:/usr/local/majordomo/lists/coach
coach-request:      "|/usr/local/majordomo/wrapper majordomo -l coach"
coach-approval:     owner-coach
owner-coach:        marco@intf.com
```

Il percorso `/usr/local/majordomo/` è esemplificativo: la posizione esatta
dell'installazione su DATA non è conservata.

## Come si collega al resto del POP

Majordomo dipende da Sendmail per la consegna; gli archivi HTML si appoggiano al
server web. Vedi [Posta](04-email.md) e
[Web, FTP, news e mailing list](05-web-news-ftp.md).

## Materiale originale correlato

- [`systems/data/majordomo/README.md`](../systems/data/majordomo/README.md)
- [`systems/data/README.md`](../systems/data/README.md) — il server DATA.
- [`artifacts/tools/digest.shar`](../artifacts/tools/digest.shar) — strumenti di digest.

---

← [Costruire un POP](00-build-an-isp.md) ·
Precedente: [FTP](05-web-news-ftp.md) ·
Prossimo: [Sicurezza](06-security.md) →
