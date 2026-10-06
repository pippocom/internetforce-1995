[🇮🇹 Italiano](20-mailing-lists-majordomo.md) · 🇬🇧 **English**

# Mailing lists (Majordomo)

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

## What problem this solves

Beyond personal mailboxes, Internet Force offered managed **mailing lists**:
subscription, approval, distribution to members and consultable archives. A
list's mail is not personal mail: it needs an agent that manages members and
redistributes messages.

## How Internet Force implemented it

**Majordomo** ran on **DATA** and provided the mailing-list service. It integrated
with **Sendmail** through mail aliases: each list had the standard aliases (post
to the list, requests, subscription, approval, archive), and subscriptions were
approved **by command sent via mail** (not through a web interface). List archives were
converted to **HTML** with a Hypermail-based workflow.

Lists known from the material: **`intf-list`**, **`coach`**, **`marketing-l`**
(with a digest edition) and **`cosmo-answer`**.

## Components and hosts

- **DATA** — runs Majordomo and the list archives.
- **Sendmail** — delivery and aliases (see [Mail](04-email.en.md)).

## Representative evidence

The recovered material documents the real use of the lists, for example the
subscription request to the `coach` list
(`systems/data/majordomo/coach.txt`) and the procedure to create a list
(`systems/data/majordomo/HOWTO-create.m-list.txt`).

→ Complete material: [`systems/data/majordomo/`](../systems/data/majordomo/README.en.md)
→ HTML archive index: [`artifacts/scripts/create.m-list.index.sh`](../artifacts/scripts/create.m-list.index.sh)

### Reconstructed example (list aliases)

The material preserves the list **names** and the management model, but not a
complete `aliases` file. The block below is therefore **RECONSTRUCTED** and is not
a recovered file; it uses only documented list names and the Majordomo model:

```text
# Reconstructed example
coach:              "|/usr/local/majordomo/wrapper resend -l coach coach-out"
coach-out:          :include:/usr/local/majordomo/lists/coach
coach-request:      "|/usr/local/majordomo/wrapper majordomo -l coach"
coach-approval:     owner-coach
owner-coach:        marco@intf.com
```

The `/usr/local/majordomo/` path is illustrative: the exact install location on
DATA is not preserved.

## How it connects to the rest of the POP

Majordomo depends on Sendmail for delivery; the HTML archives rely on the web
server. See [Mail](04-email.en.md) and
[Web, FTP, news and mailing lists](05-web-news-ftp.en.md).

## Related original material

- [`systems/data/majordomo/README.en.md`](../systems/data/majordomo/README.en.md)
- [`systems/data/README.en.md`](../systems/data/README.en.md) — the DATA server.
- [`artifacts/tools/digest.shar`](../artifacts/tools/digest.shar) — digest tools.

---

← [Build a POP](00-build-an-isp.en.md) ·
Previous: [FTP](05-web-news-ftp.en.md) ·
Next: [Security](06-security.en.md) →
