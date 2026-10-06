🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# POP di Gorgonzola

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../LICENSE)

Gorgonzola segue il disegno standard dei POP remoti: un router Cisco 2501 per il
collegamento al backbone e un access server Cisco 2511 per il banco modem.

## Router (Cisco 2501)

- Hostname `2501gorgonzola`, IOS 10.2.
- Ethernet0: `10.0.5.1/26` (segmento privato `10.0.5.0/26`).
- Serial0: `10.0.5.129/25`, punto-punto verso il 2511 a `10.0.5.130`.
- Rotta di default verso il gateway world/backbone (`10.0.0.1`).
- Portava la rete dial-up di Gorgonzola `206.20.225.0/24` e la sottorete
  clienti `206.20.225.64/27` verso il 2511.

## Access server (Cisco 2511)

- Hostname `2511gorgonzola`, IOS 10.3.
- Ethernet0: `206.20.225.65/27` sulla sottorete `206.20.225.64/27`.
- 16 linee asincrone, PPP, `ip unnumbered Ethernet0`.
- Indirizzi di default dei clienti `206.20.225.2` … `206.20.225.17`.
- `tacacs-server host 206.20.95.4`, autenticazione centrale.

## Accesso telefonico

Il POP pubblicava un numero ufficio e un blocco di linee modem instradate dal
gruppo di caccia telefonico. I numeri sono registrati nelle note operative
recuperate.

## Pointest

`pointest.com` era il dominio associato al POP di Gorgonzola. Nella fase
iniziale era ospitato centralmente su DATA; Marco Iannacone vi installò il
servizio di conteggio CGI (`Count.cgi`) nell'ambito di una consulenza. Lo
snapshot del sito personale
[`pippo.com` del 1997](../../../systems/marco/personal-web/pippo.com-1997/README.md)
conserva le chiamate a `Count.cgi` e `cgiemail` servite da `pointest.com`.

## Note

Il 2511 ha una linea 16 dedicata all'uso out-of-band (velocità inferiore, login
con password) in aggiunta alle 15 linee autenticate via TACACS - una
sistemazione comune per un percorso console/gestione in un sito remoto.

## Fase successiva: Pointest (1996)

Il POP di Gorgonzola fu anche il contesto della successiva fase **Pointest**,
distinta dal POP Internet Force descritto sopra. La directory
[`pointest/`](pointest/) raccoglie il materiale con cui fu costruita
l'infrastruttura di servizio autonoma:

- `CISCO/2511BIGI.TXT` — configurazione Cisco 2511;
- `Linux/named/` — BIND/DNS;
- `Linux/popper/` — POP3;
- `Linux/xtacacsd/` — XTACACS e la sua configurazione;
- `Linux/FSTAB.TXT` — filesystem Linux.

Questi file provengono dalle configurazioni conservate della fase successiva
Pointest, dopo la chiusura di Internet Force.

---

Vedi anche: [Chiusura e migrazioni](../../../docs/17-wind-down-and-migrations.md) ·
[I POP](../README.md) ·
[L'uplink Internet](../../cisco-2501-uplink/README.md) ·
[La sessione dial-up](../../../docs/02-dialup-session.md)
