🇮🇹 **Italiano** · [🇬🇧 English](25-xpert-ip-accounting-xacct.en.md)

# Da Xpert a XACCT: l'IP accounting dentro Internet Force

> **Internet Force 1995–1996 Historical Archive**  
> Autore e curatore: Marco Iannacone · https://pippo.com  
> Licenza: [CC BY 4.0](../LICENSE)

Nel 1995 Internet Force aveva già in produzione una tecnologia che cercava di rispondere a una domanda molto diversa dal semplice *“l'utente è collegato?”*: **chi sta usando la rete, quali risorse o servizi sta usando e quanto li sta usando?**

Era questo, in termini pratici, il significato dell'**IP accounting**.

Il software Xpert installato in Internet Force non era un normale monitor di traffico e non era neppure soltanto l'accounting delle sessioni dial-up. Serviva a raccogliere e attribuire l'uso della rete IP, trasformando il traffico in dati associabili a utenti, sessioni e servizi. Quei dati potevano essere usati per analisi e controllo, ma soprattutto rendevano tecnicamente possibile qualcosa che allora era tutt'altro che normale: **far dipendere il prezzo non soltanto dall'accesso a Internet, ma dall'uso effettivo della rete e dei servizi**.
Ma, per capire meglio, torniamo un attimo indietro a quei tempi.

A metà degli anni Novanta il prodotto venduto dagli ISP era normalmente l'accesso: un abbonamento, spesso flat dal punto di vista del provider Internet, eventualmente combinato con i costi telefonici della chiamata dial-up. La rete sapeva chi si era autenticato e per quanto tempo, ma non era normale costruire una tariffazione Internet sulla base del dettaglio di ciò che l'utente aveva consumato a livello IP.

Xpert stava lavorando esattamente su quel passaggio.

**La versione della tecnologia installata in Internet Force fu una delle prime versioni prototipali di ciò che poco dopo sarebbe diventato XACCT.** Non aveva ancora il nome del prodotto e della società che sarebbero nati nel 1997. Era ancora software Xpert, usato in un ambiente operativo reale, ma il problema affrontato, il modello di raccolta dei dati e la visione commerciale erano già quelli che avrebbero portato a XACCT Technologies.

Il pacchetto sopravvissuto nei backup e conservato oggi nel repository è:

- [`artifacts/tools/addr_stats.shar`](../artifacts/tools/addr_stats.shar), shell archive Xpert (`Wrapped by xpert.com`, 1996) con contenuto dichiarato `Xpert IP accounting`;
- è inoltre conservato [`artifacts/scripts/IP_ADDRESS_NOTI_DEBUG.txt`](../artifacts/scripts/IP_ADDRESS_NOTI_DEBUG.txt), materiale operativo collegato al lavoro sugli indirizzi e sul tracciamento.

**Il cuore della soluzione, però, non era `addr_stats` da solo. L'elemento principale era un modulo installato nel kernel del firewall.** Quel modulo osservava il traffico IP nel punto in cui attraversava il firewall e permetteva di distinguerne la natura, per esempio HTTP, SMTP, FTP e altri tipi di traffico. Il modulo non è purtroppo sopravvissuto nei backup.

Cisco e XTACACS fornivano l'altra metà del problema: contribuivano a stabilire **chi** fosse l'utente e **come** quella sessione fosse instradata. Il modulo sul firewall permetteva di capire **che cosa** stesse passando; access server, autenticazione, indirizzi assegnati e routing permettevano di ricondurre quel traffico alla sessione e all'utente.

In forma semplificata, l'architettura era quindi:

```text
Cisco 2511 / PPP
    -> sessione e indirizzo IP assegnato
             |
             v
XTACACS
    -> identità dell'utente e dati di accesso
             |
             v
routing Cisco
    -> contesto e percorso della sessione
             |
             v
firewall + modulo kernel Xpert
    -> osservazione e classificazione del traffico
       HTTP / SMTP / FTP / ...
             |
             v
software di accounting
    -> attribuzione dell'IP usage
```

Non era quindi un sistema che si limitava a leggere log dopo l'evento. **La raccolta primaria avveniva nel firewall, a livello kernel, direttamente sul traffico in transito.**

Il nome `addr_stats` è quasi più interessante, col senno di poi, di un'etichetta commerciale: fotografa il software **prima** che quella linea tecnologica diventasse un prodotto autonomo chiamato XACCT.

