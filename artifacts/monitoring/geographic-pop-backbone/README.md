# Geographic POP Network Monitor

> Fonte / Provenienza: artefatto storico Internet Force (1995) con ricostruzione grafica moderna basata sul file originale `indi.snmp.map`.
> Autore / Curatore: Marco Iannacone — https://pippo.com
> Licenza: vedere `../../../LICENSE`

## Cosa mostra

Questa mappa è un file tecnico, creata e utilizzata da Marco come strumento di monitoraggio della rete geografica **CDN -> Frame Relay Telecom** su cui si attestavano le linee dedicate dei POP remoti.

Non mostra i server del provider, ma lo stato del trasporto geografico che consentiva ai POP di essere collegati al backbone e ai servizi centralizzati di Milano.

## Perché serviva

I POP remoti non erano isole indipendenti: dipendevano da linee dedicate e da una rete geografica che andava osservata nel tempo. Questa mappa serviva a:

- tenere sotto controllo i collegamenti dei POP;
- visualizzare host, router o endpoint della rete geografica;
- osservare stripchart di utilizzo / attività per alcune interfacce chiave;
- individuare problemi sulla tratta geografica, indipendentemente dai servizi centrali.

## File inclusi

- `indi.snmp.map` — file storico di configurazione / utilizzo nel formato originale Scotty/Tkined
- `InternetForce_geographic_pop_network_monitor_1995.png` — rendering grafico in stile tkined.

## Nota sulla ricostruzione

Nel file recuperato da DAT sopravvivono solo alcuni stripchart.