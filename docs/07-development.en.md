[🇮🇹 Italiano](07-development.md) · 🇬🇧 **English**

# Development and the build host (DVLP)

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

Internet Force kept a strict separation between the machines that served
customers and the machine used to build software. That separation is one of
the recurring themes of the architecture.

## DVLP

DVLP was a Sun SPARCstation 4 running SunOS 4.1.4 with 32 MB of RAM, on the
office LAN at `206.20.95.130`. It was not a firewall-segmented production
server and it was not the planned SHELL host. Its job was to develop, build
and stage software before it went anywhere near production.

The configuration archive records the reason for its existence in a single
line: *"In /cisco is stored the configuration of the routers."* DVLP was the
working store for router configurations and a general development area.

## The `marco` workstation was not the build chain

DVLP was a SunOS machine and remained the place where software for the Sun
servers was built. The personal workstation `marco` was instead a Linux PC
(Slackware), created as a **disposable experimentation environment**: a system
Marco could modify, break or reinstall from scratch without risking the
production servers. Over time it became the daily administration, test and
monitoring (tkined/SNMP) workstation, hosted personal PGP use and occasional
working copies, and was finally reconfigured as the transition server during
the migration to Enter.

The two machines must not be confused: **a Linux → SunOS cross-compilation was
not part of the Internet Force operational workflow**. Software for the Sun
servers continued to be built in the Sun environment (DVLP); the Linux machine
was for experimentation and testing, not for producing the production binaries.
See [Marco's workstation](../systems/marco/README.en.md) and
[Historical notes](09-historical-notes.en.md).

## Build-and-deploy model

The 1995 operational model was the classic UNIX one:

1. Obtain source or pre-built software from the Internet/FTP sites of the
   period.
2. Compile and build it locally on DVLP.
3. Test it there, including web content before publication.
4. Transfer only the runtime components to the production servers.

Production servers therefore carried a minimal set of software. Compilers
and development tools stayed on DVLP; DATA and USERS ran only what they
needed to provide service. The transfer mechanism in the first phase was the
internal FTP service, with SSH/SCP added in 1996 as secure alternatives.

Because the production hosts were built rather than installed wholesale, the
exact package set on each is best understood through the
[software inventory](11-software-inventory.en.md) and the individual system
pages.

## Router configuration management

The Cisco configurations had two working homes. DVLP kept them under
`/cisco`, and the Cisco devices themselves were loaded from a TFTP staging
directory on Marco's workstation; new POP configurations were created by
copying a known-good template, editing the addresses and writing the
configuration back. The recovered `CISCO-add_new_pop-HOWTO` documents this
procedure, including the console dialogue for a new router.

The canonical published copies of the router configurations live under
[the uplink](../systems/cisco-2501-uplink/README.en.md) and
[the POPs](../systems/pops/README.en.md); DVLP's `/cisco` is described here for
historical completeness, not duplicated.

## Content testing

Web pages were always tested on DVLP before being published to USERS or
DATA. The HTML workflow was: edit, upload to DVLP, verify, then release to
the production server. This kept broken pages off the public sites and kept
the authoring tools off the production machines.

## Remote and secure access

In the first phase, administration used telnet and rlogin/rsh plus FTP over
dedicated firewall rules. In 1996 **SSH and SCP** were introduced and became
the standard way to reach the servers and move files.

## Representative configuration

The build-and-deploy model leaves traces in the recovered operational files.
Example from `artifacts/scripts/system.modification-after_OSINSTALLATION.txt`,
recording a change prepared and applied to a production host (`users`):

```text
30 2 * * * /users/01/ianna/home/public_html/tools/stats/intf.stat
```

A change was prepared and tested on DVLP, then applied to the production host;
the file documents exactly that step.

→ Complete evidence: [`artifacts/scripts/system.modification-after_OSINSTALLATION.txt`](../artifacts/scripts/system.modification-after_OSINSTALLATION.txt) ·
[`systems/dvlp/README.en.md`](../systems/dvlp/README.en.md)

---

See also: [Operations and backup](14-operations-and-backup.en.md) ·
[Software inventory](11-software-inventory.en.md) ·
[DVLP system](../systems/dvlp/README.en.md) ·
[Learning the Internet](23-learning-internet-culture.en.md)

---

→ [Build an Internet Force POP, step by step](00-build-an-isp.en.md)
