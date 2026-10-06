[🇮🇹 Italiano](14-operations-and-backup.md) · 🇬🇧 **English**

# Operations and backup

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

This page collects the routine operational practices: how the systems were
brought up and shut down, how data was backed up and restored, and the
scheduled jobs that kept the service running.

## Startup and shutdown order

The central servers had dependencies, so they were booted in a fixed order:

1. **FIREWALL** — the security gateway first, so that the protected segments
   came up inside a controlled network.
2. **DATA** — the primary DNS and public services.
3. **USERS** — authentication, mail and customer services.
4. **DVLP and Marco's workstation** — the office/development side.

Shutdown was the reverse: the systems were halted with `shutdown` and the
power was not simply switched off.

## Full backups

The backup device was a tape drive attached to **DVLP** (`/dev/rst0`, or
`/dev/nrst0` to append). Full backups of every host were written with GNU
`tar` (`gtar`) as a stream, for example:

```
mt -f /dev/rst0 rewind
gtar -czvf - /. | dd bs=220k of=/dev/nrst0
(rsh data    gtar -czvf - /)  | dd bs=220k of=/dev/nrst0
(rsh users   gtar -czvf - /)  | dd bs=220k of=/dev/nrst0
(rsh firewall gtar -czvf - /.) | dd bs=220k of=/dev/nrst0
```

DATA, USERS and FIREWALL were backed up across the internal network with
`rsh`, which is why the hosts had to be trusted to each other on the office
and firewall-facing segments. Before starting, mounted filesystems were
checked with `df` and removable media (such as the CD-ROM) were unmounted so
they were not captured.

**Incremental** backups used the standard `dump` facility.

## What happened to the tapes

The DAT tapes used for operational backups belonged to Internet Force and
remained with the company; they are therefore not part of the historical
archive available today.

A different DAT cassette did, however, “remain” with the author. It contained
a copy of his Linux workstation `marco` made at the time. In 2026 he rented a (partially) compatible
DAT drive to recover its contents. The tape proved to be an
important source of additional configurations, documentation, mail and source
code.

Some recovered `tar` archives, originally created on or processed through
DVLP, are only partially readable today: in some cases directory structure
and filenames survive while individual contents are empty, truncated or
corrupted.

For details about provenance and recovery limitations see
[Archive provenance](archive-provenance.en.md).

## Restoring

Reading or restoring a tape used the same tools:

```
gtar -tzvf /dev/rst0                 # list contents
gtar -tzvf /dev/rst0 etc/test.doc    # find one file (no leading slash)
gtar -xzvf /dev/rst0 etc/test.doc    # extract it
mt -f /dev/rst0 offline              # eject
```

## Scheduled tasks

`cron` on USERS and DATA ran the routine jobs:

- cleanup of stale NFS placeholder files (`.nfs*`) older than a week - a
  housekeeping habit carried over from the stock SunOS environment;
- `newsyslog` for log rotation;
- cleanup of the `/var/preserve/` directory;
- regeneration of web statistics and mail statistics;
- the scheduled `webcopy` mirror of an external site on DATA;
- account expiry processing for the web login area.

The root crontabs for both hosts are preserved in
[`artifacts/scripts/crontab_users_data.txt`](../artifacts/scripts/crontab_users_data.txt).

## Logging

The servers forwarded their `syslog` output to **DVLP** as the central
`loghost`, so one host held the combined logs. The firewall logged its own
management and traffic events through the FireWall-1 logging channel.

## System modification after OS installation

The archive includes a checklist of changes applied to a fresh SunOS server
after installation: enabling the required services, tightening file and
directory ownership (for example `/usr/local/ftp/etc`), configuring the mail
and DNS roles, and applying the local operational conventions. This
"system modification after OS installation" note is the closest thing to a
build standard for a new host.

## User and quota management

Day-to-day account work ran alongside the provisioning tools: creating and
removing users, resetting passwords, and applying or adjusting disk quotas
on the customer filesystems with `edquota` and `quotacheck`; the recovered
quota profiles are in
[`systems/users/system/quota.txt`](../systems/users/system/quota.txt). Details
are in [Customer provisioning](12-customer-provisioning.en.md).

---

See also: [Development](07-development.en.md) ·
[Monitoring](08-monitoring.en.md) ·
[Architecture overview](01-architecture.en.md)

---

→ [Build an Internet Force POP, step by step](00-build-an-isp.en.md)