Internet Force usò quella capacità per il tracciamento dell'IP usage. **Non la usò mai per fatturare i clienti in base al traffico o ai servizi consumati.** Il passo successivo venne fatto altrove, in particolare nel progetto Xpert in Marocco che avrebbe avuto un ruolo decisivo nella nascita di XACCT.

---

## 1. Che cosa significava IP accounting

In una rete dial-up tradizionale era relativamente facile sapere che un cliente si era collegato.

Il Cisco access server riceveva la chiamata, TACACS autenticava l'utente e l'accounting poteva registrare eventi come login, logout e durata della sessione.

Queste informazioni rispondevano a domande del tipo:

```text
chi si è collegato?
quando?
per quanto tempo?
da quale access server?
```

L'IP accounting affrontava un problema diverso.

Una volta autenticato, un utente poteva generare traffico verso molte destinazioni e utilizzare servizi differenti. Per rendere quell'uso economicamente significativo bisognava raccogliere dati dalla rete, attribuirli correttamente e produrre record utilizzabili da sistemi di analisi e, potenzialmente, di billing.

Le domande diventavano quindi:

```text
quale utente o sessione ha generato questo traffico?
quanto traffico ha prodotto?
verso quali risorse?
utilizzando quali servizi?
come posso trasformare questi eventi in record di utilizzo?
```

È una differenza sostanziale.

**SNMP/tkined** serviva a sapere se la rete funzionava e quanto erano utilizzati apparati e link.

**XTACACS** serviva ad autenticare e a registrare l'accesso.

**Il software Xpert di IP accounting** cercava invece di attribuire l'utilizzo effettivo della rete IP.

Sono tre livelli diversi:

```text
monitoring operativo
    rete e apparati

access accounting
    utenti e sessioni

IP usage accounting
    utilizzo della rete e dei servizi
```

Il terzo livello era quello necessario per arrivare allo usage-based billing.

---

## 2. Perché nel 1995 era un'idea innovativa

Oggi siamo abituati a sistemi che misurano ogni evento digitale: API call, byte trasferiti, minuti di CPU, storage, messaggi, transazioni, contenuti e funzionalità utilizzate.

Nel 1995 il mondo ISP era molto più semplice.

Il prodotto commerciale era principalmente **l'accesso a Internet**. Il cliente comprava la possibilità di collegarsi alla rete; il provider doveva autenticarlo, instradare il traffico e fornire i servizi di base. La granularità economica era normalmente l'abbonamento o, in alcuni modelli, il tempo di connessione. I costi telefonici della chiamata dial-up erano un altro livello ancora.

L'idea di Xpert era spostare il punto di osservazione più in profondità:

**non vendere soltanto il diritto di entrare in Internet, ma poter misurare ciò che avveniva una volta entrati.**

Questo apriva scenari completamente differenti. Un operatore avrebbe potuto distinguere utenti, organizzazioni, volumi e servizi e costruire modelli tariffari sulla base dell'uso effettivo.

Limor Schweitzer presentò questa capacità ai soci di Internet Force come **strategica e fortemente innovativa**. La sua previsione era che il mercato si sarebbe mosso in quella direzione e che Internet Force, disponendo già di una tecnologia che altri ISP non avevano, avrebbe potuto avere un vantaggio competitivo enorme.

I soci apprezzarono la soluzione e decisero di installarla.

La tecnologia arrivò effettivamente nell'infrastruttura. Il modello commerciale no.

Internet Force continuò a vendere i propri servizi senza fatturare il traffico IP misurato.

---

## 3. Il software sopravvissuto e il modulo kernel del firewall

Una parte particolarmente interessante dell'archivio è che non è rimasto soltanto il ricordo del sistema.

L'architettura completa era composta da più elementi. **Il componente principale era un modulo Xpert caricato nel kernel del firewall**, che osservava il traffico mentre attraversava il sistema e ne permetteva la classificazione per tipo di servizio, distinguendo per esempio HTTP, SMTP e FTP. Il modulo kernel non è sopravvissuto nei backup recuperati.

Questa collocazione era fondamentale: il firewall era il punto nel quale il traffico fra utenti, servizi interni e Internet poteva essere osservato in transito. Il modulo Xpert trasformava quindi il firewall anche in un punto di raccolta degli eventi necessari all'IP accounting.

Cisco e XTACACS completavano la correlazione. Il Cisco 2511 gestiva la sessione PPP e l'indirizzo IP assegnato; XTACACS identificava l'utente e registrava l'accesso; il routing forniva il contesto di rete. Combinando queste informazioni con gli eventi raccolti dal modulo del firewall diventava possibile associare il tipo di traffico osservato alla sessione e, quindi, all'utente.

