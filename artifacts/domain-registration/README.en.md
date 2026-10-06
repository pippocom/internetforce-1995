[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# Domain registration

> **Internet Force 1995--1996 Historical Archive**\
> Historical reconstruction and technical documentation based on
> original Internet Force materials preserved by **Marco Iannacone**.\
> Author and archive curator: **Marco Iannacone** · https://pippo.com\
> License: [CC BY 4.0](../../LICENSE)

This area collects the reconstruction of the historical procedures Internet
Force followed in 1995--1996 to register domains, both international
(`.com`/`.net`) and Italian (`.it`), based on the operations that are actually
documented.

Registering a domain was not a simple online purchase as it is done today: it required
coordinating administrative information, DNS configuration, primary and
secondary nameservers, and a formal request sent to external parties
(InterNIC for `.com`/`.net`, GARR-NIS for `.it`). The documents here show that
work concretely.

## Documents

### .com/.net domain registration

Complete documentation of the registration procedure for international
(`.com`/`.net`) domains, covering DNS preparation, interaction with IDT for the
secondary nameserver, and filling in the InterNIC registration template.

- English: [`domini_com_net.en.txt`](domini_com_net.en.txt)
- Italian: [`domini_com_net.txt`](domini_com_net.txt)

### .it domain registration

Complete documentation of the registration procedure for Italian (`.it`)
domains, covering the administrative data requested by GARR/the registry, the
DNS configuration and the operational exchanges through to completion.

- English: [`domini_it.en.txt`](domini_it.en.txt)
- Italian: [`domini_it.txt`](domini_it.txt)

## Original email exchanges

The documents reconstruct the procedure; the mailboxes let you read the
original exchanges from which it was derived. They stay in their canonical
location, `artifacts/email-archive/technical/`, and are not copied here:

- [`DOMAIN.mailbox`](../email-archive/technical/DOMAIN.mailbox) — InterNIC
  notifications and templates (`.com`);
- [`DOMAIN-IDT.mailbox`](../email-archive/technical/DOMAIN-IDT.mailbox) —
  `.com` registrations and exchanges with IDT for the secondary nameserver;
- [`GARR-DOMINI_IT.mailbox`](../email-archive/technical/GARR-DOMINI_IT.mailbox)
  — `.it` registrations with GARR-NIS;
- [`ITALIAN_POSTMAST.mailbox`](../email-archive/technical/ITALIAN_POSTMAST.mailbox)
  — GARR postmaster list (maintainer, orphan domains);
- [`IDT.mailbox`](../email-archive/technical/IDT.mailbox) — further exchanges
  with IDT.

## DNS configurations

Domain registration was tightly linked to DNS configuration: the zone had to
be ready and the nameservers reachable. The operational configurations of the
period are kept under [`systems/data/dns/`](../../systems/data/dns/README.en.md),
with the zones under
[`systems/data/dns/named-data/`](../../systems/data/dns/named-data/).

Zones used as examples in the two documents:

- [`primary/pippo.com`](../../systems/data/dns/named-data/primary/pippo.com) —
  `.com` zone;
- [`primary/promotion.it`](../../systems/data/dns/named-data/primary/promotion.it)
  — `.it` zone;
- [`secondary/cnn.it`](../../systems/data/dns/named-data/secondary/cnn.it) —
  `.it` zone managed as a secondary;
- [`named.boot`](../../systems/data/dns/named.boot) — list of the zones
  declared on the Internet Force DNS.

## Continue exploring

- [DNS](../../docs/03-dns.en.md)
- [Adding a new customer domain (workflow)](../../systems/data/dns/DOMAIN-PROVISIONING-WORKFLOW.en.md)
- [BIND on DATA: technical configuration](../../systems/data/dns/TECHNICAL.en.md)
- [Email archive](../email-archive/README.en.md)
