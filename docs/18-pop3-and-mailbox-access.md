🇮🇹 **Italiano** · [🇬🇧 English](18-pop3-and-mailbox-access.en.md)

# POP3 e accesso alla mailbox

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

Questo capitolo riguarda un concetto distinto dal
[trasporto della posta](04-email.md): qui si spiega come il **cliente** andava a
**leggere** la posta già consegnata.

- **SMTP / Sendmail** → trasporto e consegna del messaggio;
- **POP3 / IMAP** → accesso del cliente alla propria mailbox.

## Quale problema risolve

Il cliente dial-up non possiede un server di posta: la sua casella vive sul server
centrale. Serve quindi un servizio che gli consegni i messaggi accumulati, sulla
connessione dial-up, dal client di posta dell'epoca (Pine, Eudora, …).

## Come lo implementava Internet Force

La mailbox del cliente risiedeva sul server **USERS** (`206.20.95.4`). Poiché
Internet Force usava un modello di **accesso per utente**, la maildrop era il file
`.mailbox` nella home del cliente, non lo spool di sistema. Erano attivi due
protocolli, entrambi avviati da `inetd`:

- **POP3** — il server Berkeley `popper` (versione 1.6);
- **IMAP** — `/usr/local/etc/imapd`, per tenere la posta sul server e leggerla da
  più client.

Poiché la mailbox stava sul server centrale, la posta era raggiungibile da
qualunque POP: non era legata a una particolare linea dial-up, ma solo
all'account.

## MUA, MTA, MDA: cosa succedeva davvero a un messaggio

Dietro quella che per l'utente era semplicemente “la posta elettronica”
c'erano già ruoli differenti.

Il **Mail User Agent (MUA)** era il programma con cui l'utente scriveva
e leggeva i messaggi: Eudora, Pine, Elm o altri client dell'epoca. Il
**Mail Transfer Agent (MTA)** riceveva invece i messaggi e li instradava
verso altri sistemi SMTP. Quando il messaggio raggiungeva il sistema di
destinazione entrava infine in gioco la funzione di **Mail Delivery
Agent (MDA)**, responsabile della consegna locale nella mailbox
dell'utente. MTA e MDA non dovevano necessariamente corrispondere a
programmi o daemon separati: sono soprattutto ruoli diversi all'interno
del percorso della posta.

Oggi si distingue normalmente anche il **Message Submission Agent
(MSA)**, cioè il servizio al quale il client dell'utente consegna un
messaggio appena scritto perché entri nel sistema di posta. Nel
1995-1996 questa separazione non era ancora formalizzata come lo sarebbe
stata in seguito: submission e trasferimento SMTP passavano normalmente
attraverso la stessa infrastruttura e spesso attraverso lo stesso
Sendmail sulla porta 25. La definizione formale del Message Submission
Agent e della porta 587 sarebbe arrivata solo nel 1998.

Il percorso concettuale era quindi:

**MUA → submission SMTP → MTA → rete SMTP → MTA destinatario → MDA →
mailbox → POP3/IMAP → MUA**

Nel caso di Internet Force, [Sendmail](04-email.md) svolgeva il ruolo
centrale nel trasporto SMTP, mentre POP3 e IMAP permettevano poi agli
utenti di accedere ai messaggi conservati sul
[sistema USERS](../systems/users/README.md).

## Sendmail e la filosofia Unix

Sendmail non era famoso per la semplicità della sua configurazione:
`sendmail.cf` poteva diventare notevolmente complesso. Il modello su cui
si basava era però estremamente flessibile e rifletteva bene la
filosofia Unix: piccoli componenti che potevano essere collegati fra
loro.

La destinazione di una mail non doveva necessariamente essere un'altra
mailbox. Alias e file `.forward` potevano inoltrare il messaggio a un
altro indirizzo, scriverlo in un file oppure passarlo direttamente,
tramite una **pipe**, allo standard input di un programma.

Una mail ricevuta poteva quindi diventare l'input di uno script o di
un'applicazione locale. Molte funzioni che oggi verrebbero descritte
come workflow, automazioni o integrazioni potevano essere realizzate
semplicemente collegando il sistema di posta a un programma Unix.

Un esempio particolarmente quotidiano era l'**out of office**. Nei
sistemi Unix dell'epoca non serviva un server groupware per ottenerlo:
il comando `vacation`, utilizzato insieme al file `.forward`, poteva
intercettare la posta destinata all'utente e rispondere automaticamente
con il testo contenuto nel suo `.vacation.msg`. Il programma manteneva
anche memoria dei mittenti ai quali aveva già risposto, evitando di
spedire continuamente lo stesso messaggio alla stessa persona.