Questo era il passaggio tecnologicamente importante: **non soltanto contare pacchetti o byte su un'interfaccia, ma riconoscere il traffico e attribuirlo a chi lo stava generando**.

Il componente kernel è andato perduto, mentre una parte user-space della soluzione è sopravvissuta.

Nel repository è conservato il pacchetto storico [`artifacts/tools/addr_stats.shar`](../artifacts/tools/addr_stats.shar).

Si tratta di uno *shell archive*, un formato molto comune nell'ecosistema Unix dell'epoca: un file eseguibile che, una volta lanciato, ricreava il contenuto del pacchetto. Il pacchetto conservato si dichiara `Wrapped by xpert.com` nel novembre 1996 e il contenuto è indicato come `Xpert IP accounting`.

Il nome `addr_stats` rende esplicito lo scopo del pacchetto: produrre statistiche basate sugli indirizzi, cioè trasformare eventi e traffico IP in informazioni attribuibili e analizzabili.

Il repository conserva inoltre [`artifacts/scripts/IP_ADDRESS_NOTI_DEBUG.txt`](../artifacts/scripts/IP_ADDRESS_NOTI_DEBUG.txt), parte del materiale operativo relativo all'indirizzamento e al debugging del meccanismo.

Questi file non vanno letti come se fossero la versione finale di XACCT ritrovata trent'anni dopo. Sarebbe storicamente sbagliato per il motivo opposto.

**Sono una versione prototipale precedente a XACCT, appartenente alla linea software Xpert dalla quale XACCT sarebbe nata.**

XACCT Technologies non esisteva ancora. Il marchio, l'architettura commerciale e il prodotto carrier-grade sarebbero arrivati dopo. Ma la funzione di fondo era già presente: raccogliere dati sull'utilizzo IP e renderli utilizzabili oltre il semplice monitoring della rete.

È precisamente questo che rende il pacchetto importante nell'archivio Internet Force.

---

## 4. Xpert e Internet Force: molto più di un fornitore

Xpert Integrated Systems era stata fondata nel 1993 da **Limor Schweitzer ed Eran Wagner**. Nei primissimi tempi Xpert acquisì la società che **Yahel Ben-David** aveva fondato ad Haifa; Yahel entrò così nel nucleo del gruppo ed è infatti indicato in successive biografie come *co-founder of the Xpert Group*.

**Yossi Gottlieb** era il giovanissimo tecnico del gruppo, già allora considerato un fenomeno dal punto di vista tecnico.

Marco Iannacone lavorò direttamente con **Limor Schweitzer, Eran Wagner, Yahel Ben-David e Yossi Gottlieb**, tutti coinvolti a livelli diversi nella costruzione di Internet Force come consulenza esterna.

Non era quindi il classico rapporto nel quale un cliente acquistava una scatola, riceveva un manuale e apriva un ticket.

Internet Force ebbe accesso diretto al gruppo che progettava e sperimentava quelle tecnologie.

Limor parlava inoltre italiano: aveva vissuto a Roma nei primi sei anni della propria vita. Quando era a Milano poteva quindi discutere direttamente anche con i soci di Internet Force, cosa particolarmente utile perché non tutti padroneggiavano l'inglese allo stesso livello.

Limor conosceva personalmente anche uno dei fondatori di **Check Point**, la società produttrice di FireWall-1, utilizzato da Internet Force. È plausibile che questo rapporto abbia facilitato lo sviluppo o l'integrazione del modulo kernel Xpert sul firewall; non è però rimasto materiale tecnico sufficiente per ricostruire esattamente quel passaggio.

I rapporti personali continuarono per anni ben oltre Internet Force. **Limor Schweitzer e Yahel Ben-David sono ancora oggi amici personali di Marco Iannacone.**

Questo rapporto diretto è parte della spiegazione di come un piccolo ISP italiano del 1995 si sia trovato a usare tecnologie così vicine al fronte di sviluppo dell'epoca.

---

## 5. Una tecnologia installata, ma un vantaggio mai commercializzato

La soluzione di IP accounting venne apprezzata dai soci e installata.

Internet Force poté quindi tracciare l'utilizzo IP, ma non fece l'ultimo passaggio: **non collegò quei dati alla fatturazione dei clienti**.

Questo punto va mantenuto molto netto perché rende la storia più interessante, non meno.

Internet Force possedeva una capability che avrebbe potuto sostenere un modello commerciale diverso dal semplice abbonamento di accesso, e Limor ne aveva esplicitamente presentato il potenziale competitivo. Tuttavia quel potenziale non venne trasformato in un prodotto commerciale durante la breve vita della società.

