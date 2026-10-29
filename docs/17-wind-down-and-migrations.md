🇮🇹 **Italiano** · [🇬🇧 English](17-wind-down-and-migrations.en.md)

# La chiusura di Internet Force e le evoluzioni successive

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

Internet Force operò nel 1995–1996 e chiuse mentre il mercato italiano
dell'accesso a Internet era ancora molto piccolo. Le configurazioni e i
documenti conservati permettono di seguire questo passaggio e le evoluzioni
successive.

Internet Force non fu semplicemente spenta. La dismissione dell'infrastruttura fu
**progettata e organizzata da Marco Iannacone** in modo da ridurre al minimo
l'interruzione del servizio, consentire ai POP che intendevano proseguire
l'attività di diventare autonomi e garantire continuità ai clienti con servizi
già attivi.

La sequenza fu deliberatamente progressiva. Prima vennero separati i POP
periferici. Soltanto dopo che questi erano diventati autonomi fu eseguita la
migrazione finale dei clienti di Milano e dei servizi centrali verso Enter.

Questa distinzione è importante: Internet Force non venne trasferita in blocco a
un nuovo provider. La sua infrastruttura venne **decomposta in più reti
indipendenti**, con nuovi collegamenti, nuovi indirizzi IP, servizi locali e
account utenti separati per POP. Enter ricevette soltanto la parte residua di
Milano.

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

La mia lettura retrospettiva è che **Internet Force chiuse troppo presto**: i soci valutarono l'economia del
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
Internet Force operativo
        |
        +--> POP resi progressivamente autonomi
        |        |
        |        +--> nuovo link COMM 2000
        |        +--> nuovo spazio IP pubblico
        |        +--> rinumerazione apparati
        |        +--> servizi locali
        |        +--> copia degli account dei clienti del POP
        |        |
        |        +--> Pesaro Point
        |        +--> Pointest / Gorgonzola
        |        +--> Infosfera / Bergamo
        |        +--> altri ambienti documentati dal repository
        |
        +--> restano Milano + servizi centrali
                 |
                 +--> `marco` reinstallata con Linux
                 +--> dati USERS + DATA copiati preventivamente
                 +--> clienti Milano avvisati dei nuovi numeri Enter
                 |
                 +--> shutdown finale Internet Force
                 +--> trasporto fisico di `marco` a Enter
                 +--> nuovo IP 194.20.50.14
                 +--> virtual IP Web
                 +--> DNS aggiornato
                 +--> servizi riattivati
                 |
                 +--> ~2 ore di downtime complessivo
