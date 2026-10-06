🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# I POP

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../LICENSE)

Internet Force serviva i clienti attraverso Point of Presence regionali. Un POP
era definito da due ruoli funzionali:

- un **router** — un Cisco 2501 che portava il traffico del POP sul backbone
  privato e verso Milano;
- un **access server dial-up (o terminal server)** — un Cisco 2511 (o, nel caso di Tera, un Cisco 2509) le cui
  linee asincrone erano cablate al banco modem e che autenticava ogni chiamante
  contro USERS/XTACACS.

Questa separazione è la chiave per leggere le configurazioni dei POP. Il 2501 è
il dispositivo di routing; il 2511/2509 è il dispositivo di accesso. I POP
iniziali avevano ciascuno un banco di **16 modem US Robotics Courier 28.8
kbit/s**.

## Mappa dei POP

| POP | Router (2501) | Access server | Rete dial-up | Pool clienti |
|---|---|---|---|---|
| [Milano](milano/README.md) | 2501 centrale/world (uplink) | 2511 su `10.0.2.1` | 206.20.95.64/26 | 206.20.95.70–85 |
| [Pesaro](pesaro/README.md) | `10.0.3.1` | 2511 su `206.20.115.65` | 206.20.115.0/24 | 206.20.115.2–17 |
| [Palermo](palermo/README.md) | `10.0.4.1` | 2511 su `206.20.224.65` | 206.20.224.0/24 | 206.20.224.2–17 |
| [Gorgonzola](gorgonzola/README.md) | `10.0.5.1` | 2511 su `206.20.225.65` | 206.20.225.0/24 | 206.20.225.2–17 |
| [POP successivi](later-pops/README.md) | Tera `10.0.7.1`, CNN `10.0.8.1`, INDI `10.0.10.1` | 2509/2511 | 206.20.227/228/230/231.0/24 | per POP |

Milano è il caso speciale: il sito centrale e il POP di Milano condividono la
stessa sede, quindi il Cisco 2501 centrale/world *è* il router del POP e non
esiste un 2501 separato per Milano.

## Il disegno comune dei POP

Ogni POP remoto seguiva lo stesso schema di indirizzamento:

- una `/26` privata sul lato Ethernet del router e un link seriale `/25` tra il
  router e l'access server;
- una rete dial-up pubblica `/24`, con l'Ethernet dell'access server nella
  `.64/27` e il pool clienti che inizia da `.2` in quella `/27`;
- una rotta di default sul router verso il gateway world/backbone (`10.0.0.1`)
  nel sito centrale, così il traffico del POP usciva sul backbone verso
  Internet;
- `tacacs-server host 206.20.95.4` sull'access server, così ogni chiamante si
  autenticava centralmente.

Ogni terminale dial-up aveva un nome DNS diretto e inverso (`ppp1-16-<pop>`),
che teneva leggibili i log di connessione.

## Collegamenti geografici e dimensionamento

I POP remoti di Pesaro, Palermo e Gorgonzola raggiungevano Milano attraverso
circuiti dedicati **CDA/CDN da 64 kbit/s**. Milano resta il caso a parte: il POP
di Milano condivideva la sede del sito centrale e non aveva un collegamento
geografico dedicato.

Il dimensionamento del banco modem seguiva una **regola empirica utilizzata da
Xpert**: la capacità del collegamento geografico, moltiplicata per otto, doveva
essere almeno pari alla capacità nominale aggregata dei modem.

```text
64 kbit/s × 8    = 512 kbit/s
16 × 28,8 kbit/s = 460,8 kbit/s
```

Con 16 modem da 28,8 kbit/s il valore teorico era 460,8 kbit/s, mentre
64 × 8 dava 512 kbit/s: quindi una linea da 64 kbit/s di un POP gestiva bene
16 modem. La regola assumeva statisticamente che non tutti gli utenti
trasferissero dati contemporaneamente alla massima velocità.

Per il numero di linee, Xpert utilizzava come riferimento circa **8-16 abbonati
per modem**, in modo da mantenere una ragionevole probabilità di trovare una
linea libera. Un gruppo di 16 modem corrispondeva quindi a una capacità
commerciale indicativa di circa **128-256 abbonati**. È un rapporto di
pianificazione, non il numero di sessioni simultanee, e non va usato per
ricalcolare il numero complessivo di abbonati di Internet Force.

## Aggiungere un nuovo POP

La procedura operativa per aggiungere e configurare un nuovo POP è conservata
nel HOWTO originale [`CISCO-add_new_pop-HOWTO.txt`](CISCO-add_new_pop-HOWTO.txt)
(**originale sanitizzato**: la credenziale di enable del dispositivo è stata
sostituita). Descrive il flusso realmente seguito: copiare le configurazioni
collaudate 2511/2501, eseguire il dialogo di setup del Cisco, impostare il
gateway e caricare la configurazione dallo staging TFTP, quindi aggiornare
`netmasks`, `networks`, `rc.route`, gli oggetti della policy FireWall-1 e la
configurazione di accounting. Gli stessi passi sono riassunti in
[Crescita della rete 1995 → 1996](../../docs/13-network-growth-1995-1996.md).

## La sessione del cliente

Il percorso end-to-end è descritto in
[La sessione dial-up](../../docs/02-dialup-session.md); il modello di
autenticazione è in
[Autenticazione (XTACACS)](../../docs/10-authentication-tacacs.md).

---

Vedi anche: [Crescita della rete 1995 → 1996](../../docs/13-network-growth-1995-1996.md)
