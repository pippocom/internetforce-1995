[🇮🇹 Italiano](25-xpert-ip-accounting-xacct.md) · 🇬🇧 **English**

# From Xpert to XACCT: IP accounting inside Internet Force

> **Internet Force 1995–1996 Historical Archive**  
> Author and curator: Marco Iannacone · https://pippo.com  
> License: [CC BY 4.0](../LICENSE)

In 1995 Internet Force already had in production a technology that tried to answer a question very different from the simple *“is the user connected?”*: **who is using the network, which resources or services are they using, and how much are they using them?**

In practical terms, this was the meaning of **IP accounting**.

The Xpert software installed at Internet Force was not an ordinary traffic monitor, and it was not merely dial-up session accounting either. It was meant to collect and attribute IP-network use, turning traffic into data associated with users, sessions and services. That data could be used for analysis and control, but above all it made technically possible something far from normal at the time: **making the price depend not only on access to the Internet, but on the actual use of the network and its services**.
But to understand better, let us step back a moment to those times.

In the mid-1990s the product sold by ISPs was normally access: a subscription, often flat from the point of view of the Internet provider, possibly combined with the telephone charges of the dial-up call. The network knew who had authenticated and for how long, but it was not normal to build Internet pricing on the detail of what the user had consumed at the IP level.

Xpert was working on exactly that transition.

**The version of the technology installed at Internet Force was one of the early prototype versions of what shortly afterwards became XACCT.** It did not yet have the product and company name that would be born in 1997. It was still Xpert software, used in a real operating environment, but the problem it addressed, the data-collection model and the commercial vision were already those that would lead to XACCT Technologies.

The package that survived in the backups and is kept today in the repository is:

- [`artifacts/tools/addr_stats.shar`](../artifacts/tools/addr_stats.shar), an Xpert shell archive (`Wrapped by xpert.com`, 1996) with declared contents `Xpert IP accounting`;
- [`artifacts/scripts/IP_ADDRESS_NOTI_DEBUG.txt`](../artifacts/scripts/IP_ADDRESS_NOTI_DEBUG.txt) is also preserved, operational material connected with the work on addresses and tracking.

**The heart of the solution, however, was not `addr_stats` alone. The principal element was a module installed in the firewall kernel.** That module observed IP traffic at the point where it crossed the firewall and made it possible to distinguish its nature, for example HTTP, SMTP, FTP and other traffic types. The module has unfortunately not survived in the backups.

Cisco and XTACACS supplied the other half of the problem: they helped establish **who** the user was and **how** that session was routed. The firewall module made it possible to understand **what** was passing; the access server, authentication, assigned addresses and routing made it possible to relate that traffic back to the session and the user.

In simplified form, the architecture was therefore:

```text
Cisco 2511 / PPP
    -> session and assigned IP address
             |
             v
XTACACS
    -> user identity and access data
             |
             v
Cisco routing
    -> session context and path
             |
             v
firewall + Xpert kernel module
    -> traffic observation and classification
       HTTP / SMTP / FTP / ...
             |
             v
accounting software
    -> IP usage attribution
```

It was therefore not a system that merely read logs after the event. **The primary collection happened in the firewall, at kernel level, directly on traffic in transit.**

The name `addr_stats` is, with hindsight, almost more interesting than a commercial label: it captures the software **before** that technological line became a standalone product called XACCT.

Internet Force used that capability for IP-usage tracking. **It never used it to bill customers according to traffic or services consumed.** The next step was taken elsewhere, in particular in the Xpert project in Morocco that would play a decisive role in the birth of XACCT.

---

## 1. What IP accounting meant

In a traditional dial-up network it was relatively easy to know that a customer had connected.

The Cisco access server received the call, TACACS authenticated the user, and accounting could record events such as login, logout and session duration.

This information answered questions such as:

```text
who connected?
when?
for how long?
from which access server?
```

IP accounting addressed a different problem.

Once authenticated, a user could generate traffic towards many destinations and use different services. To make that use economically meaningful, data had to be collected from the network, attributed correctly, and turned into records usable by analysis and, potentially, billing systems.

The questions therefore became:

```text
which user or session generated this traffic?
how much traffic did it produce?
towards which resources?
using which services?
how can I turn these events into usage records?
```

That is a substantial difference.

