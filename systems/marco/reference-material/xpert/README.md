🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# Materiale di riferimento Xpert

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../../LICENSE)

Durante il periodo trascorso presso **Xpert UNIX Systems** in Israele nel 1995,
Marco Iannacone raccolse configurazioni e file tecnici utilizzati come esempi di
riferimento. Li portò successivamente a Milano e li utilizzò come base tecnica da
studiare, adattare e migliorare nella progettazione e configurazione di
Internet Force.

Questi file:

- sono materiale **Xpert** portato da Marco da Tel Aviv;
- **non** sono configurazioni operative Internet Force;
- documentano anche il modo in cui conoscenze e configurazioni tecniche venivano
  trasferite e riutilizzate nella costruzione dell'ISP.

## Cosa contiene

- `rc.linux.xpert/` — script di avvio Linux da una macchina Xpert (`rc.inet1`,
  `rc.inet2`, `rc.S`, `rc.serial`, `rc.local`, …);
- `xpert.varie/` — utilità e file di sistema vari: configurazione Apache 1.1,
  `hosts`, `networks`, `inetd.conf`, Sendmail, FTP, un albero BIND-4 con le zone
  dei domini Xpert (`xpert.com`, `xpert.co.il`, `yahel.org`, …) e altro;
- `named.boot.xpert`, `named.xpert.tar.z` — materiale BIND-4 Xpert;
- `mail-loc.sendmail-xpert` — configurazione Sendmail di riferimento;
- `xpert.disk-info.txt`, `README.txt` — note della macchina di riferimento;
- `2501yahel.txt` — configurazione di router conservata fra il materiale di
  Marco. **Questa copia è stata spostata** con l'uplink Internet Force, perché è
  una copia della configurazione dell'uplink Cisco 2501:
  [scheda dell'uplink](../../../cisco-2501-uplink/config/2501yahel.txt).

Illustra l'ambiente su cui fu modellata Internet Force: una bottega UNIX/ISP
israeliana funzionante, le cui pratiche e strumenti furono adattati per il
servizio italiano. Il rapporto con Xpert è visibile anche nella rule base del
firewall, che consentiva a `xpert.com` accesso di supporto remoto a DVLP e alla
workstation di Marco.

---

Vedi anche: [La workstation `marco`](../../README.md) ·
[Note storiche](../../../../docs/09-historical-notes.md) ·
[L'uplink Cisco 2501](../../../cisco-2501-uplink/README.md)
