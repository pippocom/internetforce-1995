🇮🇹 **Italiano** · [🇬🇧 English](12-customer-provisioning.en.md)

# Provisioning dei clienti

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

Aggiungere un cliente era un processo piccolo e governato da uno script. Gli strumenti
vivevano su USERS, dove stavano gli account dei clienti, le home directory e le
mailbox.

## Creazione di un account

Uno script di shell (`adduser`) creava l'account e il suo ambiente. Prendeva un
nome di login, un nome completo e una password cifrata, e poi:

1. **Allocava un UID** — il primo numero libero da 500 in su, nel gruppo 100.
2. **Creava la home directory** sotto `/users/01/<login>/home`, di proprietà del
   nuovo UID.
3. **Costruiva un ambiente ristretto** — una root "jail" in
   `/users/01/<login>` contenente un `etc/`, un `bin/` minimi e file scheletro
   copiati da un template condiviso, più una configurazione Pine (`.pinerc`)
   nella home directory.
4. **Creava un file password nel jail** dentro il jail dell'account, separato da
   `/etc/passwd` di sistema, così i programmi in esecuzione nell'ambiente
   ristretto vedevano una voce di login coerente.
5. **Aggiungeva l'account reale** a `/etc/passwd` con la home directory e la
   shell ristretta del cliente.
6. **Applicava una quota** copiando un template di quota (`edquota -p`).

La shell predefinita del cliente era la shell ristretta **`/bin/lynx`**, non una
shell generica. Questo dava ai clienti dial-up un ambiente controllato in cui
potevano leggere la posta, usare Lynx e accedere ai propri file, senza una shell
di sistema interattiva. Gli account di servizio e interni usavano altre shell
ristrette (per esempio `/bin/nosh`).

## Home directory e spazio web

Ogni home directory conteneva i file del cliente, il suo `.mailbox` (la
maildrop POP/IMAP) e, quando usava lo spazio web, una directory `public_html`
servita dal server web come pagine personali. È lo stesso meccanismo
`UserDir public_html` documentato nella pagina
[Web, FTP, news e mailing list](05-web-news-ftp.md).

## Quote

Le quote disco erano applicate sui due filesystem dei clienti su USERS
(`/usr/export/sd1c` e `/usr/export/sd2c`).
[`quota.txt`](../systems/users/system/quota.txt) registra i profili di quota
standard e più grandi (limiti soft/hard di blocchi e inode) che erano assegnati
agli account, e l'uso di routine di `quotacheck`. Le quote erano una protezione
di disponibilità: senza di esse un cliente avrebbe potuto esaurire un filesystem
condiviso con upload o crescita della home.

## Identità dial-up

La sessione dial-up di un cliente era autenticata centralmente da XTACACS (vedi
[Autenticazione](10-authentication-tacacs.md)) e riceveva un indirizzo dal pool
dial-up del POP. Poiché l'account viveva su USERS, lo stesso login funzionava da
ogni POP.

## Mailing list e contenuti

Le mailing list rivolte ai clienti erano gestite con Majordomo su DATA, con
l'approvazione delle iscrizioni gestita via posta. Il contenuto web era
preparato su DVLP e rilasciato su USERS (pagine personali) o DATA (siti virtuali
dei clienti).

## Il Welcome Kit cliente

I nuovi clienti ricevevano un **Welcome Kit**: un manuale utente stampato e un
set di dischetti di installazione contenenti Trumpet Winsock, il programma
client **Easy!** di Internet Force e i programmi client per i principali servizi
Internet. Easy!, scritto da Marco Iannacone, offriva ai clienti un semplice
launcher/interfaccia per le applicazioni Internet incluse. Il manuale e le
immagini originali dei dischi sono pubblicati in
[`artifacts/customer-welcome-kit/`](../artifacts/customer-welcome-kit/README.md).
Questo era il lato cliente del processo di provisioning, a complemento
dell'account creato su USERS e dei numeri dial-up pubblicati da ogni POP.

## Configurazione rappresentativa

Dallo script recuperato `adduser` (`artifacts/scripts/adduser`), che crea
l'account e la home all'interno del jail:

```sh
USERUID=500            # first uid for users
MAXUID=32767
USERBASE=/users/01     # users directories base
USERSHELL=/bin/lynx    # users default shell
SHARE_DIR=/usr/export/sd1c/shared
```

L'UID parte da 500, la shell predefinita è `lynx` (accesso ai contenuti, non una
shell interattiva) e la home vive sotto `/users/01`; la quota si applica poi con
`edquota`.

→ Script completo: [`artifacts/scripts/adduser`](../artifacts/scripts/adduser) ·
quote: [`systems/users/system/quota.txt`](../systems/users/system/quota.txt)

---

Vedi anche: [La sessione dial-up](02-dialup-session.md) ·
[Server USERS](../systems/users/README.md) · [Posta elettronica](04-email.md)

---

→ [Costruire un Internet Force POP, passo per passo](00-build-an-isp.md)
