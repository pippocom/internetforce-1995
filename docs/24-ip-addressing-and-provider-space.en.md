🇬🇧 **English** · [🇮🇹 Italiano](24-ip-addressing-and-provider-space.md)

# IP addressing: public space, private backbone and carrier dependency

> **Internet Force 1995–1996 Historical Archive**  
> Technical reconstruction and documentation based on the surviving Internet Force material preserved by Marco Iannacone and on his direct testimony as system and network administrator.  
> Author and archive curator: Marco Iannacone · https://pippo.com  
> License: [CC BY 4.0](../LICENSE)

Building an ISP in 1995 required more than modems, routers, Unix servers and an Internet uplink. It also required something less visible but essential: **public IPv4 address space that the rest of the Internet knew how to reach**.

For a small ISP, in practical terms this normally meant obtaining one or more blocks of public addresses from the carrier or upstream provider. In the language commonly used at the time these were often simply called **“Class C networks.”** The addresses then had to be divided among the central infrastructure, routers, servers, POP networks and dial-up users.

Internet Force followed exactly this model. Its original public address space was supplied in the context of the relationship with **IDT**, its international upstream. When the POPs were made independent during the shutdown of Internet Force, they could not simply keep the old addresses: they obtained new links and new address space from the new carrier, **COMM 2000**, and their equipment and services had to be renumbered.
Forget Software Defined Networking, centralized controllers, or automated provisioning: in 1995, IP addressing was a manual job. Marco Iannacone had to design the new subnets, decide which address blocks to assign to the different POPs and devices, and reconfigure routers, access servers, servers, and services one by one so that they would use the new addresses.

That dependency between carrier, routing and addressing is one of the aspects that most clearly separates the commercial Internet of the mid-1990s from today's domestic Internet experience.

---

## 1. Four concepts that are easily confused today

### Public or private

A **public address** is globally routable. A Web server, DNS server or dial-up host using one can, in principle and subject to firewall policy, be reached across the Internet.

A **private address** belongs to space intended for internal use and is not routed on the public Internet. RFC 1597 had already formalised private address space in 1994, including `10.0.0.0/8`; RFC 1918 would consolidate the model in 1996.

Internet Force actually used `10.0.0.0/8` as its private backbone.

### Static or dynamic

“Public” does not mean “static”, and “private” does not mean “dynamic”.

Servers and network devices normally need stable addresses. A dial-up user, on the other hand, can receive a **different public address for each connection**.

This was normal for Internet access at the time and is also what emerges from the Internet Force Cisco 2511 configurations: asynchronous lines had public addresses available for PPP sessions. The address belonged to the session or line, not permanently to the person making the call.

### Addressing and NAT

**NAT** is a separate mechanism that translates between address spaces. RFC 1631 already described it in 1994, but in 1995 it was not yet the universal domestic model it later became.

A typical home today has several devices using private addresses such as `192.168.x.x`, with a router presenting them to the Internet through one or a few public addresses. A 1990s dial-up customer, by contrast, could receive a **real public IPv4 address directly on the PC**.

### Address and network position

An IP address was not merely a number attached to a machine. It also described **where that machine lived in the routing topology**.

That is why changing carrier could require changing addresses. This is exactly what happened during the Internet Force wind-down.

---

## 2. “Class C” in 1995 language

CIDR had already been introduced by RFC 1519 in 1993. That did not make classful terminology disappear overnight.

Networking books, operational documentation and technical conversations still routinely used **Class A, Class B and Class C**. For a small ISP, asking for or receiving “a Class C” was a natural way to describe a 256-address IPv4 network, historically a `/24`.

Internet Force existed precisely during that transition. This archive therefore retains the historical terminology when describing how engineers spoke and worked at the time, while using CIDR notation whenever an original netmask can actually be established.

It is equally important not to turn every `206.x.x.x` network retroactively into a `/24`: Internet Force subnetted the space it received, and surviving configurations show more specific masks for some segments.

---

## 3. Internet Force public address space

