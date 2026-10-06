🇮🇹 **Italiano** · [🇬🇧 English](TECHNICAL.en.md)

# Check Point FireWall-1 2.0a --- guida tecnica

> **Internet Force 1995--1996 Historical Archive**\
> Ricostruzione e documentazione tecnica basate sui materiali originali
> Internet Force conservati da **Marco Iannacone**.\
> Autore e curatore dell'archivio: **Marco Iannacone** ·
> https://pippo.com

Internet Force usava **Check Point FireWall-1 2.0a** su una Sun
SPARCstation 5 con SunOS 4.1.4. La macchina aveva cinque interfacce
Ethernet e separava il lato world/backbone, l'office LAN e i segmenti
dei server.

## Interfacce

La configurazione recuperata identifica:

``` text
le0  206.20.95.129/25   office
qe0  206.20.95.10       fw-data
qe1  206.20.95.11       fw-users
qe2  206.20.95.12       fw-shell
qe3  10.0.0.1/8         fw-world
```

DATA e USERS erano quindi collegati a segmenti firewall distinti.

Le cinque interfacce nel file recuperato `rc.route`, nell'ordine in cui
compaiono:

``` text
ifconfig le0 netmask 255.255.255.128

ifconfig qe3 fw-world netmask 255.0.0.0

ifconfig qe0 fw-data netmask 255.255.255.192

ifconfig qe1 fw-users netmask 255.255.255.192

ifconfig qe2 fw-shell netmask 255.255.255.192
```

## Routing host-specific

`rc.route` non si limitava a configurare le interfacce. Per i segmenti
DATA e USERS eliminava route di rete connesse e aggiungeva route
host-specific.

Sul segmento DATA il file recuperato sostituisce la rotta di rete
connessa con rotte host-specific verso `fw-data`:

``` text
route delete intfnet fw-data
route add host data fw-data 0
route add host 206.20.95.20 fw-data 0
route add host 206.20.95.29 fw-data 0
route add host 206.20.95.32 fw-data 0
route add host 206.20.95.33 fw-data 0
```

Anziché lasciare raggiungibile l'intero segmento attraverso
quell'interfaccia, queste rotte rendevano raggiungibili solo host
specifici su un percorso determinato.

## La policy FireWall-1

La schermata originale `FW-policy.gif` conserva la vera rule base a 15
regole. Fra i percorsi significativi:

``` text
ts → users : tacacs/UDP : ACCEPT
clients, officenet → servers : ftp, nntp, pop-2, pop-3 : ACCEPT
dvlp, marco → servers : telnet : ACCEPT
dvlp → firewall : telnet, FW1, FW1_log : ACCEPT
news.ios.com → data : nntp : ACCEPT
dvlp, marco → marco, dvlp : X11 : ACCEPT
Any → Any : Any : STOP + log
```

La regola finale implementava un'impostazione **default deny**: ciò che
non era esplicitamente permesso veniva fermato.

Le 15 regole, con sorgente, destinazione, servizio e azione:

| # | Sorgente | Destinazione | Servizi | Azione |
|---|---|---|---|---|
| 1 | Any | Any | domain, ident | accept |
| 2 | Any | servers | icmp echo-reply/request, http, smtp | accept |
| 3 | intf.com | intf.com | Any | accept |
| 4 | intf.com | servers | ftp, nntp | accept |
| 5 | clients | intf.com | Any | accept |
| 6 | clients, officenet | servers | ftp, nntp, pop-2, pop-3 | accept |
| 7 | ts | users | tacacs | accept |
| 8 | ts | Shell | telnet | accept |
| 9 | Shell | users | NFS | accept |
| 10 | dvlp, marco | servers | telnet | accept |
| 11 | dvlp | firewall | telnet, FW1, FW1_log | accept |
| 12 | news.ios.com | data | nntp | accept |
| 13 | xpert.com | dvlp, marco | talk, deslogin | accept |
| 14 | dvlp, marco | marco, dvlp | X11 | accept |
| 15 | Any | Any | Any | STOP |

## Il traffico clienti NON passava dal firewall per andare su Internet

Questo punto è essenziale. FireWall-1 proteggeva server centrali e
office LAN. Il normale traffico Internet del cliente dial-up rimaneva
sul world/backbone:

``` text
cliente → 2511 → 2501 POP → backbone → 2501 centrale → IDT → Internet
```

Solo quando il cliente raggiungeva un servizio protetto, o quando il
2511 interrogava XTACACS su USERS, il percorso interessava il firewall.

## Avvio di FireWall-1

Il file recuperato `rc.local` avvia FireWall-1 con il seguente blocco:

``` text
# FW-1 Start
if [ -f /etc/fw/bin/fwstart ]; then
	FWDIR=/etc/fw
	export FWDIR
	/etc/fw/bin/fwstart
fi
# FW-1 END
```

Lo script esporta `FWDIR=/etc/fw` e lancia `fwstart`. Il file `rc.local`
recuperato non contiene un percorso esplicito della policy compilata o
caricata: la riga di avvio è quella sopra.

## Evidenza originale

La schermata storica della policy è conservata in:

[`checkpoint/FW-policy.gif`](checkpoint/FW-policy.gif)

## Continua l'esplorazione

-   [Sicurezza: servizi e hardening](../../docs/06-security.md)
-   [La sessione dial-up](../../docs/02-dialup-session.md)
-   [DNS](../../docs/03-dns.md)
