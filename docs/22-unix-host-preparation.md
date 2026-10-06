🇮🇹 **Italiano** · [🇬🇧 English](22-unix-host-preparation.en.md)

# Preparare un host Unix

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

## Quale problema risolve

Un sistema operativo appena installato funziona, ma non è ancora un host
Internet Force. Per diventarlo deve conoscere **chi è** (identità di rete),
**dove si trova** (indirizzo, netmask, rete locale), **come uscire** (rotta di
default), **cosa avviare** al boot e **chi può fare cosa** (account e permessi).
Questo capitolo copre quella preparazione, dal sistema nudo al ruolo operativo.

## Come lo implementava Internet Force

Su SunOS la preparazione seguiva un modello a file di testo, ricreato a ogni
avvio dagli script `rc`:

- **identità:** `hostname`, dominio locale `internetforce.com`
  (`/etc/defaultdomain`) e `/etc/hosts` con le macchine della rete;
- **interfacce:** l'indirizzo sulla `le0` (SunOS) con `ifconfig`, le netmask in
  `/etc/netmasks`;
- **rotta di default:** `/etc/defaultrouter` indicava il router (`intf-idt` sul
  firewall), e `rc.route` ricostruiva le rotte host-specifiche a ogni boot;
- **avvio servizi:** `rc.local` avviava i demoni locali (portmapper, ecc.);
- **permessi:** uno script `fixperms` riportava i binari di sistema al
  proprietario corretto e correggeva i casi segnalati dai controlli di sicurezza;
- **account:** gli account di servizio usavano shell non interattive (es.
  `/bin/nosh`) per limitarne l'uso.

Il risultato era un host che, a ogni riavvio, ricostruiva da solo la propria
configurazione di rete e i propri servizi.

## Componenti e host

Ogni host Internet Force seguiva lo stesso modello: **DATA**, **USERS**,
**FIREWALL**, **DVLP** e la workstation **MARCO** (Linux/Slackware, con i suoi
`rc.*`). Su SunOS l'interfaccia era `le0`; su Linux poteva essere `eth0`.

## Configurazione rappresentativa

La rotta (route in inglese, il percorso che devono seguire i pacchetti IP) veniva
ricostruita a ogni avvio su DATA (`systems/data/system/rc.route`): la
rotta di default punta al firewall, non direttamente a Internet.

```sh
hostname=`hostname`
route delete intfnet $hostname
route add $hostname $hostname 0
route add default fw-$hostname 1
```

L'identità di rete locale, invece, era definita da file statici. Dal firewall
(`systems/firewall/network/defaultrouter` e `defaultdomain`):

```text
intf-idt
internetforce.com
```

→ File completi: [`systems/data/system/rc.route`](../systems/data/system/rc.route) ·
[`systems/firewall/network/defaultrouter`](../systems/firewall/network/defaultrouter) ·
[`systems/firewall/network/netmasks`](../systems/firewall/network/netmasks) ·
[`systems/data/system/rc.local`](../systems/data/system/rc.local) ·
[`systems/firewall/system/fixperms`](../systems/firewall/system/fixperms)

## Come si collega al resto del POP

Un host preparato è il presupposto di tutto il resto: senza indirizzo e rotta di
default non può parlare con il [router/WAN](16-router-and-wan.md); l'identità di
rete e `/etc/hosts` sono la base del [DNS](03-dns.md); gli account e i permessi
sono la base di [autenticazione](10-authentication-tacacs.md), [posta](04-email.md),
[web](05-web-news-ftp.md) e [FTP](05-web-news-ftp.md). Vedi anche
[Panoramica dell'architettura](01-architecture.md) per il contesto fisico.

## Materiale originale correlato

- [`systems/data/system/`](../systems/data/system/README.md) — `rc.local`, `rc.route`, `inetd.conf`, `passwd`.
- [`systems/users/system/`](../systems/users/system/README.md) — preparazione dell'host USERS.
- [`systems/firewall/network/`](../systems/firewall/network/README.md) — identità di rete, netmask, rotte.
- [`systems/marco/`](../systems/marco/README.md) — script `rc.*` su Linux.
- [`artifacts/operations-manuals/manual.md`](../artifacts/operations-manuals/manual.md) — manuale operativo originale.

*Fonti: file di configurazione originali.*

---

← [Costruire un POP](00-build-an-isp.md) ·
Precedente: [Architettura](01-architecture.md) ·
Prossimo: [Router, WAN](16-router-and-wan.md) →