The public addresses used by Internet Force were supplied by **IDT** together with upstream connectivity. The surviving configurations show how that space was then used.

### The IDT-facing link

The central Cisco 2501 had:

- internal interface: `10.0.1.1`;
- serial upstream interface: `206.20.64.30/30`;
- Frame Relay peer: `206.20.64.29`.

The historical tkined map labels the `.29/.30` ends differently. The surviving Cisco configurations identify `.30` as the local 2501 address and `.29` as the peer. The archive records this source conflict rather than silently correcting it.

### Central services

Documented public addresses include:

| Function | Address |
|---|---:|
| DATA | `206.20.95.3` |
| USERS | `206.20.95.4` |
| firewall toward DATA | `206.20.95.10` |
| firewall toward USERS | `206.20.95.11` |
| planned SHELL firewall interface | `206.20.95.12` |
| office network | `206.20.95.128/25` |
| firewall toward office | `206.20.95.129` |
| `marco` workstation | `206.20.95.140` |

DATA and USERS therefore had stable public identities, while the firewall separated the segments and enforced access policy.

### Milan dial-up

The Milan dial-up network `206.20.95.64` is documented with netmask `255.255.255.192`, or `/26`.

The key distinction is:

```text
server/router             -> stable public address
dial-up user during PPP   -> public address assigned to the session
internal backbone         -> private 10.x.x.x address
```

The customer PC was not hidden behind provider NAT. During the PPP session it became a directly addressed node on the public Internet.

---

## 4. Private backbone and public POP networks

Internet Force used private and public addresses at the same time because they served different purposes.

The internal backbone was `10.0.0.0/8`. Documented examples include:

| Node | Private address |
|---|---:|
| `fw-world` firewall interface | `10.0.0.1` |
| World Hub | `10.0.0.254` |
| central Cisco 2501 | `10.0.1.1` |
| Milan Cisco 2511 | `10.0.2.1` |
| Pesaro Cisco 2501 | `10.0.3.1` |
| Palermo Cisco 2501 | `10.0.4.1` |
| Gorgonzola Cisco 2501 | `10.0.5.1` |

The public networks associated with the four initial POPs were:

| POP | Documented public space | Documented example |
|---|---|---|
| Milan | `206.20.95.64` | `/26` network confirmed |
| Pesaro | `206.20.115.0` | Cisco 2511 `206.20.115.65` |
| Palermo | `206.20.224.0` | Cisco 2511 `206.20.224.65` |
| Gorgonzola | `206.20.225.0` | Cisco 2511 `206.20.225.65` |

The masks for the three remote POPs should not be inferred merely because those addresses historically fall in Class C space. Where the original mask cannot be established unambiguously, the archive should not invent it.

---

## 5. How a dial-up user received an IP address

A typical path was:

```text
telephone call
  -> modem
  -> Cisco 2511 asynchronous line
  -> XTACACS authentication
  -> PPP session
  -> public IPv4 address
  -> routing toward the 2501
  -> IDT
  -> Internet
```

The Cisco 2511 configurations show `encapsulation ppp`, `ip unnumbered Ethernet0` and addresses preconfigured for asynchronous lines.

From the customer's perspective the address was **dynamic**, because it depended on the connection. From the ISP's perspective those addresses came from already assigned and routed public space.

This is why “dynamic IP” and “private IP” are not synonyms.

---

## 6. Adding a POP also meant obtaining addresses

A POP was not ready merely when its routers, modems and telephone lines arrived.

It also needed the data link, public IPv4 space, addresses for the router and access server, addresses for dial-up sessions, routing toward the rest of the infrastructure, and reachable DNS and authentication services.

This is why addressing belongs in the **“Build an ISP”** path before the final router and service configuration.

The carrier did not merely provide “bandwidth”. It also provided part of the IP topology in which the ISP had to operate.

---

## 7. Detaching the POPs: the IDT addresses could not simply follow them

During the Internet Force wind-down, Marco Iannacone designed and organised a progressive decommissioning of the infrastructure.