Era una soluzione estremamente semplice dal punto di vista
architetturale: ogni utente Unix disponeva già degli strumenti
necessari per costruire un proprio piccolo comportamento automatico
della posta.

## Prima che l'email diventasse un canale di marketing

Anche il ruolo sociale della posta elettronica era diverso. Nel
1995-1996 l'email era soprattutto uno strumento diretto di comunicazione
personale, tecnica e professionale. La posta commerciale indesiderata
esisteva già, ma non aveva ancora raggiunto la scala, l'automazione e il
peso che il marketing e lo spam avrebbero assunto negli anni
successivi.

Nella cultura della rete era inoltre forte l'idea che una mail
meritasse una risposta in tempi brevi. Una regola pratica molto diffusa,
più di netiquette che di protocollo, era cercare di rispondere entro
circa **48 ore**; per un messaggio importante era considerato corretto
anche mandare subito una breve conferma di ricezione e rispondere con
più calma successivamente.

Era quindi un mezzo asincrono, ma non veniva normalmente trattato come
un deposito nel quale lasciare indefinitamente i messaggi in attesa.

## Un mittente era quello che dichiarava di essere

Quella cultura di apertura aveva però un'altra conseguenza: l'identità
del mittente non era intrinsecamente garantita dal protocollo SMTP.

Un classico esperimento per chi imparava come funzionava Internet
consisteva semplicemente nel **fare Telnet sulla porta 25 di un server
SMTP**. Dopo il saluto `HELO` si poteva proseguire il dialogo SMTP
dichiarando un `MAIL FROM` arbitrario e costruendo manualmente il
messaggio, compreso il campo `From:`. Era quindi perfettamente possibile
mandarsi, per gioco, una mail che apparentemente proveniva da Bill Gates
o da qualsiasi altro indirizzo scelto.

Non occorreva conoscere la password di quella persona né violare il
suo account. Il protocollo SMTP originario era stato progettato in una
rete basata molto più sulla cooperazione fra sistemi che sulla verifica
crittografica dell'identità dichiarata dal mittente.

È importante distinguere anche due livelli: il `MAIL FROM` della
conversazione SMTP appartiene all'**envelope** usato per il trasporto,
mentre il campo `From:` fa parte delle intestazioni del messaggio che
l'utente legge. Storicamente entrambi potevano essere dichiarati senza
che SMTP fornisse di per sé una prova dell'identità della persona che
stava inviando il messaggio.

La separazione moderna fra submission autenticata e trasferimento fra
server, insieme a meccanismi come SPF, DKIM e DMARC, sarebbe arrivata
molto più tardi. L'email funzionava perché la rete era stata progettata
prima di tutto per permettere ai sistemi di comunicare; soltanto con la
crescita di Internet sarebbe diventato necessario costruire sopra quel
modello livelli sempre più articolati di autenticazione, reputazione e
controllo degli abusi.

## Componenti e host

- **USERS** (`206.20.95.4`) — popper / imapd.
- L'access server del POP (trasporto della sessione dial-up).
- Il client di posta del cliente.

## Evidenza rappresentativa

Il materiale dell'ambiente Pointest/Gorgonzola conserva la configurazione del
servizio POP3 (`systems/pops/gorgonzola/pointest/Linux/popper/POPPER`), che
documenta come il servizio popper fosse impiegato in un POP Internet Force reso autonomo da
Marco dopo la chiusura di Internet Force.

→ Configurazione/evidenza completa:
[`systems/pops/gorgonzola/pointest/Linux/popper/POPPER`](../systems/pops/gorgonzola/pointest/Linux/popper/POPPER)

## Come si collega al resto del POP

Dipende dalla [posta](04-email.md) per la consegna e dalla
[autenticazione](10-authentication-tacacs.md) per identificare l'utente della
sessione. Il servizio è ospitato su USERS, uno dei
[server centrali](01-architecture.md).

## Materiale originale correlato

- [`docs/04-email.md`](04-email.md) — trasporto SMTP e consegna.
- [`systems/users/README.md`](../systems/users/README.md) — il server USERS.

---

← [Costruire un POP](00-build-an-isp.md) ·
Precedente: [Posta (Sendmail)](04-email.md) ·
Prossimo: [Web server](05-web-news-ftp.md) →