**SNMP/tkined** was used to know whether the network was working and how heavily devices and links were used.

**XTACACS** was used to authenticate and record access.

**Xpert's IP accounting software** instead tried to attribute the actual use of the IP network.

These are three different levels:

```text
operational monitoring
    network and devices

access accounting
    users and sessions

IP usage accounting
    network and service use
```

The third level was the one needed to reach usage-based billing.

---

## 2. Why it was an innovative idea in 1995

Today we are used to systems that measure every digital event: API calls, bytes transferred, CPU minutes, storage, messages, transactions, content and features used.

In 1995 the ISP world was much simpler.

The commercial product was mainly **Internet access**. The customer bought the ability to connect to the network; the provider had to authenticate them, route traffic and provide the basic services. The economic granularity was normally the subscription or, in some models, connection time. The telephone charges of the dial-up call were another level still.

Xpert's idea was to move the observation point deeper:

**not merely selling the right to enter the Internet, but being able to measure what happened once inside.**

This opened completely different scenarios. An operator could distinguish users, organisations, volumes and services and build pricing models based on actual use.

Limor Schweitzer presented this capability to the Internet Force shareholders as **strategic and strongly innovative**. His prediction was that the market would move in that direction and that Internet Force, already having a technology other ISPs did not have, could gain an enormous competitive advantage.

The shareholders appreciated the solution and decided to install it.

The technology did reach the infrastructure. The commercial model did not.

Internet Force continued to sell its services without billing measured IP traffic.

---

## 3. The surviving software and the firewall kernel module

A particularly interesting part of the archive is that not only the memory of the system has remained.

The complete architecture was made up of several elements. **The principal component was an Xpert module loaded into the firewall kernel**, which observed traffic as it crossed the system and made possible its classification by service type, distinguishing for example HTTP, SMTP and FTP. The kernel module has not survived in the recovered backups.

This placement was fundamental: the firewall was the point at which traffic between users, internal services and the Internet could be observed in transit. The Xpert module therefore turned the firewall also into a collection point for the events needed by the IP accounting.

Cisco and XTACACS completed the correlation. The Cisco 2511 managed the PPP session and the assigned IP address; XTACACS identified the user and recorded access; routing provided the network context. Combining this information with the events collected by the firewall module made it possible to associate the observed traffic type with the session and therefore with the user.

This was the technologically important step: **not merely counting packets or bytes on an interface, but recognising the traffic and attributing it to whoever was generating it**.

The kernel component has been lost, while a user-space part of the solution has survived.

The repository keeps the historical package [`artifacts/tools/addr_stats.shar`](../artifacts/tools/addr_stats.shar).

It is a *shell archive*, a format very common in the Unix ecosystem of the time: an executable file that, once run, recreated the content of the package. The preserved package declares itself `Wrapped by xpert.com` in November 1996, and its content is indicated as `Xpert IP accounting`.

The name `addr_stats` makes the purpose of the package explicit: producing statistics based on addresses, that is turning IP events and traffic into attributable and analysable information.

The repository also keeps [`artifacts/scripts/IP_ADDRESS_NOTI_DEBUG.txt`](../artifacts/scripts/IP_ADDRESS_NOTI_DEBUG.txt), part of the operational material concerning addressing and debugging of the mechanism.

These files should not be read as if they were the final version of XACCT found again thirty years later. That would be historically wrong for the opposite reason.

**They are a prototype version that predates XACCT, belonging to the Xpert software line from which XACCT would be born.**

XACCT Technologies did not yet exist. The brand, the commercial architecture and the carrier-grade product would come later. But the underlying function was already present: collecting data on IP usage and making it usable beyond simple network monitoring.

This is precisely what makes the package important in the Internet Force archive.

---

## 4. Xpert and Internet Force: much more than a supplier

Xpert Integrated Systems was founded in 1993 by **Limor Schweitzer and Eran Wagner**. Very early in its history, Xpert acquired the company that **Yahel Ben-David** had founded in Haifa; Yahel thus joined the core of the group and is indeed described in later biographies as a *co-founder of the Xpert Group*.

**Yossi Gottlieb** was the very young engineer of the group, already considered a phenomenon from a technical point of view.

Marco Iannacone worked directly with **Limor Schweitzer, Eran Wagner, Yahel Ben-David and Yossi Gottlieb**, all involved at different levels in the construction of Internet Force as external consultancy.

