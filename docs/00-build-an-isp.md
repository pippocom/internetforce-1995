🇮🇹 **Italiano** · [🇬🇧 English](00-build-an-isp.en.md)

# Costruire un POP Internet Force, passo per passo

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

Questa è la **guida tecnica sequenziale** del repository: non un elenco di file,
ma il percorso con cui un amministratore avrebbe costruito e messo in funzione un
POP Internet Force. Si parte dalla connettività e dai sistemi Unix, poi si
aggiungono accesso, autenticazione, DNS, posta, web, FTP, sicurezza e operazioni,
fino ad avere una piattaforma di servizi completa.

Ogni capitolo è un **link** al documento canonico che lo spiega; accanto trovi le
tecnologie coinvolte e il tipo di materiale originale disponibile. Ogni capitolo
contiene uno **snippet di configurazione rappresentativo** e il link al file
completo.

Il percorso segue l'ordine reale del lavoro. Il **manuale operativo originale**
per un eventuale sysad junior futuro è in
[`artifacts/operations-manuals/manual.md`](../artifacts/operations-manuals/manual.md):
leggilo come fonte first-party accanto a questa guida.

> **Prima del percorso tecnico:** come si imparava questo mestiere nella prima
> Internet - competenza, autonomia e RTFM - è raccontato in
> [Come si imparava Internet](23-learning-internet-culture.md). È contesto
> culturale, non un passo di configurazione.

---

## 0. [Capire l'architettura del POP](01-architecture.md)

Quali macchine esistono e come sono collegate: sito centrale, POP regionali,
backbone privato e bordo Internet.

**Tecnologie:** Cisco, backbone privato, firewall, LAN. **Evidenza:** diagrammi,
mappe tkined, inventario host.

## 1. [Preparare un host Unix](22-unix-host-preparation.md)

Da un sistema appena installato a un host utile: identità, indirizzo, rotte,
`/etc/hosts`, script di avvio e permessi.

**Tecnologie:** SunOS/Linux, `ifconfig`, `route`, script `rc`. **Evidenza:**
`rc.local`, `rc.route`, `fixperms`, file di rete.

## 2. [Router, WAN e connettività](16-router-and-wan.md)

Collegare il POP al backbone: interfacce, indirizzamenti, link seriali e rotta di
default verso il gateway world.

**Tecnologie:** Cisco 2501, seriale/WAN, IOS 10.2. **Evidenza:** `2501.cfg`,
`rc.route`.

## 3. [Dial-up e banco modem](02-dialup-session.md)

Far entrare il cliente nella rete IP attraverso il banco modem e l'access server.

**Tecnologie:** Cisco 2511, modem US Robotics 28.8, PPP. **Evidenza:** `2511.cfg`,
`modem.txt`, numeri dial-in.

## 4. [Autenticazione (XTACACS)](10-authentication-tacacs.md)

Ogni access server interroga XTACACS su USERS: ramo separato dal percorso dati.

**Tecnologie:** XTACACS, USERS. **Evidenza:** `xtacacsd-conf`, `passwd`.

## 5. [DNS](03-dns.md)

Risoluzione e servizio autoritativo: zone dirette e inverse, MX, delega dei
domini clienti.

**Tecnologie:** BIND/named. **Evidenza:** `named.boot`, file di zona, reverse.

## 6. [Posta (Sendmail)](04-email.md)

Trasporto SMTP e consegna locale: MX, alias e mailbox.

**Tecnologie:** Sendmail 8.6.12, `mail.local`. **Evidenza:** `sendmail.cf`.

## 7. [POP3 e accesso alla mailbox](18-pop3-and-mailbox-access.md)

Come il cliente legge la posta consegnata: POP3/IMAP su USERS, modello `.mailbox`.

**Tecnologie:** popper 1.6, imapd, `inetd`. **Evidenza:** config popper.

## 8. [Web server](05-web-news-ftp.md#world-wide-web)

Servire i siti: DocumentRoot, host virtuali, aree personali.

**Tecnologie:** NCSA HTTPd. **Evidenza:** `httpd.conf`, `srm.conf`.

## 9. [Permessi web e CGI](19-web-permissions-and-cgi.md)

Eseguire programmi in sicurezza: directory CGI, proprietari, permessi, `fixperms`.

**Tecnologie:** CGI, `srm.conf`, `fixperms`. **Evidenza:** inventario CGI, `fixperms`.

## 10. [Virtual hosting (VIF)](../systems/sun-vif/README.md)

Più siti su una sola Sun: interfacce virtuali nel kernel SunOS.

**Tecnologie:** VIF, SunOS 4.1.x, `modload`. **Evidenza:** bundle VIF, `VirtualHost`.

## 11. [FTP e confinamento](05-web-news-ftp.md#ftp)

FTP anonimo e autenticato, `inetd → tcpd → ftpd`, `chroot`, `ftpusers`.

**Tecnologie:** wu-ftpd, `chroot`. **Evidenza:** `ftpusers`, `ftp-world.txt`.

## 12. [Mailing list (Majordomo)](20-mailing-lists-majordomo.md)

Posta di gruppo: iscrizioni, approvazioni, distribuzione e archivi.

**Tecnologie:** Majordomo su DATA, alias Sendmail, Hypermail. **Evidenza:**
materiale Majordomo.

## 13. [Sicurezza e hardening](06-security.md)

Ridurre Unix al ruolo della macchina, il firewall, `inetd`, il confinamento.

**Tecnologie:** TCP wrappers, `chroot`, firewall. **Evidenza:** `inetd.conf`,
`fixperms`.

## 14. [Monitoraggio](08-monitoring.md)

Osservare interfacce, collegamenti, server e linee modem.

**Tecnologie:** SNMP, tkined. **Evidenza:** `intf.snmp.map`, mappe.

## 15. [Operazioni e backup](14-operations-and-backup.md)

Ordine di avvio, backup su nastro, attività pianificate, log, quote.

**Tecnologie:** `gtar`/`dump`, cron, NTP. **Evidenza:** script di backup, `crontab`.

## 16. [Provisioning dei clienti](12-customer-provisioning.md)

Dal contratto all'account: creazione, home, quota, identità dial-up.

**Tecnologie:** `adduser`, `edquota`. **Evidenza:** `adduser`, `quota.txt`.

## 17. [Sviluppo e deploy](07-development.md)

Costruire su DVLP e rilasciare in produzione: build-and-deploy.

**Tecnologie:** DVLP, FTP interno, SSH/SCP. **Evidenza:** `/cisco`, note operative.

## 18. [Mettere insieme il POP](21-putting-the-pop-together.md)

Come tutti i sottosistemi formano un servizio completo, dal modem al backbone.

**Tecnologie:** l'intera catena. **Evidenza:** sintesi dei capitoli.

---

Vuoi invece ispezionare un singolo sottosistema? Passa a
[Esplorare per sistema e infrastruttura](../README.md) oppure al
[manuale operativo originale](../artifacts/operations-manuals/manual.md).