```

## Rendere autonomi i POP

La prima fase della dismissione consistette nel rendere autonomi i POP che
volevano continuare a operare.

Durante la vita di Internet Force i POP dipendevano dall'infrastruttura centrale
per elementi essenziali, fra cui l'indirizzamento fornito nel contesto del
collegamento IDT e l'autenticazione centralizzata su USERS. Per trasformare un POP
in un ISP indipendente non bastava quindi lasciargli router, modem e linee
telefoniche.

Per ciascun POP occorreva prima ottenere:

- un nuovo collegamento verso Internet;
- un nuovo spazio di indirizzamento IPv4 pubblico;
- una configurazione autonoma dei router e dell'access server;
- servizi locali, compresa l'autenticazione;
- gli account dei soli utenti appartenenti a quel POP.

Il carrier utilizzato per i collegamenti e gli indirizzi della fase di autonomia
fu **COMM 2000**.

L'attesa per il nuovo link e per gli IP era un vincolo concreto del piano di
migrazione. Gli apparati non potevano essere semplicemente staccati dalla rete
Internet Force mantenendo gli indirizzi `206.20.*` usati sotto IDT: una volta
entrati nella rete del nuovo carrier dovevano essere rinumerati e le relative
configurazioni dovevano essere adattate.

Quando l'infrastruttura locale era pronta, Marco Iannacone copiava sui sistemi del
nuovo POP gli account degli utenti di sua pertinenza. In questo modo ogni POP
portava con sé la propria clientela invece di continuare a dipendere dal database
utenti centrale.

Le configurazioni sopravvissute rendono visibile questa separazione:

- Pesaro Point utilizza successivamente indirizzi `195.120.225.*`;
- Pointest, nato dall'ex POP di Gorgonzola, utilizza `194.133.145.*`, con
  `shelley.pointest.com` documentato a `194.133.145.2`;
- Infosfera/Bergamo utilizza `194.235.140.*`, e il Cisco 2511 conservato contiene
  `async default ip address 194.235.140.230`.

Questi indirizzi non sono semplici dettagli di configurazione: sono la traccia del
momento in cui reti che prima facevano parte di Internet Force iniziarono a vivere
autonomamente.

Per l'analisi completa dell'indirizzamento e del renumbering, vedi
[Indirizzamento IP: spazio pubblico, backbone privato e dipendenza dal
carrier](24-ip-addressing-and-provider-space.md).

## Il ruolo di COMM 2000

COMM 2000 era un operatore di telecomunicazioni milanese nato nel 1985 e uno dei
pionieri italiani dei servizi privati di telecomunicazione alternativi al
monopolio pubblico. Negli anni Novanta si sviluppò anche come Internet Service
Provider rivolto in particolare al mercato aziendale.

Nella dismissione di Internet Force ebbe un ruolo molto specifico: **fornì ai POP
che venivano resi autonomi il nuovo collegamento e il nuovo spazio di
indirizzamento pubblico**. Questo consentì di portarli fuori dalla rete Internet
Force/IDT e di configurarli come infrastrutture indipendenti.

La fonte per il ruolo di COMM 2000 nella migrazione è la testimonianza diretta di
Marco Iannacone, che progettò e gestì tecnicamente la dismissione. I reperti di
configurazione documentano in modo indipendente il risultato del processo,
mostrando i nuovi e distinti spazi IP utilizzati dai POP dopo il distacco.

Nel 2000 COMM 2000 fu acquisita da KPNQwest e cambiò denominazione in KPNQwest
Italia. Dallo stesso gruppo era nata nel 1999 Messagenet.

## Milano fu l'ultimo passaggio

La migrazione dei clienti e dei servizi centrali verso Enter avvenne **dopo**
l'autonomizzazione dei POP.

Questo significa che Enter non ricevette l'intera clientela Internet Force. Gli
utenti appartenenti ai POP già separati erano stati trasferiti sulle rispettive
infrastrutture autonome. **Verso Enter andarono soltanto i clienti di Milano.**

La parte centrale rimasta doveva però continuare a fornire i servizi che fino a
quel momento erano distribuiti soprattutto fra USERS e DATA.

Per preparare il passaggio, Marco Iannacone riformattò la propria workstation
Linux `marco`, reinstallò Linux e la predispose come macchina di transizione
capace di assorbire i servizi centrali necessari. Finché Internet Force era ancora
acceso, copiò su `marco` i dati provenienti da USERS e DATA.

Parallelamente, i clienti di Milano vennero informati via email dei nuovi numeri
telefonici dial-up da utilizzare su Enter.

Il sistema era quindi preparato prima dello shutdown. Restava da eseguire il
cutover.

## Le circa due ore dello shutdown finale

Il passaggio finale non fu una migrazione remota. Fu anche uno spostamento fisico
del server.

Quando tutto fu pronto, Marco Iannacone eseguì lo shutdown dell'infrastruttura
Internet Force. `marco`, già preparata e contenente i dati necessari provenienti
da USERS e DATA, venne scollegata.

La macchina fu quindi **trasportata personalmente da Marco presso Enter**.

Nelle circa due ore dello shutdown finale:
1. collegai e riaccesi `marco` sulla rete Enter;
2. cambiai il suo indirizzo IP per adattarlo allo spazio del nuovo provider;
3. configurai i virtual IP necessari per ospitare i diversi servizi Web;
4. modificai i record DNS;
5. riattivai e verificai i servizi.

Il nuovo indirizzo principale documentato per `marco` nella rete Enter è:

`194.20.50.14`

Le configurazioni DNS recuperate mostrano che sulla macchina convergono
successivamente nomi e ruoli precedentemente distribuiti nell'ambiente Internet
Force, fra cui `users`, `mail`, `mailhost`, `loghost` e gli MX di
`internetforce.com` e `intf.com`.

**Circa due ore dopo lo shutdown dell'infrastruttura Internet Force, i servizi
erano nuovamente disponibili.**

I clienti di Milano potevano collegarsi utilizzando i nuovi numeri dial-up Enter
che erano stati comunicati loro in precedenza.

Il dettaglio delle operazioni conta perché mostra cosa significasse concretamente
una migrazione ISP nel 1996: preparazione dei dati prima del cutover, renumbering,
DNS, virtual IP e perfino il trasporto fisico della macchina che avrebbe mantenuto
in vita i servizi.

## Enter

Internet Force scelse **Enter** come destinazione per la migrazione della propria
clientela e dei servizi centrali. Le configurazioni DNS conservate mostrano Enter
autoritativo per `internetforce.com` e `intf.com`, con file datati ottobre 1996;
il feed `news` puntava a `news.enter.it`. L'ambiente Enter conserva
configurazioni Cisco sia Internet Force sia Enter ed è descritto in
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

## Cronologia e basi delle affermazioni

| Affermazione | Base |
|---|---|
| La dismissione tecnica fu progettata e organizzata da Marco Iannacone | RECOLLECTION |
| I POP furono resi autonomi prima della migrazione finale verso Enter | RECOLLECTION + DOCUMENTED |
| COMM 2000 fornì ai POP autonomi nuovi collegamenti e nuovo spazio IP pubblico | RECOLLECTION; renumbering DOCUMENTED dalle configurazioni successive |
| Gli account utenti furono separati per POP e copiati sulle rispettive macchine | RECOLLECTION |
| Solo i clienti di Milano furono migrati verso Enter | RECOLLECTION |
| `marco` fu riformattata/reinstallata e predisposta prima dello shutdown per assorbire dati e servizi di USERS e DATA | RECOLLECTION + DOCUMENTED per il risultato finale |
| I clienti Milano ricevettero via email i nuovi numeri dial-up Enter prima del cutover | RECOLLECTION |
| `marco` fu trasportata fisicamente da Internet Force a Enter durante il cutover | RECOLLECTION |
| `marco` nella rete Enter aveva indirizzo `194.20.50.14` | DOCUMENTED |
| Il cutover finale incluse nuovo IP, virtual IP Web e aggiornamento DNS | RECOLLECTION + DOCUMENTED per IP/DNS |
| Downtime complessivo del cutover finale circa due ore | RECOLLECTION |

Nota metodologica: `RECOLLECTION` è una **fonte primaria**, non un sinonimo di
informazione "non affidabile". La classificazione serve a distinguere la
provenienza dell'evidenza, non a stabilire una gerarchia automatica di valore.

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
[Indirizzamento IP](24-ip-addressing-and-provider-space.md) ·
[Provenienza dell'archivio](archive-provenance.md)
