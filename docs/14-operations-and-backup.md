🇮🇹 **Italiano** · [🇬🇧 English](14-operations-and-backup.en.md)

# Operazioni e backup

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

Questa pagina raccoglie le pratiche operative di routine: come i sistemi
venivano avviati e spenti, come i dati erano salvati e ripristinati, e i job
pianificati che tenevano in piedi il servizio.

## Ordine di avvio e spegnimento

I server centrali avevano dipendenze, quindi erano avviati in un ordine fisso:

1. **FIREWALL** — prima il gateway di sicurezza, così i segmenti protetti si
   avviavano dentro una rete controllata.
2. **DATA** — il DNS primario e i servizi pubblici.
3. **USERS** — autenticazione, posta e servizi ai clienti.
4. **DVLP e la workstation di Marco** — il lato ufficio/sviluppo.

Lo spegnimento era l'inverso: i sistemi erano fermati con `shutdown` e
l'alimentazione non veniva semplicemente tolta.

## Backup completi

Il dispositivo di backup era un'unità a nastro collegata a **DVLP**
(`/dev/rst0`, o `/dev/nrst0` per accodare). I backup completi di ogni host erano
scritti con GNU `tar` (`gtar`) come stream, per esempio:

```
mt -f /dev/rst0 rewind
gtar -czvf - /. | dd bs=220k of=/dev/nrst0
(rsh data    gtar -czvf - /)  | dd bs=220k of=/dev/nrst0
(rsh users   gtar -czvf - /)  | dd bs=220k of=/dev/nrst0
(rsh firewall gtar -czvf - /.) | dd bs=220k of=/dev/nrst0
```

DATA, USERS e FIREWALL erano salvati attraverso la rete interna con `rsh`, ed è
per questo che gli host dovevano fidarsi l'uno dell'altro sui segmenti
dell'ufficio e rivolti al firewall. Prima di iniziare, i filesystem montati
erano controllati con `df` e i supporti rimovibili (come il CD-ROM) erano
smontati, così non venivano catturati.

I backup **incrementali** usavano la facility standard `dump`.

## Ripristino

Leggere o ripristinare un nastro usava gli stessi strumenti:

```
gtar -tzvf /dev/rst0                 # elenca il contenuto
gtar -tzvf /dev/rst0 etc/test.doc    # trova un file (senza slash iniziale)
gtar -xzvf /dev/rst0 etc/test.doc    # estrailo
mt -f /dev/rst0 offline              # espelli
```

## Che fine hanno fatto i nastri

I nastri DAT utilizzati per i backup operativi erano proprietà di Internet Force
e rimasero all'azienda; non fanno quindi parte dell'archivio storico oggi
disponibile.

All'autore è però “rimasta” una diversa cassetta DAT, sulla quale all'epoca
aveva effettuato una copia della propria workstation Linux `marco`. Nel 2026
ha noleggiato un drive DAT (parzialmente) compatibile per recuperarne il contenuto.
Il nastro si è rivelato una fonte importante di ulteriori configurazioni,
documentazione, posta e sorgenti.

Una parte degli archivi `tar` recuperati, originariamente creati o transitati
attraverso DVLP, risulta solo parzialmente leggibile: in alcuni casi sono
rimasti struttura e nomi dei file, mentre singoli contenuti risultano vuoti,
troncati o corrotti.

Per dettagli sulla provenienza e sui limiti del materiale recuperato vedere
[Provenienza dell'archivio](archive-provenance.md).

## Attività pianificate

`cron` su USERS e DATA eseguiva i job di routine:

- pulizia dei file segnaposto NFS obsoleti (`.nfs*`) più vecchi di una settimana
  - un'abitudine di manutenzione ereditata dall'ambiente SunOS di serie;
- `newsyslog` per la rotazione dei log;
- pulizia della directory `/var/preserve/`;
- rigenerazione delle statistiche web e di posta;
- il mirror `webcopy` pianificato di un sito esterno su DATA;
- l'elaborazione della scadenza degli account per l'area di login web.

I crontab di root di entrambi gli host sono conservati in
[`artifacts/scripts/crontab_users_data.txt`](../artifacts/scripts/crontab_users_data.txt).

## Logging

I server inoltravano il loro output `syslog` a **DVLP** come `loghost` centrale,
così un solo host teneva i log combinati. Il firewall registrava i propri eventi
di gestione e di traffico attraverso il canale di logging di FireWall-1.

## Modifiche di sistema dopo l'installazione dell'OS

L'archivio include una checklist delle modifiche applicate a un server SunOS
fresco dopo l'installazione: abilitare i servizi richiesti, stringere proprietà
di file e directory (per esempio `/usr/local/ftp/etc`), configurare i ruoli di
posta e DNS e applicare le convenzioni operative locali. Questa nota di
"system modification after OS installation" è la cosa più vicina a uno standard
di build per un nuovo host.

## Gestione utenti e quote

Il lavoro quotidiano sugli account procedeva accanto agli strumenti di
provisioning: creare e rimuovere utenti, reimpostare password e applicare o
regolare le quote disco sui filesystem dei clienti con `edquota` e
`quotacheck`; i profili di quota recuperati sono in
[`systems/users/system/quota.txt`](../systems/users/system/quota.txt). I
dettagli sono in [Provisioning dei clienti](12-customer-provisioning.md).

---

Vedi anche: [Sviluppo](07-development.md) · [Monitoraggio](08-monitoring.md) ·
[Panoramica dell'architettura](01-architecture.md)

---

→ [Costruire un Internet Force POP, passo per passo](00-build-an-isp.md)