The first stage was to make the POPs that intended to continue operating independent. That required much more than moving a router.

For each POP, the new connection and new public address space had to become available first. The carrier used for this stage was **COMM 2000**. Only then could the equipment be renumbered, local services be prepared, and the accounts belonging to that POP's customers be copied to the new local systems.

The accounts were therefore not all moved to one replacement ISP. Customers belonging to the detached POPs moved with their respective infrastructures. **Only the Milan customers were subsequently migrated to Enter.**

---

## 8. Three post-Internet Force address spaces visible in the archive

### Pesaro Point

Post-Internet Force Pesaro configurations use:

`195.120.225.*`

They include routes to:

- `195.120.225.160/27`
- `195.120.225.192/27`

via `195.120.225.3`.

Other preserved configurations include PPP addresses such as `195.120.225.99` and `195.120.225.102`, and `195.120.225.6` used by DNS/TACACS in later snapshots.

### Pointest / Gorgonzola

The former Gorgonzola POP, later **Pointest**, moved into:

`194.133.145.*`

A preserved historical item explicitly identifies:

`shelley.pointest.com = 194.133.145.2`

`shelley` was the Linux system used for local Pointest services such as DNS, POP3 and XTACACS.

The Cisco configuration from that phase survives at:

`systems/pops/gorgonzola/pointest/CISCO/2511BIGI.TXT`

That file gives the exact addresses of the Pointest router (`hostname 2511gorgonzola`, `ip domain-name pointest.com`):

| Item | Documented value |
|---|---|
| Ethernet0 | `194.133.2.196/27` (`255.255.255.224`) |
| Serial0 (toward the carrier) | `194.133.3.174/30` (`255.255.255.252`) |
| Default route | `0.0.0.0/0` via `194.133.3.173` |
| Asynchronous lines | `ip unnumbered Ethernet0`, `async default ip address` from `194.133.2.206` to `194.133.2.221` |
| TACACS server | `194.133.2.197` |
| Name server | `194.133.0.2` |

The router's Ethernet network was therefore `194.133.2.192/27`; `shelley`, the local Linux server, is instead attested at `194.133.145.2`, in another subnet of the same `194.133.*` space. The addresses are quoted as they appear in the configurations, without normalising them.

### Infosfera / Bergamo

The Infosfera/Bergamo material uses another address space:

`194.235.140.*`

The recovered Cisco 2511 configuration includes:

`async default ip address 194.235.140.230`

### A network splitting apart

```text
Internet Force / IDT
    206.20.x.x
        |
        +--> Pesaro Point        195.120.225.x
        |
        +--> Pointest            194.133.145.x
        |
        +--> Infosfera/Bergamo   194.235.140.x
        |
        +--> Milan -> Enter      194.20.50.x
```

The addressing itself became an archaeological trace of the ISP's decomposition.

---

## 9. COMM 2000

**COMM 2000** was a Milan telecommunications operator founded in 1985. It was one of the private companies that entered the Italian market early with telecommunications services outside the incumbent monopoly, first with network and messaging services and later with Internet and business data services.

During the 1990s it became one of Italy's significant independent business ISPs. In the Internet Force wind-down its role was very practical: **it supplied the new carrier links and public address space needed by POPs that were becoming independent from the Internet Force/IDT network**.

That role is documented here from Marco Iannacone's direct testimony as the engineer who managed the migration. The surviving technical material independently documents the resulting renumbering through the different post-Internet Force address spaces.

COMM 2000 was acquired by KPNQwest in 2000 and renamed KPNQwest Italia. The Italian operation returned to Italian ownership in 2003. Messagenet had also been created from the COMM2000 group in 1999, initially around Internet fax services and later becoming well known for VoIP.

---

## 10. The final renumbering: `marco` from Internet Force to Enter

The Enter migration happened **after** the POPs had already been made independent.

At that point the old infrastructure still had the Milan customers and the central services that had to survive the transition.

