🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# Caching proxy (CERN httpd 3.0) — DATA

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../LICENSE)

Nel 1996 Internet Force aggiunse un **caching proxy HTTP**, eseguito su **DATA**
con **CERN httpd 3.0** e in ascolto sulla **porta 8090**.

## Che cos'è un caching proxy

Un **proxy HTTP** è un servizio che si interpone tra i client e i server Web:
invece di contattare direttamente il sito richiesto, il client chiede la pagina
al proxy, che la recupera per suo conto e la restituisce. Un **caching proxy**
conserva localmente una copia delle pagine già richieste, così le richieste
successive allo stesso contenuto possono essere servite dalla cache locale.

Per un ISP dell'epoca questo offriva due vantaggi concreti:

- **riduzione del traffico esterno** verso Internet;
- **tempi di accesso migliori** per i contenuti già richiesti.

## Configurazione

Il file storico recuperato documenta l'installazione e la configurazione del
servizio. Alcune direttive rappresentative:

```text
ServerRoot      /usr/local/etc/proxy
Port    8090
Caching         On
CacheRoot       /usr/local/etc/proxy/cache
CacheSize       1000
Protection PROXY-PROT {
        Mask            @(*.internetforce.com, 206.20.*.*, *.intf.com)
 }
```

Queste righe indicano la directory del servizio, la porta di ascolto, l'attività
di cache e le restrizioni di accesso al proxy.

Configurazione completa recuperata:
[`CERN3-Proxy_installation.txt`](CERN3-Proxy_installation.txt).

---

Vedi anche: [Server DATA](../README.md) ·
[Web, FTP, news e mailing list](../../../docs/05-web-news-ftp.md) ·
[Inventario software](../../../docs/11-software-inventory.md)
