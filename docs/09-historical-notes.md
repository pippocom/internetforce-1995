🇮🇹 **Italiano** · [🇬🇧 English](09-historical-notes.en.md)

# Note storiche

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

Internet Force è stato un ISP italiano nato a Milano nel 1995. Questa pagina
raccoglie il contesto organizzativo e storico che sta attorno alla
documentazione tecnica: da dove veniva il progetto, chi l'ha costruito e come il
servizio si è evoluto.

## Xpert UNIX Systems e il periodo di formazione a Tel Aviv

Il progetto tecnico di Internet Force fu sviluppato con **Xpert UNIX Systems**,
una società di consulenza UNIX israeliana, un particolare ruolo ebbe  **Yahel Ben-David**, che
fece da principale mentore tecnico di Marco Iannacone durante il periodo di
build e formazione. Marco trascorse circa sei mesi a Tel Aviv mentre
l'infrastruttura italiana, il collegamento internazionale e l'hardware Sun
venivano preparati.

Di quel periodo sopravvive una notevole quantità di materiale di riferimento.
Fu copiato presso Xpert e riportato a casa come riferimento, e mostra il tipo di
ambiente su cui Internet Force fu modellata: script di boot Linux e SunOS, un
`named.boot` BIND-4 con i domini di Xpert, una configurazione Sendmail, una
prima struttura di configurazione Apache 1.1, strumenti FTP e di accounting.
L'archivio tiene questo materiale separato dalla configurazione di produzione di
Internet Force; è provenienza di riferimento, non configurazione Internet Force.

Il rapporto con Xpert continuò dopo il lancio: la rule base originale del
firewall consente a `xpert.com` accesso talk e remote-login a DVLP e alla
workstation di Marco, che è il percorso di supporto usato durante la prima fase
di build.

## Xpert: le persone dietro una parte dell'infrastruttura

Il rapporto con Xpert fu molto più diretto di un normale rapporto cliente-fornitore.

Marco Iannacone lavorò personalmente con **Limor Schweitzer, Eran Wagner, Yahel Ben-David e Yossi Gottlieb**, coinvolti a livelli diversi nella costruzione tecnica di Internet Force.

Xpert Integrated Systems era stata fondata nel 1993 da Limor Schweitzer ed Eran Wagner. Nei primissimi tempi Xpert acquisì la società che Yahel Ben-David aveva fondato ad Haifa; Yahel entrò così nel nucleo del gruppo ed è infatti indicato in successive biografie come *co-founder of the Xpert Group*.

Limor parlava italiano, avendo vissuto a Roma nei primi sei anni della propria vita, e durante le sue presenze a Milano poteva confrontarsi direttamente anche con i soci di Internet Force.

Fu Limor a presentare l'IP accounting come una tecnologia strategica: la capacità di misurare l'uso reale della rete e dei servizi avrebbe potuto dare a Internet Force un vantaggio competitivo enorme in un mercato nel quale gli ISP vendevano soprattutto accesso flat.

I rapporti personali continuarono molto oltre il progetto. **Limor Schweitzer e Yahel Ben-David sono ancora oggi amici personali di Marco Iannacone.**

Per la linea tecnologica Xpert → prototipo IP accounting in Internet Force → XACCT: [Da Xpert a XACCT](25-xpert-ip-accounting-xacct.md).

## IDT e il collegamento internazionale

Il provider upstream era **IDT**, raggiungibile a New York. Il collegamento
iniziale andava a **128 kbit/s**; circa sei mesi dopo il lancio la capacità
internazionale fu portata a **2 Mbit/s**. Il collegamento IDT definiva il bordo
della rete: il Cisco 2501 centrale portava la default network IDT sulla sua
seriale, indirizzata da `206.20.64.0/24`.

## Nomi e indirizzamento

Internet Force usava i nomi come documentazione. Gli host erano nominati per
ruolo (`data`, `users`, `firewall`, `dvlp`), gli access server erano `ts1` e
così via, e i terminali dial-up erano numerati `ppp1` … `ppp16` per POP. Gli
alias noti (`mailhost`, `www`, `ftp`, `news`, `loghost`) mappavano i servizi
sugli host, così i servizi potevano essere spostati senza cambiare i nomi
pubblici. I domini clienti/virtuali ospitati su DATA seguivano lo stesso
principio.

## Le persone

Internet Force fu costruita e gestita da una squadra molto piccola. **Marco
Iannacone** era l'unico amministratore di sistema e di rete: progettò la rete
con Xpert, costruì la piattaforma UNIX centrale, gestì l'infrastruttura Cisco e
il firewall, scrisse gli strumenti di monitoraggio e provisioning e si occupò
delle operazioni quotidiane. L'ufficio comprendeva anche staff per i contenuti
web e amministrativo, i cui account e alias di ruolo compaiono nella
configurazione recuperata.

## Non soltanto accesso: l'offerta per le aziende

