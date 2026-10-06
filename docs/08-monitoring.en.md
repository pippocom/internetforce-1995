[🇮🇹 Italiano](08-monitoring.md) · 🇬🇧 **English**

# Monitoring

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

Network and systems monitoring was built on **SNMP** and **Scotty/tkined**, a Tcl/Tk
network-management application. The monitoring station was Marco's Linux/X
workstation on the office LAN, which is where the recovered tkined map was
created - [`intf.snmp.map`](../artifacts/tkined/intf.snmp.map), version **1.3.4**.

## Why centralised monitoring was needed

Internet Force was not a local network: it was a provider with centralised
servers in Milan, remote POPs connected by dedicated lines, an international
upstream to IDT, and the POP dial-up pools to watch over. With a single
administrator, the only way to notice a fault in time - or to tell whether a
problem was internal or external, beyond the upstream - was to observe the
network from one place.

Centralised monitoring was used to:

- distinguish an internal fault (router, access server, Milan services) from a
  fault on the external network or the upstream;
- collect objective evidence before opening or supporting a trouble ticket with
  the upstream provider;
- keep the state of the dedicated lines connecting remote POPs to Milan
  visible, without depending on one person's memory;
- observe the real use of resources - interface load, dial-up lines in use -
  rather than merely keeping modem pools online.

## SNMP and tkined

**SNMP** (Simple Network Management Protocol, here version 1) was the standard
way a network device exposed its state: interfaces, traffic counters, line
state. Each managed device ran an SNMP agent and published this data in standard
structures called **MIBs**; the monitoring system queried them with a read-only
community string.

**tkined** was the network-management application that acted as the console. It
ran on Marco's Linux/X workstation and is where the recovered map was created,
in version 1.3.4. tkined combined two different things:

- a **topology map**: the managed devices drawn as nodes with their
  relationships, that is *where* they are and *how* they are connected;
- **live measurements**: small Tcl scripts started recurring checks and drew
  **stripcharts** (scrolling graphs over time) for interface load, active users
  and reachability.

In short: the map said *what* existed and how it was connected, the stripcharts
said *how it was doing* at that moment. The map file format resembles Tcl but is
not meant to be edited by hand.

## What was monitored

The tkined map (version 1.3.4) contains the managed devices and their
relationships:

- the **World Hub** (`10.0.0.254`) and the **office hub**
  (`206.20.95.254`, a 3Com LinkBuilder FMS managed by SNMP);
- the central **Cisco 2501** (`10.0.1.1`);
- the **POP routers**: 2501 Palermo (`10.0.4.1`), 2501 Pesaro (`10.0.3.1`),
  2501 Gorgonzola (`10.0.5.1`);
- the **access servers** by their serial-side addresses
  (`10.0.2.1` Milano/ts1, `10.0.3.130` Pesaro, `10.0.4.130` Palermo,
  `10.0.5.130` Gorgonzola);
- the servers: `firewall`, `data`, `users`, `dvlp`, and Marco's `marco`;
- the **UPS**, with a reachability check.

The original map can be inspected here:
[`artifacts/tkined/intf.snmp.map`](../artifacts/tkined/intf.snmp.map).

## What it collected

tkined provided live topology plus stripcharts driven by small Tcl scripts:

- **interface load** on the routers, access servers and hubs — for example
  the central 2501 Ethernet and Serial0, and the POP router links: in practice
  the traffic on each individual link;
- **active users** on the access servers, which showed how many of the 16
  lines at each POP were in use, that is **modem utilisation** in the dial-up
  pools;
- **reachability** for managed devices such as the UPS.

The map starts jobs such as `start_ifload_monitor` and an active-users
monitor (`ip_monitor.tcl`) against the discovered devices. Interface
counters and line state came from the standard SNMP MIBs exposed by the
Cisco devices and the 3Com hub.

