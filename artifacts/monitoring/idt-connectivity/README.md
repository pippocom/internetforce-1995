# IDT Connectivity Monitor

> Fonte / Provenienza: artefatto storico Internet Force (1995) con ricostruzione grafica moderna basata sul file originale `idt.snmp.map`.
> Autore / Curatore: Marco Iannacone — https://pippo.com
> Licenza: vedere `../../../LICENSE`

## Cosa mostra

Questa mappa è il cruscotto di monitoraggio creato ed usato da Marco per osservare la **raggiungibilità Internet oltre l'upstream IDT**.

Il suo scopo non era descrivere la topologia interna del provider, ma controllare se, una volta usciti da Internet Force e da IDT, alcuni nodi o destinazioni esterne mostrassero segnali di degrado.

## Perché serviva

Internet Force era un piccolo ISP italiano con collegamento internazionale verso IDT / New York. In caso di problemi sulla rete esterna, non era realistico aspettarsi che un operatore americano desse immediato preavviso al system administrator di un piccolo provider italiano. Di conseguenza Marco aveva creato questa mappa allo scopo di:

- osservare **round-trip time** verso host di riferimento;
- osservare il **carico di linea** in ingresso / uscita;
- individuare anomalie persistenti su tratte o nodi esterni;
- raccogliere elementi utili per segnalazioni tecniche verso IDT.

## File inclusi

- `idt.snmp.map` — file originale usato da Tkined.
- `InternetForce_IDT_connectivity_monitor_1995.png` — rendering grafico in stile Scotty/Tkined.

## Nota sulla ricostruzione

La PNG non vuole sostituire il file storico: serve a renderlo leggibile e presentabile nel repository e nell'articolo, mantenendo il linguaggio visivo dell'epoca.
