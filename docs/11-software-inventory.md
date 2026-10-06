🇮🇹 **Italiano** · [🇬🇧 English](11-software-inventory.en.md)

# Inventario software

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

Questo è l'elenco software che sappiamo essere stato in uso presso
Internet Force, con le versioni salvate nell'archivio (quando le abbiamo ritrovate nei backup).
È organizzato per livello.

Una nota sulla terminologia: nel 1995 la locuzione "open source" non esisteva
ancora (anche se licenze GPL e MIT stavano diffondendosi), e i termini di distribuzione di questi pacchetti variavano.
Internet Force usava il modello UNIX/Internet di standard di protocollo pubblici
e software di rete liberamente distribuibile, scaricandolo e compilandolo
localmente.

## Sistemi operativi e firmware

| Software | Versione | Dove |
|---|---|---|
| SunOS | 4.1.4 | FIREWALL, DATA, USERS, DVLP |
| Linux (era Slackware) | — | workstation di Marco |
| Cisco IOS | 10.2 / 10.3 | router 1995 (uplink e POP iniziali) |
| Cisco IOS | 11.0 | POP 1996 (Tera, CNN, Fano, INDI) |

## Servizi di rete

| Software | Versione | Ruolo |
|---|---|---|
| Check Point FireWall-1 | 2.0a | firewall centrale |
| BIND / `named` | BIND 4 | DNS primario su DATA, secondario su USERS |
| `makezones` | 0.10 | generazione zone e bump del seriale |
| Sendmail | 8.6.12 | SMTP su DATA e USERS (build set 1995) |
| `mail.local` | SunOS | consegna locale della posta su USERS |
| Berkeley `popper` | 1.6 | servizio POP3 su USERS |
| `imapd` | — | servizio IMAP su USERS |
| Wu-ftpd | — | FTP anonimo su DATA |
| XTACACS (`xtacacsd`) | 3.4 (1995) | autenticazione dial-up centrale su USERS |
| Majordomo | — | servizio mailing list su DATA |
| `tcpd` (TCP wrappers) | Wietse Venema | controllo accessi/logging per i servizi `inetd` |
| tkined | 1.3.4 | gestione di rete SNMP |
| CERN httpd | 3.0 | proxy cache (1996) |

## Server web

| Software | Versione | Fase |
|---|---|---|
| NCSA HTTPd | 1.4 / 1.5 | lancio e prima operatività |
| Apache | 1.1 | successivo, dopo la migrazione |

La migrazione da NCSA HTTPd ad Apache avvenne nel 1996 (Apache stava assurgendo a diventare il server
web Unix di riferimento, proprio nel 1996); il materiale di riferimento Xpert recuperato include
una prima struttura di configurazione Apache.

## Sviluppo e operazioni

| Software | Ruolo |
|---|---|
| Compilatore C e strumenti di sviluppo | su DVLP (host di build) |
| Perl e interpreti UNIX | tooling su DVLP e sui server |
| GNU `tar` (`gtar`) | backup completi |
| `dump` | backup incrementali |
| `xntpd` | sincronizzazione dell'ora |
| `syslogd` | logging centralizzato verso `loghost` |
| `cron` | statistiche pianificate, rotazione log, mirroring |
| `webcopy` + script di mirror | mirroring pianificato di un sito esterno |
| Hypermail | archivi HTML delle mailing list |

## Software lato cliente

| Software | Versione | Note |
|---|---|---|
| Easy! | — | programmi e client Internet Force incluso nel Welcome Kit: un launcher/interfaccia per le applicazioni Internet; autore Marco Iannacone (documentato nel manuale del kit) |
| Trumpet Winsock | (kit) | stack TCP/IP Windows per dial-up, sui dischi del welcome kit |
| Eudora | — | client di posta incluso nel kit |
| Agent | — | client posta/news incluso nel kit |
| Netscape 2.0 | — Browser di riferimento incluso nel kit |
| Microsoft Internet Explorer | 2.0 | incluso nel disco Windows 95 (`IF-WIN95`) |
| Telnet, Talk, IRC, Archie, Ping, FTP | — | programmi client inclusi nel kit |

I programmi lato cliente erano distribuiti sui dischetti del
[Welcome Kit](../artifacts/customer-welcome-kit/README.md) così i clienti non
dovevano scaricarli su una linea dial-up lenta.

## Protocolli e servizi in uso

TCP/IP ovunque; PPP sulle linee dial-up; SMTP, POP3, IMAP, NNTP, HTTP, FTP, DNS,
TACACS, SNMP v1, NTP. Vedi le singole pagine di servizio per come ciascuno era
usato.

---

Vedi anche: [Sviluppo](07-development.md) · [DNS](03-dns.md) ·
[Posta elettronica](04-email.md) ·
[Web, FTP, news e mailing list](05-web-news-ftp.md)
