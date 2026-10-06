# IDT Connectivity Monitor

> Source / Provenance: historical Internet Force artifact (1995) with a modern visual reconstruction based on the original `idt.snmp.map` file.
> Author / Curator: Marco Iannacone — https://pippo.com
> License: see `../../../LICENSE`

## What it shows

This map is the monitoring dashboard created and used by Marco to observe **Internet reachability beyond the IDT upstream**.

Its purpose was not to document the provider's internal topology, but to check whether, once traffic had left Internet Force and IDT, some external nodes or destinations were showing signs of degradation.

## Why it mattered

Internet Force was a small Italian ISP with an international connection to IDT / New York. If problems occurred on the external network, it was unrealistic to expect an American carrier to proactively alert the system administrator of a small Italian ISP. Marco had therefore created this map in order to:

- observe **round-trip time** to reference hosts;
- observe **incoming / outgoing line load**;
- detect persistent anomalies on routes or external nodes;
- collect evidence useful for technical reports to IDT.

## Included files

- `idt.snmp.map` — original file used by Tkined.
- `InternetForce_IDT_connectivity_monitor_1995.png` — Scotty/Tkined-style graphic rendering.

## Reconstruction note

The PNG does not replace the historical file: it makes it readable and presentable in the repository and in the article while preserving the visual language of the period.
