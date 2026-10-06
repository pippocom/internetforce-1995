🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# POP successivi (1996)

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../LICENSE)

Questi POP furono aggiunti nel corso del 1996 mentre Internet Force ampliava la
copertura. Mantengono lo schema router + access server, ma i modelli dei
dispositivi e le sistemazioni dei collegamenti variano da sito a sito e sono
documentati dalle loro configurazioni recuperate, non forzati in un unico
template.

## Tera

- Router: Cisco 2501 (`2501tera`), Ethernet `10.0.7.1/26`; seriale
  `10.0.7.129/25`.
- Access server: **Cisco 2509** a `206.20.227.65/24` (qui il 2509, non un 2511,
  svolge il ruolo di access server).
- Rete dial-up `206.20.227.0/24`; dominio `tera-it.com`.

## CNN

CNN è documentata separatamente nella sua home dedicata, insieme al suo DNS
locale: [POP CNN](../cnn/README.md).

## Fano

- Un sotto-POP di Pesaro. Router (`pesaro-fano`) a `206.20.115.66/27`, collegato
  a Pesaro sulla seriale `10.0.9.128/25`; access server (`2511fano`) a
  `206.20.230.65/27` con 4 linee asincrone e pool `206.20.230.34` …
  `206.20.230.37`.
- Rete dial-up `206.20.230.0/24`; Pesaro instradava il traffico di Fano verso il
  backbone.

## INDI

- Router: Cisco 2501 (`2501INDI`), Ethernet `10.0.10.1/26`.
- Raggiunto con un collegamento nazionale **frame-relay**; i capi di Milano e
  Pesaro del circuito frame-relay sono registrati in
  `POP_albacom-CISCO_configuration.txt` (mappe su `10.0.10.130` e `10.0.10.1`).
- Rete dial-up `206.20.231.0/24`.

## Seregno

- La rete `206.20.226.0/24` (`intf-seregno`) compare nella lista reti del
  firewall, ma nessuna configurazione di router per Seregno sopravvive. È
  inclusa per completezza come parte del piano di indirizzamento del 1996.

---

Vedi anche: [I POP](../README.md) ·
[Crescita della rete 1995 → 1996](../../../docs/13-network-growth-1995-1996.md)
