# People, machines and workflows

> **Internet Force 1995--1996 Historical Archive**\
> Technical reconstruction and documentation based on original
> Internet Force materials preserved by **Marco Iannacone**.\
> Author and archive curator: **Marco Iannacone** · https://pippo.com\
> License: [CC BY 4.0](../LICENSE)

[Versione italiana](15-people-and-workflows.md)

## 1. Why document the people as well

Internet Force infrastructure was not made only of Sun systems, Cisco
equipment, modems and serial lines. The office network also shows how
work was distributed among people, workstations and central systems.

In this sense, the hostnames form a kind of **fossilized organization
chart**. The main servers had functional names (`data`, `users`,
`dvlp`); many office workstations were instead named after their users
(`anna`, `laura`, `alice`, `salvatore`, `maus`, `pascal`, `marco`) or
their function (`html`). `maxi` was the portable workstation used by the
head of sales.

This page reconstructs the relationship between people, machines and
operational processes. Hardware specifications are included when
recovered from the documentation or reconstructed with sufficient
confidence; missing information is left open rather than invented.

## 2. Office LAN

The office network used the public **206.20.95.128/25** subnet. It was
connected to the firewall through `le0` (`206.20.95.129`) and used a
10Base-T Ethernet hub identified in the documentation as a **3Com
LinkBuilder FMS II**.

  ------------------------------------------------------------------------
  Host                                IP System /         Main role
                                         hardware
  ---------------- --------------------- ---------------- ----------------
  `anna`                 `206.20.95.131` exact model      administration
                                         unknown          and first-level
                                                          customer support

  `franz`                `206.20.95.132` Macintosh, exact commercial
                                         model unknown    management, PR,
                                                          advertising,
                                                          promotion and
                                                          partnerships

  `maxi`                 `206.20.95.133` PowerBook 190    sales: B2B/B2C
                                         16 MB RAM        subscriptions,
                                                          websites and
                                                          application
                                                          development

  `html`                 `206.20.95.134` Macintosh, exact HTML authoring
                                         model unknown

  `laura`                `206.20.95.135` Power Macintosh  editorial / DTP
                                         9500, 2 GB,
                                         probably 32 MB
                                         RAM

  `alice`                `206.20.95.136` Power Macintosh  editorial / DTP
                                         9500, 2 GB

  `salvatore`            `206.20.95.137` Power Macintosh, art direction /
                                         exact model not  graphics
                                         identified,
                                         probably 32 MB
                                         RAM

  `maus`                 `206.20.95.138` Power Macintosh  office hardware
                                         8500, 16 MB RAM, support
                                         1 GB

  `pascal`               `206.20.95.139` Power Macintosh  IT Director
                                         9500, 2 GB

  `marco`                `206.20.95.140` 486DX Linux, 16  system & network
                                         MB RAM, 1 GB     administration
                                         SCSI
  ------------------------------------------------------------------------

All recovered Power Macintosh 9500 systems had **2 GB disks**; one had
**32 MB of RAM**. In all probability
the most powerful configuration was `laura`, one of the main DTP
workstations. `salvatore`, also a power-user workstation, probably had
32 MB, but Marco was unable to reconstruct the precise Power Macintosh model.

## 3. Technical and organizational roles

### Pascal --- IT management

`pascal` was used by the **IT Director**. The role reflected broad
technical competence across the office systems, particularly Windows and
Macintosh environments, as well as professional seniority.

IT management did not, however, coincide with specialist responsibility
for the Internet infrastructure. Pascal consulted Marco on a number of
technical domains; specialist work such as the later Windows NT and
Oracle project was outside Pascal's operational expertise.

### Marco --- system & network administration

Marco Iannacone worked for Internet Force as a **full-time consultant**,
on a fixed monthly fee, with ongoing responsibility for administration
of the provider's Unix systems and network infrastructure.

The [surviving 1996 consulting contract](../artifacts/company/marco-iannacone-consulting-contract-1996/README.en.md) formally documents this professional relationship.

His scope included the SunOS servers, Internet services, Cisco network,
POPs, authentication, DNS, mail, Web, security and monitoring. The
`marco` workstation was a 486DX PC running Linux Slackware 2.1, with 16 MB
of RAM and 1 GB of SCSI storage; it was also used for SNMP monitoring
through tkined.

When Internet Force needed work outside the normal assignment, the
partners separately asked Marco whether he was available and had the
necessary skills. These became additional consulting engagements. Two
examples were **Easy!**, software commissioned by Internet Force to
simplify customer access to its services, and the **Windows NT +
Oracle** project triggered by a customer request.

### Maus --- hardware support

`maus`, a Power Macintosh 8500 with 16 MB of RAM and a 1 GB disk, was
used for **office hardware technical support**, with particular
attention to the editorial department's machines.

The editorial department also included other people focused mainly on
the printed magazine and less directly involved in the Internet Force
activities documented by this archive.

### Laura and Alice --- editorial and DTP

`laura` and `alice` were Power Macintosh 9500 systems used by the
editorial team. They ran a professional desktop-publishing and graphics
suite including **QuarkXPress, Adobe PageMaker, Adobe Photoshop and
Adobe Type Manager**.