Un **Listino Aziende datato 15 giugno 1996**, conservato e fornito nel 2026 da
**Pascal Schait**, socio fondatore di Internet Force, documenta in modo diretto
l'offerta commerciale rivolta alle imprese. Accanto all'accesso Internet
compaiono IP statici, LAN IP in dial-up, collegamenti dedicati a 19,2 e 64 Kbps,
registrazione di domini, backup DNS, realizzazione di pagine HTML, hosting Web
e assistenza tecnica specializzata.

Anche la scala dell'hosting fotografa bene il Web del periodo: lo spazio veniva
venduto in tagli da **1, 5 e 10 MB**, mentre quantità superiori erano a
preventivo. Una piccola presenza aziendale poteva consistere in poche pagine di
presentazione, recapiti, un form e un piccolo catalogo; dall'altra parte molti
visitatori navigavano a **28,8 kbit/s**, quindi il peso delle pagine era un
vincolo concreto tanto quanto lo spazio disco disponibile.

→ [Listino Aziende Internet Force, 15 giugno 1996](../artifacts/company/business-services-price-list-1996/README.md)

## Il Welcome Kit come prodotto fisico

Il materiale del Welcome Kit già conservato nel repository comprende manuale,
disk image e sorgenti. Le fotografie fornite da Pascal Schait aggiungono il
livello materiale: mostrano la **confezione originale della versione 1.0**, il
sigillo Internet Force, il manuale e i floppy etichettati. È quindi possibile
vedere non soltanto il software distribuito, ma come il primo accesso a Internet
veniva concretamente consegnato a un cliente.

→ [Welcome Kit cliente](../artifacts/customer-welcome-kit/README.md)

## La stampa contemporanea

La ricostruzione si basa principalmente sul materiale tecnico recuperato. Una
fonte **esterna** contribuisce a inquadrare Internet Force mentre era attiva: un
articolo della rivista *Internet & Musica* (rubrica *Prova il provider*, di
Andrea Maffini), conservato in
[`artifacts/press/`](../artifacts/press/README.md). Descrive la rete di POP, i
servizi, l'hosting Web e le tecnologie di posta, e documenta anche una
sperimentazione VRML (Web 3D) del periodo.

## Una ricostruzione pubblicata insieme al repository

Nell'ottobre 2026 Marco Iannacone ha pubblicato su Codemotion l'articolo
[*Archeologia di un ISP: come funzionava davvero un Internet provider nel 1995*](../publications/codemotion-2026/README.md)
insieme a questo repository. L'articolo ripercorre il recupero dell'archivio,
l'architettura, una connessione dial-up, il lavoro quotidiano e i materiali
sopravvissuti; nel repository ne è conservata anche una copia PDF dell'edizione
italiana.

## Cronologia

- **Inizio 1995** — formazione e build a Tel Aviv e Milano; preparati hardware
  Sun, backbone privato e collegamento IDT; raccolto il materiale di
  riferimento Xpert.
- **1995** — lancio. FireWall-1 centrale, DATA e USERS; quattro POP (Milano,
  Pesaro, Palermo, Gorgonzola) con 16 modem ciascuno; NCSA HTTPd, BIND 4,
  Sendmail 8.6.12, XTACACS; collegamento internazionale a 128 kbit/s.
- **Fine 1995 / inizio 1996** — collegamento internazionale portato a 2 Mbit/s;
  POP aggiuntivi e capacità modem; proxy cache CERN.
- **1996** — Tera, CNN, Fano, INDI e Seregno; migrazione da NCSA HTTPd ad
  Apache; introduzione di SSH/SCP; un esperimento web Oracle-su-Windows-NT;
  il Listino Aziende del 15 giugno documenta l'offerta commerciale per imprese.

## L'archivio recuperato

La ricostruzione si basa su pezzi sopravvissuti di un archivio di configurazione salvato da Marco:
 configurazioni Cisco IOS per l'uplink e ogni POP, gli alberi `/etc`
completi del firewall e dei server centrali, l'insieme delle zone BIND-4, le
configurazioni Sendmail, il demone XTACACS e la sua configurazione, la mappa
tkined, lo screenshot della rule base di FireWall-1 e script e procedure
operative. Il racconto qui presentato combina questi materiali con la testimonianza
diretta di Marco Iannacone, che ha costruito e gestito l'infrastruttura. Altri
reperti originali conservati da partecipanti al progetto vengono integrati con
la loro provenienza esplicita.

---

Vedi anche: [Panoramica dell'architettura](01-architecture.md) ·
[Crescita della rete 1995 → 1996](13-network-growth-1995-1996.md) ·
[Xpert reference material](../systems/marco/reference-material/xpert/README.md) ·
[Come si imparava Internet: competenza, autonomia e RTFM](23-learning-internet-culture.md) ·
[Provenienza dell'archivio](archive-provenance.md)
