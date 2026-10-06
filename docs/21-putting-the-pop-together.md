🇮🇹 **Italiano** · [🇬🇧 English](21-putting-the-pop-together.en.md)

# Mettere insieme il POP

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

Questa è la sintesi: **come funziona un POP Internet Force completo** una volta
configurati tutti i sottosistemi. Non aggiunge configurazione; mostra come i
capitoli precedenti si incastrano.

## La catena del servizio

```text
Internet
   ↓
Cisco 2501 centrale (world/uplink)  ── gateway backbone 10.0.0.1
   ↓
backbone privato Internetforce
   ↓
Cisco 2501 del POP  ── link seriale /25 ──  Cisco 2511 access server
   ↓                                              ↑
   ↓                                        banco modem (16 linee)
   ↓                                              ↑
   ↓                                     chiamata del cliente
   ↓
autenticazione: 2511 → XTACACS su USERS (206.20.95.4)
   ↓
rete IP locale del POP (dial-up 206.20.x.0/24) → gateway → backbone
   ↓
host di servizio centrali:
   FIREWALL  (bordo + segmentazione)
   DATA      (206.20.95.3)  DNS primario, web, FTP anonimo, Majordomo
   USERS     (206.20.95.4)  XTACACS, mail host, POP3/IMAP, pagine personali
   DVLP      (206.20.95.130) build/operations, test, backup su nastro
   MARCO     (206.20.95.140) workstation dell'amministratore
   ↓
servizi:
   DNS  → 03-dns
   mail (SMTP)  → 04-email
   POP3/IMAP  → 18-pop3-and-mailbox-access
   web + virtual hosting (VIF)  → 05-web-news-ftp / sun-vif
   FTP  → 05-web-news-ftp + 06-security
   mailing list (Majordomo)  → 20-mailing-lists-majordomo
   ↓
monitoraggio (SNMP/tkined), sicurezza, operazioni di routine
```

I POP remoti (Pesaro, Palermo, Gorgonzola) raggiungevano Milano con circuiti
dedicati **CDA/CDN da 64 kbit/s**; il dimensionamento del banco modem rispetto a
quella capacità segue la regola empirica di Xpert descritta in
[I POP](../systems/pops/README.md).

## Il percorso in ordine

1. [Architettura](01-architecture.md) — capire le macchine e il collegamento.
2. [Unix e preparazione dell'host](01-architecture.md) — rendere utile un host.
3. [Router, WAN](16-router-and-wan.md) — collegare il POP al backbone.
4. [Dial-up](02-dialup-session.md) — far entrare il cliente nella rete.
5. [Autenticazione](10-authentication-tacacs.md) — riconoscere chi chiama.
6. [DNS](03-dns.md) — dare nomi alla rete.
7. [Posta](04-email.md) — trasportare e consegnare i messaggi.
8. [POP3 e mailbox](18-pop3-and-mailbox-access.md) — far leggere la posta al cliente.
9. [Web server](05-web-news-ftp.md) — servire i siti.
10. [Permessi web e CGI](19-web-permissions-and-cgi.md) — eseguire programmi in sicurezza.
11. [Virtual hosting (VIF)](../systems/sun-vif/README.md) — più siti su una macchina.
12. [FTP](05-web-news-ftp.md) — trasferire file, con confinamento.
13. [Mailing list](20-mailing-lists-majordomo.md) — distribuire posta di gruppo.
14. [Sicurezza](06-security.md) — ridurre e difendere la superficie.
15. [Monitoraggio](08-monitoring.md) — osservare la rete.
16. [Operazioni e backup](14-operations-and-backup.md) — mantenere il sistema.
17. [Provisioning](12-customer-provisioning.md) — dare un account al cliente.
18. [Sviluppo e deploy](07-development.md) — costruire e rilasciare il software.

## Il punto di vista dell'amministratore

Tutto questo è descritto, nell'ordine e nella voce dell'epoca, dal **manuale
operativo originale** preparato da Marco per un potenziale sysad junior:
[`artifacts/operations-manuals/manual.md`](../artifacts/operations-manuals/manual.md).
È il riferimento first-party da leggere accanto a questo percorso.

## Come continuare

- Torna all'[indice Costruire un POP](00-build-an-isp.md).
- Esplora per sistema: [I POP](../systems/pops/README.md) e i server
  [DATA](../systems/data/README.md) e [USERS](../systems/users/README.md).
- Provenienza del materiale recuperato:
  [Provenienza dell'archivio](archive-provenance.md).

---

← [Costruire un POP](00-build-an-isp.md) ·
Precedente: [Sviluppo e deploy](07-development.md)
