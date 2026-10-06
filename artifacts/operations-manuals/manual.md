🇮🇹 **Italiano** · [🇬🇧 English](manual.en.md)

# Manuale del sito di riferimento Internet Force per sysad junior
# Autore: Marco Iannacone

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../LICENSE)

*Fuso e riorganizzato dalle bozze del manuale recuperate (`document.glob.txt`,
`document.software.txt`, `GENERAL_SITE-SETUP-INFO.txt`, `document.hardware.txt`).
Credenziali rimosse; passaggi duplicati accorpati. Questa è una ricostruzione
di Marco.*

## Indice

1. Introduzione
2. Configurazione dei sistemi
3. Hardware di comunicazione
4. Topologia di rete
5. Server e servizi
6. Gestione del sito e attività di routine
7. FAQ operative Cisco
8. Informazioni sui POP

## 1. Introduzione

Questo manuale descrive i server, i router e le procedure di routine della
piattaforma Internet Force: FIREWALL, DVLP, DATA e USERS, i router e i terminal
server dei POP, e i servizi che forniscono. È il riferimento operativo per
l'amministratore di sistema.

## 2. Configurazione dei sistemi

### FIREWALL
- Sun SPARCstation 5, 32 MB, SunOS 4.1.4.
- Cinque interfacce Ethernet: `qe3` world (10.0.0.1), `qe0` DATA (206.20.95.10),
  `qe1` USERS (206.20.95.11), `qe2` SHELL (206.20.95.12), `le0` office
  (206.20.95.129).
- Check Point FireWall-1, amministrato dall'ufficio tramite X11.

### DVLP
- Sun SPARCstation 4, 32 MB, SunOS 4.1.4.
- Host di build/sviluppo sulla LAN dell'ufficio. `/cisco` conserva le
  configurazioni dei router. L'unità a nastro per i backup è collegata qui.

### DATA
- Sun SPARCstation 5, 64 MB, SunOS 4.1.4.
- Disco di sistema più tre dischi SCSI da ~2 GB usati per NEWS, HTTP e capacità
  futura.

### USERS
- Sun SPARCstation 5, 64 MB, SunOS 4.1.4.
- Disco di sistema più dischi SCSI usati per gli account dei clienti e capacità
  futura, con quote.

## 3. Hardware di comunicazione

### Router
- Un Cisco 2501 centrale fornisce l'uplink Internet (IOS 10.2).
- Ogni POP remoto ha un router Cisco 2501 e un access server Cisco 2511. A
  Milano, dove centrale e POP coincidono, il 2501 centrale/world fa da router e
  non esiste un 2501 POP separato.
- Tutti i dispositivi eseguono SNMP e sono monitorati con tkined dalla
  workstation di Marco.

### Terminal server
- Gli access server portano i banchi modem. Le linee sono configurate per PPP,
  modalità interattiva, con un indirizzo cliente di default per linea e
  autenticazione TACACS centrale.

## 4. Topologia di rete

- Backbone privato `10.0.0.0/8`; il World Hub (`10.0.0.254`) unisce il 2501
  centrale, l'interfaccia world del firewall, i router dei POP e l'UPS.
- Server centrali su `206.20.95.0/26`, ciascuno dietro la propria interfaccia
  firewall.
- LAN dell'ufficio `206.20.95.128/25` dietro l'interfaccia office del firewall.
- Reti dial-up dei POP `206.20.115/224/225.0/24` (e in seguito `226`–`231`).

## 5. Server e servizi

### FIREWALL
- Check Point FireWall-1 con la policy recuperata di 15 regole (DNS e ident
  pubblici, accesso ai servizi web/posta dei server, TACACS dagli access server,
  amministrazione da DVLP e marco, il feed news, supporto Xpert e uno STOP
  finale).

### DVLP
- Host di sviluppo e build. Il software è compilato qui e distribuito in
  produzione. Le pagine web sono testate qui prima del rilascio. L'FTP è
  ristretto alla rete dell'ufficio.

### DATA
- Name server primario.
- Sito FTP anonimo (`/usr/local/ftp`, aree download e upload).
- Server mailing list Majordomo.
- Server news Usenet (alimentato dal provider upstream).
- Sito WWW e host virtuali dei clienti (VIF).

### USERS
- Name server secondario.
- Ambiente home dei clienti e pagine web personali.
- Sito FTP per utenti autenticati.
- SMTP, POP3 e IMAP.
- Server di autenticazione XTACACS.

## 6. Gestione del sito e attività di routine

### Backup
I backup completi usano GNU `tar` verso il nastro su DVLP; DATA, USERS e
FIREWALL sono letti attraverso la rete interna. I backup incrementali usano
`dump`. Il nastro è controllato prima con `df`, così i supporti rimovibili non
vengono catturati.

### Avvio e spegnimento dei sistemi
Ordine di avvio: FIREWALL, DATA, USERS, poi DVLP e MARCO. Lo spegnimento è con
`shutdown`; i sistemi non vengono mai spenti direttamente.

### Gestione utenti
Gli account si creano con lo script `adduser`, che alloca un UID, costruisce
l'ambiente home nel jail, aggiunge l'account reale e applica una quota. La
rimozione degli account e il reset delle password seguono lo stesso modello.

### Gestione quote
I filesystem dei clienti (`sd1c`, `sd2c`) applicano quote di blocchi e inode,
impostate con `edquota` e controllate con `quotacheck`.

### Gestione del sito HTML
Le pagine si modificano, si caricano su DVLP per il test, poi si rilasciano su
USERS (pagine personali) o DATA (siti clienti/virtuali).

### Gestione del sito FTP
L'area anonima su DATA è solo download in `/pub` e solo upload nella directory
di upload; i permessi seguono le classiche regole dell'FTP anonimo.

### Gestione Majordomo
Le mailing list su DATA si gestiscono con comando di posta, con approvazione
delle iscrizioni e archivi HTML.

## 7. FAQ operative Cisco

**Aggiungere e configurare un nuovo POP.** Copiare le configurazioni collaudate
2511 e 2501, dare loro il nome del nuovo POP, eseguire il dialogo di setup,
impostare i bit di sottorete (17 per il 2501, 18 per il 2511), poi `write mem`.
Collegare il 2501 al World Hub e caricarne la configurazione dalla directory di
staging TFTP.

**Cambiare un singolo parametro di linea.** Telnet al router, `conf t`,
selezionare la linea, cambiare il parametro, `write mem`.

**Cancellare una configurazione.** `write erase`, poi `reload` - pericoloso.

**Raggiungere il modem/terminal server.** Inizialmente con telnet all'indirizzo
dell'access server sulla porta 16; il disegno finale dà a ogni router una
connessione Ethernet.

**Accesso alla console.** Usare `kermit` su SunOS o `minicom` su Linux a
9600 bit/s.

**Salvare una configurazione.** `write net`, poi indicare l'host di staging e il
nome del file.

## 8. Informazioni sui POP

Numeri dial-in: vedi
[Accesso telefonico ai POP](../../systems/pops/telephone-numbers.md).
