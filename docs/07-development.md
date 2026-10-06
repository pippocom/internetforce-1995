🇮🇹 **Italiano** · [🇬🇧 English](07-development.en.md)

# Sviluppo e l'host di build (DVLP)

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

Internet Force manteneva una netta separazione tra le macchine che servivano i
clienti e la macchina usata per compilare il software. Questa separazione è uno
dei temi ricorrenti dell'architettura.

## DVLP

DVLP era un Sun SPARCstation 4 con SunOS 4.1.4 e 32 MB di RAM, sulla LAN
dell'ufficio a `206.20.95.130`. Non era un server di produzione segmentato dal
firewall e non era l'host SHELL pianificato. Il suo compito era sviluppare,
compilare e preparare il software prima che andasse vicino alla produzione.

L'archivio di configurazione registra la ragione della sua esistenza in una
sola riga: *"In /cisco is stored the configuration of the routers."* DVLP era
il deposito di lavoro per le configurazioni dei router e un'area di sviluppo
generale.

## La workstation `marco` non era la catena di build

DVLP era una macchina SunOS e restava il luogo in cui si costruiva il software
destinato ai server Sun. La workstation personale `marco` era invece un PC Linux
(Slackware), nato come **ambiente di sperimentazione sacrificabile**: un sistema
che Marco poteva modificare, rompere o reinstallare da zero senza mettere a
rischio i server di produzione. Con il tempo divenne la workstation quotidiana
di amministrazione, test e monitoraggio (tkined/SNMP), ospitò l'uso personale di
PGP e copie occasionali di lavoro, e infine fu riconfigurata come server di
transizione durante la migrazione verso Enter.

Le due macchine non vanno confuse: **non faceva parte del flusso operativo
Internet Force una cross-compilazione Linux → SunOS**. Il software destinato ai
server Sun continuava a essere costruito nell'ambiente Sun (DVLP); la macchina
Linux serviva a sperimentare e a testare, non a produrre i binari di produzione.
Vedi
[La workstation di Marco](../systems/marco/README.md) e
[Note storiche](09-historical-notes.md).

## Modello build-and-deploy

Il modello operativo del 1995 era quello UNIX classico:

1. Ottenere il sorgente o il software precompilato dai siti Internet/FTP
   dell'epoca.
2. Compilarlo e costruirlo localmente su DVLP.
3. Testarlo lì, incluso il contenuto web prima della pubblicazione.
4. Trasferire solo i componenti runtime sui server di produzione.

I server di produzione portavano quindi un insieme minimo di software. Compilatori
e strumenti di sviluppo restavano su DVLP; DATA e USERS eseguivano solo ciò che
serviva a erogare il servizio. Il meccanismo di trasferimento nella prima fase
era il servizio FTP interno, con SSH/SCP aggiunti nel 1996 come alternative
sicure.

Poiché gli host di produzione erano costruiti e non installati in blocco,
l'insieme esatto dei pacchetti su ciascuno si capisce meglio dall'
[inventario software](11-software-inventory.md) e dalle singole pagine di
sistema.

## Gestione delle configurazioni dei router

Le configurazioni Cisco avevano due sedi di lavoro. DVLP le teneva sotto
`/cisco`, e i dispositivi Cisco stessi erano caricati da una directory di
staging TFTP sulla workstation di Marco; nuove configurazioni POP si creavano
copiando un template collaudato, modificando gli indirizzi e riscrivendo la
configurazione. Il `CISCO-add_new_pop-HOWTO` recuperato documenta questa
procedura, incluso il dialogo da console per un nuovo router.

Le copie canoniche pubblicate delle configurazioni dei router stanno sotto
[l'uplink](../systems/cisco-2501-uplink/README.md) e i
[POP](../systems/pops/README.md); il `/cisco` di DVLP è descritto qui per
completezza storica, non duplicato.

## Test dei contenuti

Le pagine web erano sempre testate su DVLP prima di essere pubblicate su USERS o
DATA. Il flusso HTML era: modificare, caricare su DVLP, verificare, poi
rilasciare sul server di produzione. Questo teneva le pagine rotte fuori dai
siti pubblici e gli strumenti di authoring fuori dalle macchine di produzione.

## Accesso remoto e sicuro

Nella prima fase l'amministrazione usava telnet e rlogin/rsh più FTP su regole
firewall dedicate. Nel 1996 furono introdotti **SSH e SCP**, che divennero il
modo standard per raggiungere i server e spostare file.

## Configurazione rappresentativa

Il modello build-and-deploy lascia tracce nei file operativi recuperati. Esempio
da `artifacts/scripts/system.modification-after_OSINSTALLATION.txt`, che registra
una modifica preparata e applicata a un host di produzione (`users`):

```text
30 2 * * * /users/01/ianna/home/public_html/tools/stats/intf.stat
```

Una modifica veniva preparata e provata su DVLP, poi applicata all'host di
produzione; il file documenta proprio questo passaggio.

→ Evidenza completa: [`artifacts/scripts/system.modification-after_OSINSTALLATION.txt`](../artifacts/scripts/system.modification-after_OSINSTALLATION.txt) ·
[`systems/dvlp/README.md`](../systems/dvlp/README.md)

---

Vedi anche: [Operazioni e backup](14-operations-and-backup.md) ·
[Inventario software](11-software-inventory.md) ·
[Sistema DVLP](../systems/dvlp/README.md) ·
[Come si imparava Internet](23-learning-internet-culture.md)

---

→ [Costruire un Internet Force POP, passo per passo](00-build-an-isp.md)
