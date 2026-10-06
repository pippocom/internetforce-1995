[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# Xpert reference material

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../../LICENSE)

During the period he spent at **Xpert UNIX Systems** in Israel in 1995, Marco
Iannacone collected configurations and technical files used as reference
examples. He later brought them to Milan and used them as a technical base to
study, adapt and improve while designing and configuring Internet Force.

These files:

- are **Xpert** material brought by Marco from Tel Aviv;
- are **not** Internet Force operational configurations;
- also document how technical knowledge and configurations were transferred and
  reused while building the ISP.

## What it contains

- `rc.linux.xpert/` — Linux boot scripts from an Xpert machine (`rc.inet1`,
  `rc.inet2`, `rc.S`, `rc.serial`, `rc.local`, …);
- `xpert.varie/` — miscellaneous system utilities and files: Apache 1.1
  configuration, `hosts`, `networks`, `inetd.conf`, Sendmail, FTP, a BIND-4 tree
  with the Xpert domain zones (`xpert.com`, `xpert.co.il`, `yahel.org`, …) and more;
- `named.boot.xpert`, `named.xpert.tar.z` — Xpert BIND-4 material;
- `mail-loc.sendmail-xpert` — reference Sendmail configuration;
- `xpert.disk-info.txt`, `README.txt` — notes from the reference machine;
- `2501yahel.txt` — a router configuration kept among Marco's material. **This
  copy has been moved** to sit with the Internet Force uplink, because it is a
  copy of the uplink Cisco 2501 configuration:
  [uplink page](../../../cisco-2501-uplink/config/2501yahel.txt).

It illustrates the environment on which Internet Force was modelled: a working
Israeli UNIX/ISP shop whose practices and tools were adapted for the Italian
service. The relationship with Xpert is also visible in the firewall rule base,
which allowed `xpert.com` remote support access to DVLP and Marco's workstation.

---

See also: [The `marco` workstation](../../README.en.md) ·
[Historical notes](../../../../docs/09-historical-notes.en.md) ·
[The Cisco 2501 uplink](../../../cisco-2501-uplink/README.en.md)
