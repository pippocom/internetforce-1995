🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# POP CNN

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../LICENSE)

CNN era ancora un POP Internet Force nel 1995. Nel 1995 CNN commissionò
separatamente a Marco Iannacone una **consulenza a pagamento** per dotarsi di un
proprio server DNS: Marco installò e configurò per CNN un **DNS su Windows NT
3.5**.

## Router e access server

| Dispositivo | File |
|---|---|
| Router Cisco 2501 | [2501-cnn.cfg](2501-cnn.cfg) |
| Access server Cisco 2511 | [2511-cnn.cfg](2511-cnn.cfg) |

## DNS locale (Windows NT 3.5)

I file in [`dns/`](dns/) sono il materiale di configurazione sopravvissuto di
quel server DNS locale. Questa configurazione è **distinta dal DNS centrale
Internet Force** (DATA primario, USERS secondario).

Il caso CNN mostra che, pur essendo ancora un POP Internet Force, CNN iniziava
già a dotarsi di alcuni servizi locali.

| File | Descrizione |
|---|---|
| [`dns/named.boot`](dns/named.boot) | Configurazione di avvio del DNS. |
| [`dns/named.ca`](dns/named.ca) | Cache / root hints. |
| [`dns/named.in`](dns/named.in) | File di zona/configurazione DNS locale. |
| [`dns/named.zoo`](dns/named.zoo) | File di zona/configurazione DNS locale. |
| [`dns/named.127`](dns/named.127) | Zona locale/reverse (`127`). |
| [`dns/named.206`](dns/named.206) | Zona locale/reverse (`206`). |
| [`dns/CNN_info.txt.rtf`](dns/CNN_info.txt.rtf) | Nota informativa associata al server. |

---

Vedi anche: [I POP](../README.md) ·
[POP successivi](../later-pops/README.md) ·
[Crescita della rete 1995 → 1996](../../../docs/13-network-growth-1995-1996.md)
