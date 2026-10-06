[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# DNS configuration and zones (DATA)

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../LICENSE)

The primary nameserver files from DATA. This is the BIND-4 configuration and
the complete zone set for the period.

| Item | Description |
|---|---|
| `named.boot`, `named.boot.save` | BIND-4 boot file; the current list and an earlier one. |
| `named-data/primary/*` | Primary zones, including the internal domains and the hosted customer/virtual domains, plus the reverse zones. |
| `named-data/secondary/*` | Secondary zone material (for example `cnn.it`). |
| `named-data/*.source` | The master source files from which zones are generated. |
| `named-data/root.cache` | Root nameserver hints. |
| `makezones-0.10`, `Makefile`, `makedns.*` | The zone-generation workflow. |
| [`new_dns-HOWTO.txt`](new_dns-HOWTO.txt) | The original HOWTO for registering a new domain and using VIF (**original**). |
| [`DOMAIN-PROVISIONING-WORKFLOW.md`](DOMAIN-PROVISIONING-WORKFLOW.md) | Modern didactic explanation of the same workflow (**modern documentation**, not an original). |

The zones and configurations are **SANITIZED ORIGINALS**; `new_dns-HOWTO.txt`
is a recovered **ORIGINAL**. The files are the source for
[DNS](../../../docs/03-dns.en.md). The original HOWTO is accompanied by the
modern workflow [`DOMAIN-PROVISIONING-WORKFLOW.md`](DOMAIN-PROVISIONING-WORKFLOW.md),
which preserves its operational sequence without replacing it. The `makezones`
tool is also listed under
[`artifacts/tools/`](../../../artifacts/tools/README.en.md).