Non serve inventare oggi una causa unica. Può darsi che il valore della soluzione non sia stato compreso fino in fondo, che le priorità commerciali fossero altre o semplicemente che Internet Force non abbia avuto il tempo necessario.

Il fatto importante è ciò che accadde:

```text
tecnologia disponibile       sì
IP usage tracking            sì
uso in produzione            sì
billing dei clienti su uso   no
```

---

## 6. Il Marocco: lo stesso concetto portato fino al billing

Nello stesso periodo Xpert lavorò a un progetto per collegare a Internet un'università in Marocco.

Limor ne parlò direttamente a Marco mentre quella linea tecnologica era ancora in evoluzione.

La differenza fondamentale rispetto a Internet Force fu che **nel progetto marocchino l'accounting venne portato fino al billing**.

L'università non voleva soltanto sapere se gli studenti fossero collegati. Il sistema permetteva di sapere come venivano utilizzate le risorse di rete e di attribuire economicamente quell'utilizzo ai diversi dipartimenti.

Era il passaggio completo:

```text
raccolta degli eventi IP
        ↓
attribuzione dell'uso
        ↓
record di accounting
        ↓
rating
        ↓
billing
```

È per questo che la stampa successiva individua nel progetto marocchino il momento nel quale XACCT nacque concettualmente.

*Globes* lo riassunse anni dopo in modo particolarmente efficace: **“XACCT was born in Morocco, at least conceptually.”**

Internet Force e il Marocco rappresentano quindi due punti vicinissimi della stessa traiettoria.

In Internet Force una versione prototipale della tecnologia era già operativa per l'IP accounting, ma non venne usata commercialmente per il billing.

In Marocco lo stesso concetto venne portato fino alla conseguenza economica.

---

## 7. XACCT: il prototipo diventa un prodotto e poi un mercato

Nel maggio 1997 Limor Schweitzer ed Eran Wagner fondarono **XACCT Technologies**.

XACCT trasformò la linea di sviluppo iniziata in Xpert in una piattaforma general-purpose di **network usage accounting, mediation e billing**.

Il problema affrontato era ormai esplicito: raccogliere informazioni da router, switch, server di autenticazione, applicazioni e altre sorgenti; normalizzarle e correlarle; produrre record capaci di dire chi aveva utilizzato quale servizio, quanto e in che modo; consegnare poi quei record ai sistemi di rating, billing e analisi.

Era l'equivalente IP dei dettagli d'uso che il mondo telefonico aveva imparato da tempo a trasformare in fatturazione, applicato però a una rete molto più eterogenea e a servizi che non potevano essere descritti semplicemente come una telefonata iniziata e terminata.

La crescita fu rapidissima.

Nel 1999 XACCT raccolse 22 milioni di dollari a una valutazione post-money di 110 milioni. *Globes* riportava accordi con circa l'80% dei fornitori mondiali di software di billing e citava la tecnologia come **“a de facto standard for pricing on the Internet”**.

Nel 2001 la piattaforma N2B veniva presentata come un collegamento real-time bidirezionale fra infrastruttura IP e applicazioni OSS/BSS, con una base dati capace di sostenere anche il futuro **content billing**.

Quello che Limor aveva raccontato ai soci di Internet Force nel 1995 non era quindi una presentazione commerciale particolarmente fantasiosa.

Era una descrizione molto anticipata di dove stava andando il mercato.

---

## 8. XACCT entra in Amdocs

Alla fine del 2003 Amdocs annunciò l'acquisizione di XACCT Technologies.

Il valore annunciato era di circa **29,5 milioni di dollari**. L'operazione completata nel febbraio 2004 portò a un purchase price contabilizzato di circa **29,175 milioni di dollari**, motivo per cui la stampa dell'epoca parlò normalmente di un'acquisizione da circa **30 milioni di dollari**.

La parte più significativa non è però il prezzo.

Amdocs spiegò che l'acquisizione di XACCT ampliava le proprie capacità di billing nella **network mediation**, consentendo la raccolta, formattazione e distribuzione degli eventi di utilizzo della rete e creando una catena end-to-end dalla mediation al billing per transazioni **voice, data, content e commerce**, prepaid e postpaid.

La sequenza completa diventa così particolarmente leggibile:

