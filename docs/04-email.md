🇮🇹 **Italiano** · [🇬🇧 English](04-email.en.md)

# Posta elettronica

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

Internet Force gestiva una piattaforma di posta UNIX convenzionale per i propri
clienti. Il mail host era **USERS** (`206.20.95.4`), con **DATA**
(`206.20.95.3`) come mail exchanger secondario. Entrambi eseguivano **Sendmail
8.6.12**, compilato nel settembre 1995.

## Trasporto

`internetforce.com` pubblicava due record MX: USERS con preferenza 0 e DATA con
preferenza 1. La posta Internet in ingresso arrivava quindi prima a USERS.
Sendmail faceva relay e consegnava la posta localmente; non c'era uno smarthost
davanti, così i server parlavano SMTP direttamente con il resto di Internet.

La posta era consegnata alla mailbox locale con `mail.local`, e gli alias noti
(`postmaster`, `webmaster`, `hostmaster`, `dnsmaster`, `staff`, `sales`,
`marketing`, `info`, `help`, `register`, `helpdesk`, `popserv`, `compserv`)
espandevano alle persone o agli account di ruolo appropriati. Le modifiche agli
alias a livello di sito si facevano modificando `/etc/aliases` e ricostruendo
il database degli alias.

## Accesso alla mailbox dei clienti

I clienti leggevano la posta con uno dei due protocolli installati su USERS:

- **POP3** — il server Berkeley `popper` (versione 1.6), avviato da `inetd`.
  Poiché Internet Force usava un modello di accesso per utente, la maildrop era
  il file `.mailbox` del cliente nella home directory invece dello spool di
  sistema.
- **IMAP** — `/usr/local/etc/imapd`, anch'esso avviato da `inetd`, che
  permetteva ai clienti di tenere la posta sul server e leggerla da più client.

Entrambi i servizi erano raggiungibili dai clienti sulla loro connessione
dial-up. I client di posta standard dell'epoca (Pine, Eudora e simili) erano
supportati; Pine era preconfigurato per i nuovi account.

## Mailing list

Majordomo girava su DATA e forniva il servizio di mailing list. Gli alias
recuperati mostrano le liste `intf-list`, `coach`, `marketing-l` (con una
variante digest) e `cosmo-answer`, ciascuna con gli alias Majordomo standard per
iscrizione, approvazione, richieste e archivi. Le liste si gestivano con
comandi di posta ed erano controllate da password di lista; le procedure per lo
staff per aggiungere e rimuovere iscritti e per approvare le richieste di
iscrizione sopravvivono nelle note di formazione recuperate. Vedi
[Web, FTP, news e mailing list](05-web-news-ftp.md) per il lato della gestione
delle liste.

## Leggere la posta in viaggio

Poiché la mailbox del cliente viveva sul server centrale USERS, la posta era
disponibile da qualsiasi POP: la mailbox non era legata a una particolare linea
dial-up, ma solo all'account.

## Configurazione rappresentativa

Dalla configurazione Sendmail recuperata su DATA
(`systems/data/mail/sendmail.cf.data`):

```text
DMinternetforce.com
DS
Msmtp,   P=[IPC], F=mDFMuX, S=11/31, R=21, E=\r\n
Mlocal,  P=/bin/mail, F=lsDFMrmn, S=10, R=20/40
```

`DMinternetforce.com` è il dominio locale; `Msmtp` consegna via rete, `Mlocal`
consegna nella mailbox locale (`.mailbox` nella home). `DS` vuoto significa
nessuno smarthost: i server parlavano SMTP direttamente.

→ Configurazione completa: [`systems/data/mail/sendmail.cf.data`](../systems/data/mail/sendmail.cf.data) ·
[`systems/users/mail/sendmail.cf.users`](../systems/users/mail/sendmail.cf.users)

---

Vedi anche: [Server USERS](../systems/users/README.md) · [DNS](03-dns.md) ·
[POP3 e accesso alla mailbox](18-pop3-and-mailbox-access.md)

---

→ [Costruire un Internet Force POP, passo per passo](00-build-an-isp.md)