The Linux workstation `marco`, formerly the Internet Force administration workstation at `206.20.95.140`, was reformatted and reinstalled with Linux. While Internet Force was still running, Marco Iannacone prepared it to absorb the data and services previously distributed mainly between `USERS` and `DATA`, and copied the required data before the final cutover.

Milan customers had already been informed by email of the new Enter dial-up numbers.

The final migration was physical:

```text
USERS + DATA
      |
      | data copied beforehand
      v
    marco
      |
      | final Internet Force shutdown
      | machine disconnected, loaded on his own car and physically moved by him
      v
    Enter
      |
      v
      | Marco reconfigure everything
      +--> new main address: 194.20.50.14
      +--> virtual IPs for Web services
      +--> DNS updates
      +--> services restarted
```

Marco Iannacone shut down the Internet Force infrastructure, disconnected `marco`, personally transported it to Enter, powered it up on the new network, changed its IP address, configured the virtual IPs required for the Web sites and updated the DNS records.

**About two hours after the Internet Force shutdown, the services were running again.** Milan customers could connect using the new Enter dial-up numbers that had already been communicated.

The surviving Enter DNS material shows `marco` at `194.20.50.14` and makes roles such as `users`, `mail`, `mailhost`, `loghost` and the MX records for `internetforce.com` and `intf.com` converge on that machine. The files therefore document the result of the migration described by the administrator.

The move from `206.20.95.140` to `194.20.50.14` is the final example of the same rule seen at the POPs: **when a host moved into another provider's routed network, its address space changed too**.

---

## 11. Why this chapter belongs in “Build an ISP”

For Internet Force, the correct historical sequence is:

```text
choose carrier / upstream
        ↓
obtain public IPv4 space
        ↓
design public and private addressing
        ↓
configure WAN links and routing
        ↓
build POPs and dial-up pools
        ↓
activate DNS, mail, Web and authentication
        ↓
monitor and operate the network
```

The wind-down demonstrates the same principle in reverse: when part of the ISP left the previous carrier's network, it had to be **renumbered before it could truly become independent**.

---

## Repository evidence

Relevant material includes:

- `systems/cisco-2501-uplink/config/`
- `systems/pops/milano/`
- `systems/pops/pesaro/`
- `systems/pops/palermo/`
- `systems/pops/gorgonzola/`
- `systems/pops/gorgonzola/pointest/`
- `systems/pops/pesaro/post-internet-force/`
- `systems/infosfera-bergamo/`
- `systems/enter/`
- `systems/firewall/network/`
- `systems/data/`
- `systems/users/`
- `artifacts/tkined/`

See also:

- [Architecture](01-architecture.en.md)
- [A dial-up session](02-dialup-session.en.md)
- [Network growth 1995–1996](13-network-growth-1995-1996.en.md)
- [Routers and WAN](16-router-and-wan.en.md)
- [Wind-down and migrations](17-wind-down-and-migrations.en.md)
- [Putting a POP together](21-putting-the-pop-together.en.md)

---

## External references

- RFC 1519, *Classless Inter-Domain Routing (CIDR): an Address Assignment and Aggregation Strategy* (1993): https://www.rfc-editor.org/rfc/rfc1519
- RFC 1597, *Address Allocation for Private Internets* (1994): https://www.rfc-editor.org/rfc/rfc1597
- RFC 1631, *The IP Network Address Translator (NAT)* (1994): https://www.rfc-editor.org/rfc/rfc1631
- Italian Official Gazette, COMM 2000 S.p.A., notice concerning the change of company name to KPN Qwest Italia S.p.A., 20 September 2000: https://www.gazzettaufficiale.it/atto/parte_seconda/caricaDettaglioAtto/originario?atto.codiceRedazionale=M-7595&atto.dataPubblicazioneGazzetta=2000-09-20
- Key4biz, *KPNQwest Italia*, 10 September 2003: https://www.key4biz.it/Players-Documenti-2003-09-KPNQwest-Italia/72938/
- Messagenet, *About us*: https://messagenet.com/chisiamo/
