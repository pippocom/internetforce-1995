[🇮🇹 Italiano](BACKUP.md) · 🇬🇧 **English**

# DVLP and DAT backups

> **Internet Force 1995–1996 Historical Archive**\
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.\
> Author and archive curator: **Marco Iannacone** · https://pippo.com
> License: [CC BY 4.0](../../LICENSE)


DVLP was not only the development server. It also had an operational role in Internet Force backup procedures.

A **DAT** drive attached to DVLP was used for system tape backups. Recovered documentation preserves procedures based on Unix tools such as `gtar` and `dump`.

This makes DVLP an interesting architectural point: development, configuration storage and tape backup converged on the same system while production services remained separate.

The device was `/dev/rst0` (or `/dev/nrst0` to append without rewinding); the
complete commands (`gtar`/`dd`, `dump`, restore) are in
[Operations and backup](../../docs/14-operations-and-backup.en.md). The **exact
drive model** and the backup **frequency/rotation** are not recorded in the
recovered material: they remain a known gap, not a procedure to invent.

The operational tapes belonged to Internet Force and are not available in the present archive.

See also:

- [Operations and backup](../../docs/14-operations-and-backup.en.md)
- [Archive provenance](../../docs/archive-provenance.en.md)