The editorial team produced both Web content and a printed magazine.
Editorial and graphical work therefore belonged to an environment
combining print production and Internet publishing.

### Salvatore --- art direction and graphics

`salvatore` was a Power Macintosh workstation used for **art direction
and graphics production**. Final images and graphical assets for
websites and other company materials were prepared there.

The exact Power Macintosh model has not yet been identified.

### HTML --- Web authoring

`html` was the workstation dedicated to **manual HTML authoring**. In
1995, producing a website largely meant writing markup directly,
integrating text and graphical assets, and checking the result with the
browsers of the period.

### Maxi --- sales

`maxi` was the workstation used by the **sales area**. Its role is part
of the organizational reconstruction: selling annual Internet
subscriptions to both **B2B and B2C** customers, websites, application
development and other professional services offered by Internet Force.

The hardware identification is instead reconstructed from memory: it was
most likely a **PowerBook 190 with 16 MB of RAM**.

### Anna --- administration and first-level customer support

`anna` (`206.20.95.131`) was the **administrative office** workstation.
New-customer forms received from the sales area were entered into the
management system here, linking the sales process with the
administrative and technical provisioning of subscriptions; the collected
data were then sent to Marco for the technical activation of the accounts
on `users`.

The administrative office also provided **first-level customer
support**, handling support email addressed to customer service and
escalating issues that required work on infrastructure or services to
the technical level.

### Franz --- commercial management and external relations

`franz` (`206.20.95.132`) was the workstation of the **Commercial
Director**, a journalist who also managed relations with the press.

The role covered **public relations, advertising, promotion and
partnerships**, as well as commercial coordination. The workstation was
a Macintosh; its exact model has not been identified. `franz` is
intentionally omitted from the Office LAN infographic for visual
simplicity, but is documented here as part of the organizational
reconstruction.

## 4. Web production workflow

Website production followed a process separated from production on the
public servers.

1.  The editorial team prepared text and content; art direction produced
    the graphical assets.
2.  HTML pages were manually assembled on the `html` workstation.
3.  Files were exchanged through an internal FTP area set up on `dvlp`.
4.  Completed sites were placed in a directory named `siti`.
5.  Marco retrieved the material, checked completeness and
    functionality, and published it on `data`.
6.  When a project required interactivity, Marco developed the relevant
    CGI programs.

Editorial staff therefore did not deploy directly to production systems.
In practice there was a separation between authoring, file
exchange/review, and publication to the public server, without
retroactively applying CI/CD terminology that belongs to a much later
period.

In March 1996 Marco installed **PHP/FI**. **Postgres95** was later
installed on `data`, the name the database used at the time before becoming
PostgreSQL. The Web environment therefore evolved from
hand-written static HTML to CGI programs, then server-side scripting and
eventually database-backed applications.

## 5. Subscriber provisioning and support

The lifecycle of a new subscriber involved the sales area, the
administrative office and the technical infrastructure.

After the sale and collection of the required information, the account
was created on `users`, including login, home directory, mailbox, quota
and the intended user environment. The customer received configuration
material, the Welcome Kit and the telephone number of the POP to dial.

During a connection, the call reached an available modem through the
telephone hunt group and then the Cisco 2511. The access server queried
`users` centrally through XTACACS to authenticate the subscriber. User
assistance and office support could involve several people; issues
concerning Unix infrastructure, networking and central services reached
Marco. When necessary, specialist external support was also available
through Xpert UNIX Systems in Tel Aviv.

## 6. A multiplatform office

The Office LAN was deliberately heterogeneous. Macintosh System 7.5.x
was widely used for editorial work, graphics, sales and Web production;
Linux was the platform of Marco's technical workstation; the central
systems ran SunOS.

In 1996 `oracolo` (`206.20.95.142`) was added, a **Windows NT + Oracle**
system created for a consulting project requested by a customer.
Internet Force asked Marco whether he was willing to take it on; having
no previous operational experience with that platform, he studied NT and
Oracle and implemented the project as additional work outside his normal
system-administration assignment.

## 7. Naming the machines

In Unix culture it was common to assign hosts names drawn from a shared
universe: mythology, astronomy, literature or science fiction.

Marco initially proposed names from **The Lord of the Rings**; his
second choice was the **Greek Olympus**, and his third **Star Wars**.
The partners considered the convention too playful for the company and
preferred functional names for the servers (`data`, `users`, `dvlp`) and
user-related names for the workstations.

The first significant exception arrived with the Oracle project. Marco
personally named the new Windows NT machine `oracolo`, without
submitting the choice to any further naming committee.

## 8. What these hosts tell us

The office network documents something router configurations alone
cannot show: Internet Force was simultaneously an Internet provider, an
editorial environment, a Web workshop and a technical-services company.

Print publishing, professional graphics, HTML authoring, sales, hardware
support, Unix administration and software development all coexisted on
the same LAN. The recovered `hosts` files, configurations and surviving
materials therefore allow us to reconstruct not only **which machines
existed**, but **how work moved through those machines**.
