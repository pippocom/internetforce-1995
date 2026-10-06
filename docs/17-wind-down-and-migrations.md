🇮🇹 **Italiano** · [🇬🇧 English](17-wind-down-and-migrations.en.md)

# La chiusura di Internet Force e le evoluzioni successive

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

Internet Force operò nel 1995–1996 e chiuse mentre il mercato italiano
dell'accesso a Internet era ancora molto piccolo. La sua fine non fu uno
spegnimento improvviso: fu un passaggio progressivo che portò i clienti e i
servizi centrali verso **Enter** e rese via via autonomi i POP che vollero
continuare l'attività come provider indipendenti. Le configurazioni e i
documenti conservati permettono di seguire questo passaggio e le evoluzioni
successive.

## Perché Internet Force chiuse

Per capire la decisione dei soci è utile ricordare quanto fosse piccolo il
mercato dell'epoca. Alla metà degli anni Novanta l'accesso a Internet in Italia
contava nell'ordine delle decine di migliaia di utenti: circa **50.000 utenti
Internet nel 1995**, e ancora in una fase iniziale nell'ottobre 1996. Il
principale provider italiano, **Video On Line** (VOL), fondato a Cagliari nel
1993 e attivo dal 1994, nel 1995 aveva circa **15.000 abbonati** - una quota
molto ampia del mercato - e nel giugno **1996** fu acquisito da Telecom Italia,
confluendo nell'unità che sarebbe diventata Tin.it.

Nella fase di espansione del **1996** Internet Force raggiunse circa **2.000
abbonati**. Per una società molto più piccola e con risorse inferiori, quella
dimensione era un risultato promettente. La crescita del mercato sarebbe arrivata
pochi anni dopo: **Tiscali**, fondata a Cagliari nel gennaio **1998**, lanciò il
servizio gratuito **FreeNet nel 1999** e passò in breve a centinaia di migliaia
di utenti. Non si tratta di un confronto aziendale diretto - nel frattempo erano
cambiati mercato, regole e modello commerciale - ma mostra quanto rapidamente
cambiasse la scala del settore.

La lettura retrospettiva di **Marco Iannacone**, autore e curatore dell'archivio,
è che **Internet Force chiuse troppo presto**: i soci valutarono l'economia del
business quando il mercato italiano era ancora minuscolo, e l'azienda ne uscì
prima che il mercato rivelasse la scala che avrebbe raggiunto di lì a poco.

## Una chiusura per migrazione, non per spegnimento

La chiusura generò un progetto tecnico di migrazione con due obiettivi:
**evitare l'interruzione dei servizi** ai clienti centrali e **rendere
progressivamente autonomi** i POP che volevano continuare come provider
indipendenti. I materiali conservati mostrano che il processo era già in corso
nell'autunno del **1996** e proseguì nel **1997**.

La documentazione societaria conservata comprende anche il materiale relativo al
[fallimento del 1996](../artifacts/company/bankruptcy-1996/README.md), che
riguarda la chiusura giuridica della società e non coincide con un singolo
momento di spegnimento tecnico dei servizi.

```text
Internet Force centrale
        |
        +--> clientela e servizi migrati su Enter
        |        |
        |        +--> workstation "marco" riconvertita in server di transizione
        |
        +--> POP progressivamente resi autonomi
                 |
                 +--> Pesaro Point
                 +--> Pointest / Gorgonzola
                 +--> Infosfera / Bergamo
```

## Enter

Internet Force scelse **Enter** come destinazione per la migrazione della propria
clientela e dei servizi centrali. Le configurazioni DNS conservate mostrano Enter
autoritativo per `internetforce.com` e `intf.com`, con file datati ottobre 1996,
e la macchina `marco` nella rete Enter a `194.20.50.14`. Su `marco` convergevano
ruoli che erano stati dell'ambiente Internet Force - `mailhost`, `users`, `mail`,
`loghost` - insieme agli MX di `internetforce.com` e `intf.com`; il feed `news`
puntava a `news.enter.it`.

La workstation Linux `marco` fu quindi riconfigurata come **server di
transizione**, per spostare clienti e servizi riducendo al minimo i cambiamenti
percepiti dagli utenti. L'ambiente Enter conserva configurazioni Cisco sia
Internet Force sia Enter; è descritto in
[`systems/enter/`](../systems/enter/README.md).

## Pesaro e Pesaro Point

Il materiale di **Pesaro Point** è tra i più completi. Un documento di collaudo
datato **22 ottobre 1996**, firmato da Gennaro Mascini per Pesaro Point srl,
dichiara funzionanti e conformi alle specifiche concordate i server realizzati da
Marco Iannacone per Pesaro Point.

L'archivio conserva inoltre configurazioni Cisco 2501/2511, configurazioni DNS
(anche per un named Windows NT), componenti Linux e NT, materiale di routing e le
modifiche successive del **marzo 1997**: permette così di seguire l'evoluzione
del POP verso un'infrastruttura autonoma dopo la prima migrazione. Questi
materiali sono raccolti in
[`systems/pops/pesaro/post-internet-force/`](../systems/pops/pesaro/post-internet-force/).

## Gorgonzola e Pointest

Il materiale **Pointest** documenta la costruzione di servizi locali per l'ex POP
di Gorgonzola: componenti per BIND/DNS, POP3, XTACACS, configurazioni Cisco 2511,
la configurazione del filesystem Linux e componenti NT.

