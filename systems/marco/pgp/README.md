🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# PGP sulla workstation `marco`

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../LICENSE)

Questa cartella conserva il public keyring PGP recuperato dalla workstation
`marco` e il package storico PGP 2.6.3i.

## Contesto

PGP faceva parte della pratica personale di sicurezza di **Marco Iannacone prima
di Internet Force** e continuò a essere usato durante Internet Force. Il public
keyring recuperato dalla workstation Linux `marco` conserva due chiavi pubbliche
personali create nel 1995:

```text
1995-09-17  RSA 768 bit   Marco Iannacone (ianna@iol.it)
1995-10-11  RSA 1024 bit  Marco Iannacone (ianna@internetforce.com>
```

Il primo user ID documenta l'uso di PGP con l'account **Italia On Line**,
precedente all'identità Internet Force; il secondo documenta una chiave associata
all'indirizzo Internet Force. L'user ID è conservato esattamente com'è nel keyring
storico, compresa l'anomalia della parentesi finale.

Successivamente fu aggiunta anche l'identità `pippo.com`, ma **questa copia del
keyring non la contiene**: il reperto documenta quindi uno snapshot precedente di
quell'evoluzione.

## Perché è rilevante

PGP non era un servizio Internet Force: era software personale sulla workstation
dell'amministratore, e il suo uso fu **continuativo** - iniziò prima di
Internet Force e proseguì durante Internet Force. Il keyring è conservato perché contiene **solo chiavi pubbliche**: una chiave
pubblica non è un segreto, e nessun secret keyring è incluso.

## Package PGP 2.6.3i

Il repository conserva anche il package storico **PGP 2.6.3i** (18 gennaio 1996,
basato su MIT PGP 2.6.2 e adattato per l'uso internazionale):
[`pgp263is.tar`](pgp263is.tar). Il pacchetto contiene i file `readme.1st`,
`readme.usa`, `setup.doc`, `pgp263ii.tar` e `pgp263ii.asc`. È **software storico
di terze parti**, con la propria licenza d'origine.

## File

- `PUBRING.PGP` — public keyring PGP originale recuperato (solo chiavi pubbliche).
- `KEYRING_METADATA.tsv` — estrazione moderna dei metadata delle chiavi.
- `pgp263is.tar` — package storico PGP 2.6.3i.

## Dove si colloca

PGP era parte dell'ambiente della workstation `marco`; vedi
[La workstation di Marco](../README.md),
[Sviluppo e DVLP](../../../docs/07-development.md) e
[Note storiche](../../../docs/09-historical-notes.md).
