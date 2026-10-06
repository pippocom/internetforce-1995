🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# Registrazione dei domini

> **Internet Force 1995--1996 Historical Archive**\
> Ricostruzione e documentazione tecnica basate sui materiali originali
> Internet Force conservati da **Marco Iannacone**.\
> Autore e curatore dell'archivio: **Marco Iannacone** ·
> https://pippo.com\
> Licenza: [CC BY 4.0](../../LICENSE)

Questa area raccoglie la ricostruzione delle procedure storiche con cui
Internet Force registrava i domini nel 1995--1996, sia per i domini
internazionali (`.com`/`.net`) sia per quelli italiani (`.it`), a partire dalle
operazioni realmente documentate.

Registrare un dominio non era un semplice acquisto via Web come oggi: richiedeva di
coordinare informazioni amministrative, configurazione DNS, nameserver
primario e secondario, e una richiesta formale inviata a soggetti esterni
(InterNIC per `.com`/`.net`, GARR-NIS per `.it`). I documenti qui raccolti
mostrano concretamente quel lavoro.

## Documenti

### [`domini_com_net.txt`](domini_com_net.txt)

Procedura per la registrazione dei domini internazionali (`.com`/`.net`),
comprendente preparazione DNS, interazione con IDT per il nameserver
secondario e compilazione del template di registrazione InterNIC.

### [`domini_it.txt`](domini_it.txt)

Procedura per la registrazione dei domini italiani (`.it`), comprendente i
dati amministrativi richiesti dal GARR/Registro, la configurazione DNS e gli
scambi operativi fino al completamento.

## Scambi email originali

I documenti `domini_com_net.txt` e `domini_it.txt` ricostruiscono la
procedura; le mailbox consentono di leggere gli scambi originali da cui è stata
ricavata. Restano nella loro posizione canonica
`artifacts/email-archive/technical/` e non sono copiate qui:

- [`DOMAIN.mailbox`](../email-archive/technical/DOMAIN.mailbox) — notifiche e
  moduli InterNIC (`.com`);
- [`DOMAIN-IDT.mailbox`](../email-archive/technical/DOMAIN-IDT.mailbox) —
  registrazioni `.com` e scambi con IDT per il nameserver secondario;
- [`GARR-DOMINI_IT.mailbox`](../email-archive/technical/GARR-DOMINI_IT.mailbox)
  — registrazioni `.it` presso il GARR-NIS;
- [`ITALIAN_POSTMAST.mailbox`](../email-archive/technical/ITALIAN_POSTMAST.mailbox)
  — lista dei postmaster GARR (maintainer, domini orfani);
- [`IDT.mailbox`](../email-archive/technical/IDT.mailbox) — altri scambi con
  IDT.

## Configurazioni DNS

Le registrazioni dei domini erano strettamente collegate alla configurazione
DNS: la zona doveva essere pronta e i nameserver raggiungibili. Le
configurazioni operative dell'epoca sono conservate in
[`systems/data/dns/`](../../systems/data/dns/README.md), con le zone in
[`systems/data/dns/named-data/`](../../systems/data/dns/named-data/).

Zone usate come esempio nei due documenti:

- [`primary/pippo.com`](../../systems/data/dns/named-data/primary/pippo.com) —
  zona `.com`;
- [`primary/promotion.it`](../../systems/data/dns/named-data/primary/promotion.it)
  — zona `.it`;
- [`secondary/cnn.it`](../../systems/data/dns/named-data/secondary/cnn.it) —
  zona `.it` gestita come secondaria;
- [`named.boot`](../../systems/data/dns/named.boot) — elenco delle zone
  dichiarate sul DNS Internet Force.

## Continua l'esplorazione

- [DNS](../../docs/03-dns.md)
- [Aggiungere un nuovo dominio cliente (workflow)](../../systems/data/dns/DOMAIN-PROVISIONING-WORKFLOW.md)
- [BIND su DATA: configurazione tecnica](../../systems/data/dns/TECHNICAL.md)
- [Archivio email](../email-archive/README.md)
