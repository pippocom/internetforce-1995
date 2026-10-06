[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# The `marco` workstation

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../LICENSE)

![marco box in the 1995 Systems Overview](../../images/crops/marco.png)

*Crop from [`images/internetforce_server_map.png`](../../images/internetforce_server_map.png) (Systems Overview 1995).*

Marco Iannacone's Linux workstation is the personal and operational machine at
the centre of this area. Its history is broader than its role in the office LAN
alone: it was the administration and technical working machine during Internet
Force, the place where technical and personal materials were kept, and it was
later used in the transition period after Internet Force.

## Platform

- 486DX-class PC at `206.20.95.140`, on the office LAN.
- Linux (Slackware 2.1) with X11; 16 MB RAM and a 1 GB SCSI disk.
- Introduced on the recommendation of **Yahel Ben-David** (Xpert UNIX Systems) as
  a safe environment in which to learn Unix/Linux by experimenting.

## Operational role

- it began as a **deliberately disposable environment**, separate from the
  production Sun servers: Marco could modify it, break it or reinstall it from
  scratch in order to learn, without risking the ISP infrastructure;
- it later became the daily administration, test and monitoring (tkined/SNMP)
  workstation, and hosted personal PGP use and occasional working copies,
  including irregular Hypertxt snapshots;
- during the closure of Internet Force it was reconfigured as the
  server which made possible the operational continuity in the migration to Enter
  (it became the server with both USERS and DATA functionalities)

Software for the Sun servers continued to be built in the Sun environment
(DVLP): **a Linux → SunOS cross-compilation was not part of the operational
workflow**. See [Development and the build host](../../docs/07-development.en.md).

## Sections of this area

| Section | Content |
|---|---|
| [`system/`](system/) | Machine configuration: Slackware-era `rc.*` boot scripts, `sendmail.cf.linux`, disk partitioning. |
| [`pgp/`](pgp/) | Marco's PGP public keyring and the historical PGP 2.6.3i package. |
| [`reference-material/xpert/`](reference-material/xpert/) | Reference material collected by Marco at Xpert UNIX Systems (Tel Aviv, 1995). |
| [`hypertxt/`](hypertxt/) | Recovered material of the Hypertxt authoring product and its provenance. |
| [`personal-web/`](personal-web/) | Snapshot of Marco's personal site, `pippo.com` (1997). |
| [`defcon-v-1997/`](defcon-v-1997/) | Personal archive after Internet Force (DEFCON V article, 1997). |

## Historical office photograph

A historical photograph of the Internet Force office is preserved in
[`artifacts/photographs/internetforce-office-1995.jpg`](../../artifacts/photographs/README.en.md).

## Role in the office LAN

On the office network `marco` was the administrator's workstation; the LAN
continues to document it as a host of the segment in
[The office LAN](../office-lan/README.en.md).

## pippo.com and the personal Web presence

`pippo.com` was **Marco Iannacone's personal site**. The 1997 Web snapshot is
preserved in
[`personal-web/pippo.com-1997/`](personal-web/pippo.com-1997/README.en.md).

The site was historically reachable through the hosting of pippo.com on Internet Force, and the same
personal presence was also reachable as the `/~ianna/` area on the Internet
Force domains.

## Associated material and activities

Historical material linked to the workstation or to Marco's technical work,
**distinct from the services running on the machine**. The box represents the
**1995** environment: part of the material is later and must be read with the
stated date.

| Material | Date / context | Description | Link |
|---|---|---|---|
| Internet guide / Hypertxt | 1994–1997 | Marco Iannacone's hypertextual guide to the Internet (MaISoft Hypertxt). | [`hypertxt/`](hypertxt/README.en.md) |
| PGP | keys of 1995-09-17 and 1995-10-11 | Personal PGP use, with the recovered public keyring and the historical PGP 2.6.3i package. | [`pgp/`](pgp/README.en.md) |
| pippo.com and personal Web presence | 1997 snapshot | Marco's personal site, hosted on the Internet Force infrastructure. | [`personal-web/pippo.com-1997/`](personal-web/pippo.com-1997/README.en.md) |
| Easy! (Welcome Kit) | 1996 | Customer client program of the Welcome Kit, created by Marco Iannacone. | [`artifacts/customer-welcome-kit/`](../../artifacts/customer-welcome-kit/README.en.md) |
| tkined / SNMP monitoring | 1995 | Network map created from the Linux/X workstation, plus recovered SNMP files. | [`artifacts/tkined/`](../../artifacts/tkined/README.en.md) |
| DEFCON V (article) | 1997 — **post-Internet Force** | Article about DEFCON V in Las Vegas, recovered from the workstation's DAT backup. | [`defcon-v-1997/`](defcon-v-1997/README.en.md) |

**Chronology.** DEFCON V is **1997** material, later than Internet Force's
operational phase.

## Related content

- [`system/`](system/) — machine boot scripts and configuration.
- [`reference-material/xpert/`](reference-material/xpert/README.en.md) — Xpert material.
- [`artifacts/photographs/`](../../artifacts/photographs/README.en.md) — historical office photograph.

---

See also: [Development and DVLP](../../docs/07-development.en.md) ·
[Historical notes](../../docs/09-historical-notes.en.md) ·
[Monitoring](../../docs/08-monitoring.en.md) ·
[Archive provenance](../../docs/archive-provenance.en.md)