SNMP access used version 1 with a read-only community string, configured on
every Cisco device (`snmp-server community … RO`) and on the hubs. The
firewall permitted the management traffic only on the internal network.

## The monitoring maps

Beyond the provider's main network map, the archive preserves two tkined maps
devoted to specific points of view. They are recovered **historical artifacts**;
the accompanying images are **modern graphical reconstructions**, in tkined
style, explicitly labelled as such and based on the original files - not
invented measurements.

### IDT Connectivity Monitor

Monitoring of **Internet reachability beyond the IDT upstream**. It does not
describe the provider's internal topology: it is meant to check whether, once
traffic has left Internet Force and IDT, an external node or destination shows
signs of degradation. It was used to observe the **round-trip time** to
reference hosts and the **incoming/outgoing line load**, to detect persistent
anomalies on routes or external nodes, and to collect evidence useful for
technical reports to IDT.

- README: [`artifacts/monitoring/idt-connectivity/README.en.md`](../artifacts/monitoring/idt-connectivity/README.en.md)
- Historical file: [`idt.snmp.map`](../artifacts/monitoring/idt-connectivity/idt.snmp.map)
- Modern reconstruction: [`InternetForce_IDT_connectivity_monitor_1995.png`](../artifacts/monitoring/idt-connectivity/InternetForce_IDT_connectivity_monitor_1995.png)

### Geographic POP Network Monitor

Monitoring of the geographic network carrying the dedicated lines of the remote
POPs, labelled in the map as **CDN -> Frame Relay Telecom**. It does not show
the provider's servers; instead it shows the state of the geographic transport
that kept POPs connected to the backbone and to the centralised Milan services:
POP links, hosts/routers/endpoints of the geographic network, and stripcharts of
utilisation on selected key interfaces.

> Note on the «CDN» label: the term is taken from the recovered map and is not
> explained anywhere else in the archive. No interpretation of it is offered
> here; the description stays tied to what the map shows.

- README: [`artifacts/monitoring/geographic-pop-backbone/README.en.md`](../artifacts/monitoring/geographic-pop-backbone/README.en.md)
- Historical file: [`indi.snmp.map`](../artifacts/monitoring/geographic-pop-backbone/indi.snmp.map)
- Modern reconstruction: [`InternetForce_geographic_pop_network_monitor_1995.png`](../artifacts/monitoring/geographic-pop-backbone/InternetForce_geographic_pop_network_monitor_1995.png)

## Time, logging and statistics

Complementing the interactive monitoring:

- **xntpd** kept time synchronised against public time servers, which made
  multi-device logs consistent;
- **syslog** on the servers forwarded to `loghost` (DVLP), so one host
  collected the logs of the others;
- scheduled jobs produced **web and mail statistics**, ran log rotation, and
  regenerated alert/expiry data for customer accounts.

This combination - SNMP graphs for the network, centralised logs for the
hosts, and scheduled reports for the services - gave a single administrator
a usable view of the whole provider.

## Representative configuration

The recovered tkined map (`artifacts/tkined/intf.snmp.map`, version 1.3.4) is
generated Tcl code: every node carries a name, an address and SNMP attributes.

```text
set node18 [ ined -noupdate create NODE ]
ined -noupdate icon $node18 switch.xbm
ined -noupdate name $node18 {Office Hub}
ined -noupdate address $node18 206.20.95.254
ined -noupdate attribute $node18 SNMP:Config {-community public -address 206.20.95.254 -port 161 -version SNMPv1}
```

→ Complete map: [`artifacts/tkined/intf.snmp.map`](../artifacts/tkined/intf.snmp.map) ·
[`artifacts/monitoring/`](../artifacts/monitoring/geographic-pop-backbone/README.en.md)

---

See also: [Architecture overview](01-architecture.en.md) ·
[Operations and backup](14-operations-and-backup.en.md) ·
[The office LAN](../systems/office-lan/README.en.md)

---

→ [Build an Internet Force POP, step by step](00-build-an-isp.en.md)
