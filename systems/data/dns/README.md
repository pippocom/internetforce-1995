🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# Configurazione DNS e zone (DATA)

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../LICENSE)

I file del nameserver primario da DATA. È la configurazione BIND-4 e l'insieme
completo delle zone del periodo.

| Item | Descrizione |
|---|---|
| `named.boot`, `named.boot.save` | File di boot BIND-4; la lista corrente e una precedente. |
| `named-data/primary/*` | Zone primarie, inclusi i domini interni e i domini clienti/virtuali ospitati, più le zone inverse. |
| `named-data/secondary/*` | Materiale delle zone secondarie (per esempio `cnn.it`). |
| `named-data/*.source` | I file sorgente master da cui si generano le zone. |
| `named-data/root.cache` | Hint dei root nameserver. |
| `makezones-0.10`, `Makefile`, `makedns.*` | Il flusso di generazione delle zone. |
| [`new_dns-HOWTO.txt`](new_dns-HOWTO.txt) | Il HOWTO originale per la registrazione di un nuovo dominio e l'uso di VIF (**originale**). |
| [`DOMAIN-PROVISIONING-WORKFLOW.md`](DOMAIN-PROVISIONING-WORKFLOW.md) | Spiegazione moderna e didattica dello stesso workflow (**documentazione moderna**, non un originale). |

Le zone e le configurazioni sono **ORIGINALI SANITIZZATI**; `new_dns-HOWTO.txt`
è un **ORIGINALE** recuperato. I file sono la fonte per
[DNS](../../../docs/03-dns.md). Il HOWTO originale è accompagnato dal workflow
moderno [`DOMAIN-PROVISIONING-WORKFLOW.md`](DOMAIN-PROVISIONING-WORKFLOW.md),
che ne conserva la sequenza operativa senza sostituirlo. Lo strumento
`makezones` è elencato anche in
[`artifacts/tools/`](../../../artifacts/tools/README.md).
