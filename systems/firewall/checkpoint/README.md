🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# Check Point FireWall-1

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../LICENSE)

| Item | Descrizione |
|---|---|
| `FW-policy.gif` | Lo screenshot **ORIGINALE** del Rule Base Editor di FireWall-1 (`/usr/local/etc/fw/conf/final1.W`), che mostra la policy reale di 15 regole. |
| `firewall-lic.txt` | Informazioni su versione/entitlement di FireWall-1; la chiave di licenza stessa è stata sostituita con un segnaposto. |

`FW-policy.gif` è un artefatto storico primario, non una ricostruzione. La rule
base che mostra è trascritta in [Sicurezza](../../../docs/06-security.md),
inclusa la regola finale `Any -> Any : Any : STOP` e i percorsi per servizio.

## La Stateful Inspection di FireWall-1

Check Point, fondata nel 1993, presentò FireWall-1 nel 1994 introducendo la tecnologia che chiamò **Stateful Inspection**.

I packet filter tradizionali valutavano ogni pacchetto principalmente sulla base di parametri come indirizzo IP, protocollo e porta, senza mantenere una rappresentazione completa dello stato della comunicazione. FireWall-1 introduceva invece una tabella dinamica dello stato delle connessioni: il firewall poteva quindi riconoscere se un pacchetto apparteneva a una sessione già autorizzata e applicare la policy tenendo conto del contesto della comunicazione, non soltanto delle caratteristiche del singolo pacchetto.

Questo consentiva di ottenere un controllo più consapevole delle connessioni senza dover necessariamente utilizzare un application proxy specifico per ogni protocollo.

Nel 1995 questa tecnologia era estremamente recente: FireWall-1 era stato introdotto commercialmente soltanto l'anno precedente. La sua presenza nei sistemi di Internet Force documenta quindi un'adozione molto precoce di un principio che sarebbe diventato fondamentale nell'evoluzione dei firewall di rete.
