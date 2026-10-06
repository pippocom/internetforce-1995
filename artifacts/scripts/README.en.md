[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# Operational scripts

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../LICENSE)

These are the scripts and procedural notes (created by Xpert or by Marco) that ran the service day to day.

| File | Purpose |
|---|---|
| `adduser` | Create a customer account, home, jail and quota. |
| `backup_su_nastro.sh` | Full tape backup of all hosts. |
| `expire.pl` | Account/alert expiry processing for the web login area. |
| `create.m-list.index.sh` | Regenerate mailing-list indexes. |
| `MakeDNS.txt` | Notes on the DNS zone-generation procedure. |
| `system.modification-after_OSINSTALLATION.txt` | Checklist of changes applied to a new SunOS server. |
| `log-files._archive-HOWTO.txt` | Log archiving procedure. |
| `IP_ADDRESS_NOTI_DEBUG.txt` | Notes on IP-address allocation/notification. |
| `user_rename.txt` | Procedure for renaming an account. |
| `email_to_all.txt` | Bulk mail procedure. |
| `automatic_mirror-HOWTO.txt` | Scheduled mirroring of an external web site. |
| `crontab_users_data.txt` | The root `cron` jobs on USERS and DATA: `.nfs*` cleanup, `newsyslog`, web statistics, mirroring (**original**). |

These are **SANITIZED ORIGINALS** (passwords and mail credentials replaced),
except `crontab_users_data.txt`, which is a recovered **ORIGINAL** with no
credentials. The operational logic is unchanged. They support
[Customer provisioning](../../docs/12-customer-provisioning.en.md) and
[Operations and backup](../../docs/14-operations-and-backup.en.md).