It was therefore not the classic relationship in which a customer bought a box, received a manual and opened a ticket.

Internet Force had direct access to the group that designed and experimented with those technologies.

Limor also spoke Italian: he had lived in Rome for the first six years of his life. When he was in Milan he could therefore speak directly also with the Internet Force shareholders, which was particularly useful because not everyone mastered English to the same level.

Limor also personally knew one of the founders of **Check Point**, the company that produced FireWall-1, used by Internet Force. It is plausible that this relationship facilitated the development or integration of the Xpert kernel module on the firewall; however, not enough technical material has survived to reconstruct exactly that passage.

The personal relationships continued for years well beyond Internet Force. **Limor Schweitzer and Yahel Ben-David remain personal friends of Marco Iannacone today.**

This direct relationship is part of the explanation of how a small Italian ISP of 1995 came to use technologies so close to the development frontier of the time.

---

## 5. A technology installed, but an advantage never commercialised

The IP accounting solution was appreciated by the shareholders and installed.

Internet Force could therefore track IP usage, but did not take the last step: **it did not link that data to customer billing**.

This point must be kept very sharp because it makes the story more interesting, not less.

Internet Force possessed a capability that could have supported a commercial model different from the simple access subscription, and Limor had explicitly presented its competitive potential. However that potential was not turned into a commercial product during the company's brief life.

There is no need to invent a single cause today. It may be that the value of the solution was not fully understood, that commercial priorities lay elsewhere, or simply that Internet Force did not have the necessary time.

The important fact is what happened:

```text
technology available         yes
IP usage tracking            yes
use in production            yes
customer billing on usage    no
```

---

## 6. Morocco: the same concept taken all the way to billing

In the same period Xpert worked on a project to connect a university in Morocco to the Internet.

Limor spoke about it directly to Marco while that technological line was still evolving.

The fundamental difference from Internet Force was that **in the Moroccan project the accounting was taken all the way to billing**.

The university did not merely want to know whether students were connected. The system made it possible to know how network resources were used and to attribute that use economically to the different departments.

It was the complete passage:

```text
collection of IP events
        ↓
usage attribution
        ↓
accounting records
        ↓
rating
        ↓
billing
```

This is why later press identifies the Moroccan project as the moment in which XACCT was conceptually born.

*Globes* summarised it years later particularly effectively: **“XACCT was born in Morocco, at least conceptually.”**

Internet Force and Morocco therefore represent two very close points of the same trajectory.

At Internet Force a prototype version of the technology was already operational for IP accounting, but was not used commercially for billing.

In Morocco the same concept was taken all the way to its economic consequence.

---

## 7. XACCT: the prototype becomes a product and then a market

In May 1997 Limor Schweitzer and Eran Wagner founded **XACCT Technologies**.

XACCT turned the development line begun at Xpert into a general-purpose platform for **network usage accounting, mediation and billing**.

The problem addressed was by then explicit: collecting information from routers, switches, authentication servers, applications and other sources; normalising and correlating it; producing records capable of saying who had used which service, how much and in what way; then delivering those records to rating, billing and analysis systems.

It was the IP equivalent of the usage details that the telephone world had long since learned to turn into billing, applied however to a much more heterogeneous network and to services that could not be described simply as a call begun and ended.

Growth was very rapid.

In 1999 XACCT raised 22 million dollars at a post-money valuation of 110 million. *Globes* reported agreements with about 80% of the world's billing-software vendors and cited the technology as **“a de facto standard for pricing on the Internet”**.

In 2001 the N2B platform was presented as a real-time bidirectional link between IP infrastructure and OSS/BSS applications, with a database able to support even future **content billing**.

What Limor had described to the Internet Force shareholders in 1995 was therefore not a particularly fanciful commercial pitch.

It was a very early description of where the market was going.

---

## 8. XACCT enters Amdocs

At the end of 2003 Amdocs announced the acquisition of XACCT Technologies.

The announced value was about **29.5 million dollars**. The transaction completed in February 2004 led to a purchase price accounted at about **29.175 million dollars**, which is why the press of the time normally spoke of an acquisition of about **30 million dollars**.

The most significant part, however, is not the price.