```text
Xpert
    prime tecnologie di IP usage accounting
        ↓
Internet Force, 1995-1996
    una versione prototipale è usata in produzione
    tracking sì, billing commerciale no
        ↓
progetto Xpert in Marocco
    accounting portato fino al billing
        ↓
XACCT, 1997
    mediation + usage accounting + billing
        ↓
Amdocs, 2004
    integrazione end-to-end in una piattaforma
    globale di telecom billing
```

---

## 9. Le persone dietro il software

La tecnologia non arrivò in Internet Force per caso.

Limor Schweitzer era il principale interlocutore sulla visione strategica dell'IP accounting.

Eran Wagner faceva parte del nucleo fondatore di Xpert, era più l'uomo Finance, Strategy e Marketing e avrebbe poi fondato XACCT con Limor.

Yahel Ben-David arrivava dal nucleo tecnico di Haifa integrato molto presto in Xpert e contribuì, a livelli diversi, al lavoro sull'infrastruttura Internet Force.

Yossi Gottlieb era il più giovane e aveva già una reputazione quasi mitologica per capacità tecnica.

Il gruppo arrivò perfino a prendere in giro i soci di Internet Force raccontando che Yossi era talmente bravo da riuscire a **riconoscere i file binari ascoltandoli attraverso un altoparlante**.

Marco stette al gioco.

Naturalmente era una battuta. Ma il fatto che risultasse abbastanza plausibile da poter essere raccontata dice parecchio sulla reputazione che Yossi aveva conquistato nel gruppo.

---

## 10. Internet Force come ambiente operativo di tecnologie che stavano nascendo

L'IP accounting Xpert non fu un caso isolato.

Dentro Internet Force convivevano:

- Check Point FireWall-1 e Stateful Inspection;
- virtual IP e virtual hosting;
- PHP/FI durante la prima fase del Web dinamico;
- SNMP e tkined per il monitoraggio della rete;
- XTACACS per autenticazione e access accounting;
- il prototipo Xpert di IP usage accounting che avrebbe portato a XACCT;
- un'architettura Unix e networking costruita lavorando direttamente con persone che stavano sviluppando tecnologie destinate a diventare prodotti e mercati autonomi.

Internet Force non era un laboratorio di ricerca. Era un ISP vero, con clienti veri e sistemi in produzione.

Ed è proprio questo a rendere il caso interessante.

**Tecnologie ancora emergenti non venivano soltanto provate: venivano usate per far funzionare un provider commerciale.**

Il pacchetto `addr_stats` è forse l'esempio più sorprendente perché permette di seguire la stessa idea dal software Xpert conservato nell'archivio, a XACCT, fino alla network mediation e al billing su scala internazionale dentro Amdocs.

---

## Materiale conservato nel repository

- [`artifacts/tools/addr_stats.shar`](../artifacts/tools/addr_stats.shar) — pacchetto storico di IP accounting di Xpert (`Wrapped by xpert.com`, 1996; contenuto dichiarato `Xpert IP accounting`).
- [`artifacts/scripts/IP_ADDRESS_NOTI_DEBUG.txt`](../artifacts/scripts/IP_ADDRESS_NOTI_DEBUG.txt) — materiale operativo relativo all'indirizzamento/debugging.
- [`systems/marco/reference-material/xpert/`](../systems/marco/reference-material/xpert/) — materiale tecnico Xpert conservato fra i file di riferimento della workstation di Marco.
- Nel corpus Xpert sopravvivono anche file DNS relativi a `xacct.com`, successivi alla fase Internet Force e utili a documentare la continuità del materiale conservato.

---

## Riferimenti

- *Globes*, **Xpert: Profiting from a gold rush**: https://en.globes.co.il/en/article-485000
- *Globes*, **Infrastructure product for network service providers**: https://en.globes.co.il/en/article-381562
- *Globes*, **Finally, Amdocs buys XACCT**: https://en.globes.co.il/en/article-753364
- Amdocs, SEC filing on the planned XACCT acquisition, approximately $29.5 million: https://investors.amdocs.com/static-files/5b402036-1ace-4ca3-8884-6909b2d4f804
- Amdocs, SEC filing on the completed acquisition and $29.175 million purchase-price allocation: https://investors.amdocs.com/static-files/e0a85bf4-af43-4ce1-ab4b-53a934de81f0

---

Vedi anche:

- [Monitoraggio](08-monitoring.md)
- [Note storiche](09-historical-notes.md)
- [Autenticazione e XTACACS](10-authentication-tacacs.md)
- [Inventario software](11-software-inventory.md)
- [Provisioning clienti](12-customer-provisioning.md)
- [Persone e workflow](15-people-and-workflows.md)
