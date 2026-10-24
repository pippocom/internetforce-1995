🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# Welcome Kit cliente

> **Internet Force 1995--1996 Historical Archive**\
> Ricostruzione e documentazione tecnica basate sui materiali originali
> Internet Force conservati da **Marco Iannacone**.\
> Autore e curatore dell'archivio: **Marco Iannacone** ·
> https://pippo.com\
> Licenza: [CC BY 4.0](../../LICENSE), con l'eccezione per il software
> di terze parti contenuto nel Welcome Kit descritta nella licenza del
> progetto.

Questa directory riunisce i materiali originali del **Welcome Kit Internet
Force**: il kit di collegamento distribuito ai clienti, composto da 4 floppy,
il manuale, i sorgenti dell'applicazione e del programma di installazione e le
fotografie del packaging originale della versione 1.0.

## Struttura

| Percorso | Contenuto |
|---|---|
| `floppy-images/` | le quattro immagini dei dischetti del Welcome Kit, il disco Windows 95 e `LEGGIMI.TXT` |
| `manual/` | `MANUALE_UTENTE_INTERNETFORCE.PDF`, 33 pagine, prodotto il 18 marzo 1996 con Acrobat Distiller 1.0 per Macintosh; qui è presente anche un esempio reale di istruzioni di configurazione **Trumpet Winsock** per un cliente (`trumpet_config-HOWTO_for_maoz.doc`) |
| `source/` | i sorgenti dell'applicazione (Visual Basic) e i materiali di sviluppo del programma di installazione |
| `packaging/` | fotografie del **packaging originale Welcome Kit v1.0**, della confezione, del manuale e dei floppy fisici; materiale conservato e fornito nel 2026 da **Pascal Schait**, socio fondatore di Internet Force |

## Supporti originali

Le immagini `DISK1.IMA`--`DISK4.IMA` sono i supporti originali del
Welcome Kit. `WIN95.IMA` conserva il supporto aggiuntivo per Windows 95.
Sono immagini FAT12 storiche e vengono mantenute senza modifiche.

## Packaging originale v1.0

Il PDF [`packaging/internet-force-welcome-kit-v1.0-packaging.pdf`](packaging/internet-force-welcome-kit-v1.0-packaging.pdf)
conserva fotografie della confezione fisica del Welcome Kit versione 1.0. Si
vedono la scatola con il marchio Internet Force, il sigillo, il manuale e i
floppy originali etichettati **WELCOME-KIT versione 1.0**.

Le fotografie completano le immagini digitali dei dischetti mostrando come il
kit veniva realmente consegnato a un nuovo cliente: non soltanto software e
configurazione, ma un prodotto fisico pensato per accompagnare una persona nel
primo collegamento a Internet. Le immagini sono state conservate e fornite nel
2026 da **Pascal Schait**, socio fondatore di Internet Force.

## Sviluppo e sorgenti

Il Welcome Kit fu sviluppato da **Marco Iannacone** per Internet Force come
**attività di consulenza aggiuntiva** rispetto al suo incarico ordinario di
system/network administrator. Prima di quel progetto Marco non aveva usato
**Visual Basic**: lo imparò specificamente per realizzare il Welcome Kit.

La directory [`source/`](source/README.md) conserva i sorgenti
dell'applicazione - fra cui i file `.FRM`, `.FRX`, `.BAS` e `.MAK` di Easy! e
del programma di installazione - e i materiali relativi agli installer, con
alcune versioni precedenti raccolte in `source/OLD_VER2/`. Offre quindi anche
uno spaccato concreto di come veniva sviluppata e distribuita una piccola
applicazione Windows/Visual Basic negli anni '90.

## Easy!

Il programma venne chiamato **Easy!** ed era stato progettato e realizzato da
 **Marco Iannacone** come indicato nei file, con grafica realizzata da Salvatore.
 Easy! forniva ai clienti Internet Force un'interfaccia/launcher per gli strumenti Internet
installati dal Welcome Kit.

I sorgenti conservano anche il programma di setup, che gestiva
l'installazione multi-disco, la creazione delle directory, la
decompressione dei payload e la creazione del gruppo Internet Force nel
Program Manager di Windows.

File con estensioni come `.EX_`, `.DL_` e `.HL_` possono essere file
compressi nel formato Microsoft usato dai sistemi di installazione
dell'epoca. Per esempio `EUDORA.EX_` contiene un header SZDD e non
rappresenta un eseguibile mancante.

## Software di terze parti

Il Welcome Kit contiene software di terze parti dell'epoca tra cui Netscape ed Eudora.
La sua conservazione come materiale storico non trasferisce tali componenti sotto
CC BY 4.0: restano applicabili i copyright e le licenze originarie dei
rispettivi autori.