Amdocs explained that the acquisition of XACCT extended its billing capabilities in **network mediation**, enabling the collection, formatting and distribution of network usage events and creating an end-to-end chain from mediation to billing for **voice, data, content and commerce** transactions, prepaid and postpaid.

The complete sequence thus becomes particularly readable:

```text
Xpert
    first IP usage accounting technologies
        ↓
Internet Force, 1995-1996
    a prototype version is used in production
    tracking yes, commercial billing no
        ↓
Xpert project in Morocco
    accounting taken all the way to billing
        ↓
XACCT, 1997
    mediation + usage accounting + billing
        ↓
Amdocs, 2004
    end-to-end integration in a global
    telecom billing platform
```

---

## 9. The people behind the software

The technology did not arrive at Internet Force by chance.

Limor Schweitzer was the main interlocutor on the strategic vision of IP accounting.

Eran Wagner was part of Xpert's founding core, was more the Finance, Strategy and Marketing man and would later found XACCT with Limor.

Yahel Ben-David came from the Haifa technical core integrated very early into Xpert and contributed, at different levels, to the work on the Internet Force infrastructure.

Yossi Gottlieb was the youngest and already had an almost mythological reputation for technical ability.

The group even went so far as to joke with the Internet Force shareholders that Yossi was so good that he could **recognise binary files by listening to them through a loudspeaker**.

Marco played along.

Naturally it was a joke. But the fact that it seemed plausible enough to be told says a great deal about the reputation Yossi had earned in the group.

---

## 10. Internet Force as an operating environment for technologies that were being born

The Xpert IP accounting was not an isolated case.

Inside Internet Force coexisted:

- Check Point FireWall-1 and Stateful Inspection;
- virtual IPs and virtual hosting;
- PHP/FI during the early phase of the dynamic Web;
- SNMP and tkined for network monitoring;
- XTACACS for authentication and access accounting;
- the Xpert IP usage accounting prototype that would lead to XACCT;
- a Unix and networking architecture built by working directly with people who were developing technologies destined to become products and markets of their own.

Internet Force was not a research laboratory. It was a real ISP, with real customers and production systems.

And this is precisely what makes the case interesting.

**Emerging technologies were not merely tried: they were used to make a commercial provider work.**

The `addr_stats` package is perhaps the most surprising example because it makes it possible to follow the same idea from the Xpert software preserved in the archive, to XACCT, through to network mediation and billing on an international scale inside Amdocs.

---

## Material preserved in the repository

- [`artifacts/tools/addr_stats.shar`](../artifacts/tools/addr_stats.shar) — historical Xpert IP accounting package (`Wrapped by xpert.com`, 1996; declared contents `Xpert IP accounting`).
- [`artifacts/scripts/IP_ADDRESS_NOTI_DEBUG.txt`](../artifacts/scripts/IP_ADDRESS_NOTI_DEBUG.txt) — operational material concerning addressing/debugging.
- [`systems/marco/reference-material/xpert/`](../systems/marco/reference-material/xpert/) — Xpert technical material preserved among the reference files of Marco's workstation.
- In the Xpert corpus, DNS files relating to `xacct.com` also survive, later than the Internet Force phase and useful to document the continuity of the preserved material.

---

## References

- *Globes*, **Xpert: Profiting from a gold rush**: https://en.globes.co.il/en/article-485000
- *Globes*, **Infrastructure product for network service providers**: https://en.globes.co.il/en/article-381562
- *Globes*, **Finally, Amdocs buys XACCT**: https://en.globes.co.il/en/article-753364
- Amdocs, SEC filing on the planned XACCT acquisition, approximately $29.5 million: https://investors.amdocs.com/static-files/5b402036-1ace-4ca3-8884-6909b2d4f804
- Amdocs, SEC filing on the completed acquisition and $29.175 million purchase-price allocation: https://investors.amdocs.com/static-files/e0a85bf4-af43-4ce1-ab4b-53a934de81f0

---

See also:

- [Monitoring](08-monitoring.en.md)
- [Historical notes](09-historical-notes.en.md)
- [Authentication and XTACACS](10-authentication-tacacs.en.md)
- [Software inventory](11-software-inventory.en.md)
- [Customer provisioning](12-customer-provisioning.en.md)
- [People and workflows](15-people-and-workflows.en.md)
