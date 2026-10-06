[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# Gorgonzola POP

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../LICENSE)

Gorgonzola follows the standard remote-POP design: a Cisco 2501 router for
the backbone link and a Cisco 2511 access server for the modem bank.

## Router (Cisco 2501)

- Hostname `2501gorgonzola`, IOS 10.2.
- Ethernet0: `10.0.5.1/26` (`10.0.5.0/26` private segment).
- Serial0: `10.0.5.129/25`, point-to-point to the 2511 at `10.0.5.130`.
- Default route toward the world/backbone gateway (`10.0.0.1`).
- Carried the Gorgonzola dial network `206.20.225.0/24` and the
  `206.20.225.64/27` customer subnet toward the 2511.

## Access server (Cisco 2511)

- Hostname `2511gorgonzola`, IOS 10.3.
- Ethernet0: `206.20.225.65/27` on the `206.20.225.64/27` subnet.
- 16 asynchronous lines, PPP, `ip unnumbered Ethernet0`.
- Customer default addresses `206.20.225.2` … `206.20.225.17`.
- `tacacs-server host 206.20.95.4`, central authentication.

## Telephone access

The POP published an office number and a modem line block routed by the
telephone hunt group. The numbers are recorded in the recovered operations
notes.

## Pointest

`pointest.com` was the domain associated with the Gorgonzola POP. In its initial
phase it was hosted centrally on DATA; Marco Iannacone installed the CGI counter
service (`Count.cgi`) there as part of a consultancy. The snapshot of the
personal site
[`pippo.com` of 1997](../../../systems/marco/personal-web/pippo.com-1997/README.en.md)
preserves the calls to `Count.cgi` and `cgiemail` served from `pointest.com`.

## Notes

The 2511 has a dedicated line 16 configured for out-of-band use (lower speed,
password login) in addition to the 15 TACACS-authenticated lines - a common
arrangement for a console/management path at a remote site.

## Later phase: Pointest (1996)

The Gorgonzola POP was also the context of the later **Pointest** phase, distinct
from the Internet Force POP described above. The
[`pointest/`](pointest/) directory holds the material with which the autonomous
service infrastructure was built:

- `CISCO/2511BIGI.TXT` — Cisco 2511 configuration;
- `Linux/named/` — BIND/DNS;
- `Linux/popper/` — POP3;
- `Linux/xtacacsd/` — XTACACS and its configuration;
- `Linux/FSTAB.TXT` — Linux filesystem.

These files come from the configurations preserved from the later Pointest
phase, after Internet Force's closure.

---

See also: [Wind-down and migrations](../../../docs/17-wind-down-and-migrations.en.md) ·
[The POPs](../README.en.md) ·
[The Internet uplink](../../cisco-2501-uplink/README.en.md) ·
[The dial-up session](../../../docs/02-dialup-session.en.md)
