🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# L'ambiente di transizione Enter

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../LICENSE)

**Enter** fu la destinazione scelta da Internet Force per la migrazione della rimanenza dei propri
clienti milanesi e servizi centrali. Non era un ex POP: era l'ambiente verso cui
Internet Force trasferì (attraverso una consulenza di Marco) la propria operatività mentre si avviava alla chiusura.

## Contenuto

Le configurazioni e il materiale in questa area documentano:

- le configurazioni Cisco dell'ambiente Internet Force/Enter (`cisco/`);
- l'insieme DNS (`etc/named.boot`, `etc/named.data/…`), con Enter autoritativo
  per `internetforce.com`, `intf.com`, `enter.it` e altre zone, più le zone
  inverse `194.20.50`, `194.185.74`, `194.185.100`, `206.20.95`;
- la macchina `marco` nella rete Enter a `194.20.50.14`, con i ruoli `mailhost`,
  `users`, `mail`, `loghost` e gli MX di `internetforce.com` e `intf.com` che
  convergono su di essa; il feed `news` punta a `news.enter.it`;
- i database account `etc/PASSWD` e `etc/passwd.txt`.

L'insieme documenta la transizione descritta in
[La chiusura di Internet Force e le evoluzioni successive](../../docs/17-wind-down-and-migrations.md).

## Provenienza

Questi file provengono dalle configurazioni conservate della fase di transizione
verso Enter (autunno 1996).

---

Vedi anche: [Chiusura e migrazioni](../../docs/17-wind-down-and-migrations.md) ·
[La workstation di Marco](../marco/README.md) · [I POP](../pops/README.md)