`pointest.com` era il dominio associato al POP di Gorgonzola; nella fase iniziale
era ospitato centralmente su DATA. Lo snapshot del sito personale
[`pippo.com` del 1997](../systems/marco/personal-web/pippo.com-1997/README.md)
usa proprio i CGI serviti da `pointest.com` per il contatore e il form di
contatto. Il materiale Pointest è raccolto in
[`systems/pops/gorgonzola/pointest/`](../systems/pops/gorgonzola/pointest/).

## Infosfera / Bergamo

Il materiale **Bergamo / Infosfera** conserva una configurazione Cisco 2511 e un
sistema Linux `sax` sul quale, in un'istantanea dei processi, risultano attivi
servizi fra cui `named`, `xtacacsd` e `sendmail`; è presente anche una macchina
NT dedicata ad altri servizi. In questo ambiente l'autenticazione XTACACS
risultava attiva sul server **Linux**, non sulla macchina NT - un dettaglio che
aiuta a non confondere ambienti e fasi diverse. Vedi
[`systems/infosfera-bergamo/`](../systems/infosfera-bergamo/README.md).

## Il lavoro di consulenza dopo la chiusura

La chiusura di Internet Force non pose fine al lavoro tecnico di Marco Iannacone.
Nei mesi successivi continuò a operare come **consulente** per diversi provider
nati o evoluti dagli ex POP, con **interventi distinti e adattati alle esigenze
di ciascuna realtà** e finalizzati a renderne autonoma l'infrastruttura. Non fu un
unico programma di migrazione standardizzato: a seconda del contesto il lavoro
poteva riguardare DNS, routing, configurazione Cisco, autenticazione, servizi di
posta, sistemi Unix/Linux, componenti Windows NT e la costruzione o il
completamento di un'infrastruttura di servizio autonoma.

Il materiale di Pesaro, Pointest/Gorgonzola e Bergamo/Infosfera va letto come
documentazione di questi incarichi distinti e della progressiva trasformazione di
POP centralizzati in infrastrutture autonome. **Enter** è in parte diverso:
rappresenta la **destinazione di migrazione** e l'ambiente di transizione per i
clienti e i servizi centrali, e `marco` divenne parte di quell'infrastruttura.

## Configurazioni di momenti diversi

Una parte delle configurazioni conservate appartiene a momenti successivi alla
chiusura di Internet Force. Lo stesso POP o la stessa macchina possono comparire
in più versioni, con indirizzamenti o servizi che cambiano nel tempo: è normale,
e queste versioni non vanno artificiosamente armonizzate. Le configurazioni del
periodo Internet Force restano distinte da quelle della fase successiva - ad
esempio le configurazioni del POP di Pesaro durante Internet Force sono separate
dal materiale della fase post-Internet-Force.

## Che cosa conservano gli archivi

- **Enter** — configurazioni Cisco Internet Force/Enter e un insieme DNS con le
  zone `internetforce.com`, `intf.com`, `enter.it` e altre, più le zone inverse
  `194.20.50`, `194.185.74`, `194.185.100`, `206.20.95`.
- **Pesaro** — collaudo Pesaro Point (22 ottobre 1996), configurazioni Cisco
  2501/2511 (anche Fano), DNS Linux e Windows NT, routing e modifiche del marzo
  1997.
- **Pointest** — servizi locali per Gorgonzola: XTACACS, POP3, BIND/DNS, Cisco
  2511, filesystem Linux e componenti NT.
- **Bergamo** — Infosfera/Bergamo: configurazione Cisco 2511, dati di sistema
  Linux `sax` e istantanea dei processi.

Restano alcune lacune: la data esatta di chiusura di Internet Force, l'elenco
completo dei POP migrati e la loro sorte, e il dettaglio amministrativo della
migrazione dei clienti verso Enter non sono del tutto documentati. Non vengono
inventate transizioni per colmarli.

Per la provenienza del materiale recuperato vedi
[Provenienza dell'archivio](archive-provenance.md); per la riconfigurazione della
workstation `marco` vedi [La workstation di Marco](../systems/marco/README.md).

## Fonti e contesto

Alcuni dati di mercato sono usati solo come contesto e come ordine di grandezza:

- *Video On Line* — fondazione 1993/1994, circa 15.000 abbonati nel 1995,
  acquisizione da parte di Telecom Italia nel giugno 1996:
  <https://it.wikipedia.org/wiki/Video_On_Line>.
- *Tiscali* — fondazione nel gennaio 1998 e lancio nel 1999 del servizio gratuito
  FreeNet: <https://it.wikipedia.org/wiki/Tessellis>, e il lancio di FreeNet
  riportato da *la Repubblica*, 28 gennaio 1999.
- Audizione parlamentare dell'ottobre 1996 (STET): il mercato Internet italiano
  era descritto come ancora in fase iniziale.

I dati relativi a Internet Force (oltre 2.000 abbonati nella fase di espansione del 1996) e la lettura retrospettiva
sono ricostruzione e opinione dell'autore/curatore.

---

Vedi anche: [Note storiche](09-historical-notes.md) ·
[Crescita della rete 1995 → 1996](13-network-growth-1995-1996.md) ·
[Provenienza dell'archivio](archive-provenance.md)
