🇮🇹 **Italiano** · [🇬🇧 English](TECHNICAL.en.md)

# Cisco 2511 --- modem, PPP e XTACACS

> **Internet Force 1995--1996 Historical Archive**\
> Ricostruzione e documentazione tecnica basate sui materiali originali
> Internet Force conservati da **Marco Iannacone**.\
> Autore e curatore dell'archivio: **Marco Iannacone** ·
> https://pippo.com

Il Cisco 2511 era l'**access server** dei POP: trasformava una chiamata
telefonica terminata su un modem in una sessione IP.

## Sedici linee asincrone

Le configurazioni iniziali mostrano 16 linee e interfacce asincrone.
Dietro quelle interfacce software c'erano fisicamente i modem.

``` text
PSTN → modem 1  ─┐
PSTN → modem 2  ─┤
...               ├→ Cisco 2511 → rete IP
PSTN → modem 16 ─┘
```

Le configurazioni recuperate mostrano `line 1 16`; il materiale DNS
descrive inoltre la struttura come `2511+16 modems`.

## Da seriale a IP: PPP

Le interfacce asincrone erano configurate per PPP. Nei file recuperati
compaiono:

``` text
encapsulation ppp
ip unnumbered Ethernet0
async default ip address ...
```

`ip unnumbered Ethernet0` consentiva all'interfaccia PPP di usare
l'identità IP di un'altra interfaccia invece di consumare un indirizzo
dedicato per ogni lato locale della sessione.

## XTACACS

Tutti i 2511 iniziali puntavano a:

``` text
tacacs-server host 206.20.95.4
```

`206.20.95.4` era USERS, dove girava `xtacacsd`. Il 2511 riceveva le
credenziali del cliente e chiedeva al servizio centrale se l'accesso
fosse autorizzato.

``` text
cliente
   │ username/password
   ▼
Cisco 2511
   │ TACACS UDP
   ▼
FireWall-1
   │
   ▼
USERS 206.20.95.4
   │ xtacacsd
   └── risposta → 2511
```

Il file `/etc/services` di USERS associa TACACS alla porta UDP 49;
`xtacacsd` era avviato separatamente da `rc.local`.

Nella configurazione recuperata del 2511 di Pesaro il server TACACS e i
relativi servizi sono dichiarati a livello globale:

``` text
tacacs-server host 206.20.95.4
tacacs-server extended
tacacs-server authenticate connections
tacacs-server authenticate slip always
tacacs-server notify connections
tacacs-server notify enable
tacacs-server notify logout
tacacs-server notify slip
```

L'autenticazione delle linee dial-up era richiesta nella configurazione
delle linee, nel blocco `line 1 15`:

``` text
line 1 15
 exec-timeout 0 0
 login tacacs
```

Il file recuperato non contiene una direttiva di accounting TACACS
separata: le righe presenti sono quelle sopra.

## Il collegamento 2511 ↔ 2501

Nei POP remoti il 2511 non sostituiva il router. Le reti dial-up e il
collegamento verso il 2501 facevano parte dello stesso disegno di
routing.

## Configurazioni complete

Le configurazioni recuperate dei quattro access server:

- [`systems/pops/milano/2511.cfg`](../pops/milano/2511.cfg)
- [`systems/pops/pesaro/2511.cfg`](../pops/pesaro/2511.cfg)
- [`systems/pops/palermo/2511.cfg`](../pops/palermo/2511.cfg)
- [`systems/pops/gorgonzola/2511.cfg`](../pops/gorgonzola/2511.cfg)

## Continua l'esplorazione

-   [Cisco 2501: routing](../cisco-2501-uplink/TECHNICAL.md)
-   [La sessione dial-up](../../docs/02-dialup-session.md)
-   [Panoramica dell'architettura](../../docs/01-architecture.md)
