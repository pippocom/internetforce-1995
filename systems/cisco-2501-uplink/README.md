🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# Cisco 2501 — Uplink Internet

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../LICENSE)

Il Cisco 2501 centrale era il bordo della rete Internet Force. Stava nel sito
centrale di Milano, sul backbone `10.0.0.0/8` (il lato "world"), e portava
tutto il traffico Internet da e verso il provider.

## Hardware e ruolo

- Modello: Cisco 2501, IOS 10.2.
- Hostname nella configurazione sopravvissuta: `2501internet`.
- Ethernet del backbone: `10.0.1.1/24`, noto in `/etc/hosts` come `intf-idt`.
- Era il gateway di default del firewall (`fwall.etc/defaultrouter` =
  `intf-idt`) e il punto in cui il backbone privato incontrava Internet
  pubblica.

## Interfacce

```
interface Ethernet0
 ip address 10.0.1.1 255.255.255.0

interface Serial0
 ip address 206.20.64.30 255.255.255.252
 encapsulation frame-relay
 bandwidth 128
 frame-relay lmi-type ansi
 frame-relay map ip 206.20.64.29 150
```

La Serial0 era rivolta a IDT a New York. Il collegamento iniziale andava a
**128 kbit/s** - il `bandwidth 128` nella configurazione sopravvissuta riflette
quella prima fase - e fu portato a **2 Mbit/s** circa sei mesi dopo il lancio.

## Routing

```
ip default-gateway 206.20.64.29
ip default-network 199.248.149.0
ip route 10.0.0.0   255.0.0.0     10.0.0.1
ip route 199.248.149.0 255.255.255.0 206.20.64.29
ip route 206.20.95.0 255.255.255.0 10.0.0.1
```

Il router inviava il traffico diretto a Internet verso IDT e quello interno
verso l'interfaccia world del firewall (`10.0.0.1`). Portava rotte per le reti
dial-up dei POP (`206.20.115.0/24`, `206.20.224.0/24`, `206.20.225.0/24`) e,
nella configurazione successiva, anche per le reti del 1996
(`206.20.226.0/24` … `206.20.231.0/24`).

Una access list in uscita sul link seriale permetteva il traffico la cui
sorgente era una rete Internet Force, e un priority group dava al traffico
interattivo e DNS la priorità più alta, al web media e a FTP/SMTP più bassa.

## Gestione

Il router eseguiva SNMP v1 con una community di sola lettura ed era monitorato
da tkined. Era raggiunto via telnet dalla rete ufficio/amministrazione.

## Provenienza della configurazione

La configurazione sopravvissuta corrisponde al Cisco 2501 centrale World/Milano
documentato in questa pagina. Il file recuperato è una **revisione
successiva/aggregata**: comprende, per esempio, rotte dei POP aggiunte nel 1996.
Non va quindi interpretato automaticamente come uno snapshot byte-per-byte della
configurazione di lancio del 1995.

La stessa configurazione compare due volte nell'archivio recuperato - una come
file proprio dell'uplink e una nella directory di riferimento Xpert - con
indirizzamento identico. La descrizione canonica dell'uplink è questa pagina;
il file di configurazione è tenuto con il materiale di riferimento recuperato.

---

Vedi anche: [Panoramica dell'architettura](../../docs/01-architecture.md) ·
[Crescita della rete](../../docs/13-network-growth-1995-1996.md) ·
[Configurazione dell'uplink](config/README.md)
