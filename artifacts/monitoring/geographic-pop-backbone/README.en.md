# Geographic POP Network Monitor

> Source / Provenance: historical Internet Force artifact (1995) with a modern visual reconstruction based on the original `indi.snmp.map` file.
> Author / Curator: Marco Iannacone — https://pippo.com
> License: see `../../../LICENSE`

## What it shows

This map is a technical file created and used by Marco as a tool for monitoring of the **CDN -> Telecom Frame Relay** geographic network carrying the dedicated lines of the remote POPs.

It does not show the provider's servers; instead, it shows the state of the geographic transport layer that allowed POPs to remain connected to the backbone and to the centralized Milan services.

## Why it mattered

Remote POPs were not independent islands: they depended on dedicated lines and on a geographic network that had to be monitored over time. This map was used to:

- keep POP links under observation;
- visualize hosts, routers, or endpoints of the geographic network;
- observe stripcharts of utilization / activity on selected key interfaces;
- detect problems on the geographic transport layer independently from central services.

## Included files

- `indi.snmp.map` — historical configuration/usage file in the original Scotty/Tkined format
- `InternetForce_geographic_pop_network_monitor_1995.png` — tkined-style graphic rendering.

## Reconstruction note

Only some stripcharts survived in the DAT-recovered file.
