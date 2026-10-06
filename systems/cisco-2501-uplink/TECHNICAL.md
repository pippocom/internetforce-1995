🇮🇹 **Italiano** · [🇬🇧 English](TECHNICAL.en.md)

# Cisco 2501 --- guida tecnica alla configurazione

> **Internet Force 1995--1996 Historical Archive**\
> Ricostruzione e documentazione tecnica basate sui materiali originali
> Internet Force conservati da **Marco Iannacone**.\
> Autore e curatore dell'archivio: **Marco Iannacone** ·
> https://pippo.com

Il Cisco 2501 svolgeva il lavoro di **routing**. Questa guida non
sostituisce le configurazioni originali: ne seleziona poche righe e
spiega che cosa significavano.

## Il 2501 centrale verso IDT

La configurazione recuperata del router centrale contiene:

``` text
interface Ethernet0
 ip address 10.0.1.1 255.255.255.0
```

L'interfaccia Ethernet collegava il router al backbone interno
Internet Force.

Sul lato internazionale la configurazione conserva:

``` text
interface Serial0
ip address 206.20.64.30 255.255.255.252
ip access-group 111 out
encapsulation frame-relay
bandwidth 128
priority-group 5
frame-relay lmi-type ansi
frame-relay map ip 206.20.64.29 150
```

Il valore `bandwidth 128` è un parametro IOS coerente con la fase
iniziale a 128 kbit/s; non va interpretato come comando che imposta
fisicamente la velocità della linea. La capacità internazionale venne
poi portata a 2 Mbit/s circa sei mesi dopo il lancio.

La default route e la default network nella stessa configurazione:

``` text
ip default-gateway 206.20.64.29
ip default-network 199.248.149.0
ip route 199.248.149.0 255.255.255.0 206.20.64.29
```

`ip default-network 199.248.149.0` indicava la rete candidata come
default; la rotta statica verso `206.20.64.29` la rendeva raggiungibile
attraverso il lato IDT.

## Router dei POP remoti

Pesaro, Palermo e Gorgonzola avevano ciascuno un 2501 che collegava il
2511 locale al backbone.

``` text
2511 ── rete seriale locale ── 2501 ── backbone ── Milano
```

Le route del 2501 permettevano di associare le reti dial-up pubbliche al
2511 e di inviare il resto del traffico verso il backbone. Nella
configurazione recuperata di Pesaro il lato seriale verso il 2511 è
`10.0.3.129/25`:

``` text
interface Serial0
ip address 10.0.3.129 255.255.255.128
encapsulation ppp
bandwidth 64
```

e alcune rotte rappresentative:

``` text
ip route 0.0.0.0 0.0.0.0 10.0.0.1
ip route 10.0.9.128 255.255.255.128 10.0.3.130
ip route 206.20.230.32 255.255.255.224 206.20.115.66
ip route 206.20.230.64 255.255.255.224 206.20.115.66
```

## Come leggere una route

Una route statica IOS può essere letta concettualmente così:

``` text
ip route <rete-destinazione> <maschera> <next-hop>
```

Significa: *per raggiungere questa rete, consegna il pacchetto a questo
prossimo router*.

Nella configurazione recuperata di Pesaro le due sottoreti dial-up
`206.20.115.0/27` e `206.20.115.64/27` sono associate al 2511
(`10.0.3.130`):

``` text
ip route 206.20.115.0 255.255.255.224 10.0.3.130
ip route 206.20.115.64 255.255.255.224 10.0.3.130
```

Queste rotte mandano il traffico dial-up al 2511, che termina le
sessioni dei clienti; il resto segue la rotta di default verso il
backbone.

## Configurazione originale completa

- 2501 centrale: [`config/2501.cfg`](config/2501.cfg)
- 2501 di Pesaro: [`../pops/pesaro/2501.cfg`](../pops/pesaro/2501.cfg)
- 2501 di Palermo: [`../pops/palermo/2501.cfg`](../pops/palermo/2501.cfg)
- 2501 di Gorgonzola: [`../pops/gorgonzola/2501.cfg`](../pops/gorgonzola/2501.cfg)

## Continua l'esplorazione

-   [Cisco 2511: accesso dial-up e
    XTACACS](../cisco-2511-pop/TECHNICAL.md)
-   [La sessione dial-up](../../docs/02-dialup-session.md)
-   [Panoramica dell'architettura](../../docs/01-architecture.md)
