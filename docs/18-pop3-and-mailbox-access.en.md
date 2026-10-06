[🇮🇹 Italiano](18-pop3-and-mailbox-access.md) · 🇬🇧 **English**

# POP3 and mailbox access

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

This chapter covers a concept distinct from
[mail transport](04-email.en.md): how the **customer** went to **read** mail that
had already been delivered.

- **SMTP / Sendmail** → message transport and delivery;
- **POP3 / IMAP** → customer access to their own mailbox.

## What problem this solves

A dial-up customer does not own a mail server: their mailbox lives on the central
server. A service is needed to hand them the accumulated messages, over the
dial-up connection, to the mail client of the time (Pine, Eudora, …).

## How Internet Force implemented it

The customer's mailbox lived on the **USERS** server (`206.20.95.4`). Because
Internet Force used a per-user access model, the maildrop was the customer's
`.mailbox` file in the home directory, not the system spool. Two protocols were
active, both started by `inetd`:

- **POP3** — the Berkeley `popper` server (version 1.6);
- **IMAP** — `/usr/local/etc/imapd`, to keep mail on the server and read it from
  several clients.

Because the mailbox was on the central server, mail was reachable from any POP: it
was bound to the account, not to a particular dial-up line.

## MUA, MTA and MDA: what actually happened to a message

Behind what users simply experienced as “email”, several distinct roles
already existed.

The **Mail User Agent (MUA)** was the program used to write and read
messages: Eudora, Pine, Elm, or another contemporary mail client. The
**Mail Transfer Agent (MTA)** accepted messages and routed them towards
other SMTP systems. Once a message reached its destination system, the
**Mail Delivery Agent (MDA)** function was responsible for local
delivery into the user's mailbox. MTA and MDA did not necessarily have
to correspond to separate programs or daemons: they describe different
roles in the path followed by a message.

Today it is also common to distinguish the **Message Submission Agent
(MSA)**, the service to which a user's client submits a newly written
message so that it can enter the mail system. In 1995–1996 this
separation had not yet been formally defined in the way it would be
later: message submission and SMTP transfer normally used the same
infrastructure and often the same Sendmail service on port 25. The
formal definition of the Message Submission Agent and port 587 would
only arrive in 1998.

The conceptual path was therefore:

**MUA → SMTP submission → MTA → SMTP network → destination MTA → MDA →
mailbox → POP3/IMAP → MUA**

At Internet Force, [Sendmail](04-email.en.md) played the central SMTP
transport role, while POP3 and IMAP allowed users to access messages
stored on the [USERS system](../systems/users/README.en.md).

## Sendmail and the Unix philosophy

Sendmail was not famous for having a simple configuration:
`sendmail.cf` could become remarkably complex. The model around it,
however, was extremely flexible and reflected the Unix philosophy well:
small components could be connected to one another.

The destination of an incoming message did not necessarily have to be
another mailbox. Aliases and users' `.forward` files could redirect a
message to another address, write it to a file, or send it directly
through a **pipe** to the standard input of a program.

An incoming email could therefore become the input of a script or local
application. Many functions that today might be described as workflows,
automations or integrations could be implemented simply by connecting
the mail system to a Unix program.

A particularly everyday example was the **out-of-office reply**. On
Unix systems of the period no groupware server was required to provide
one: the `vacation` command, used through a user's `.forward` file,
could process incoming messages and automatically respond with the text
stored in `.vacation.msg`. The program also kept track of senders to
which it had already replied, avoiding repeated automatic responses to
the same person.

Architecturally, this was an extremely simple mechanism: an individual
Unix user already had the tools needed to build a small piece of
automatic mail behaviour.

## Before email became a mass-marketing channel

The social role of email was different as well. In 1995–1996 email was
primarily a direct medium for personal, technical and professional
communication. Unsolicited commercial email already existed, but it had
not yet reached the scale, automation and importance that marketing and
spam would acquire in later years.

There was also a strong expectation in network culture that email
deserved a reasonably prompt response. A widely followed practical
rule, more a matter of netiquette than protocol, was to try to answer
within roughly **48 hours**; for an important message, sending an
immediate short acknowledgement and providing the full reply later was
also considered good practice.

Email was asynchronous, but it was not normally treated as a repository
in which messages could simply remain unanswered indefinitely.

## A sender was whoever the sender claimed to be

That culture of openness had another consequence: SMTP did not
intrinsically guarantee the identity of the sender.

A classic experiment for someone learning how the Internet worked was
simply to **Telnet to port 25 of an SMTP server**. After the `HELO`
greeting, one could continue the SMTP dialogue with an arbitrary
`MAIL FROM` and manually construct the message, including its `From:`
header. It was therefore perfectly possible, as an experiment or joke,
to send yourself a message that appeared to come from Bill Gates or
from almost any other chosen address.

There was no need to know that person's password or compromise their
account. The original SMTP protocol had been designed for a network
based far more on cooperation between systems than on cryptographic
verification of the identity claimed by a sender.

It is also important to distinguish two different layers. The
`MAIL FROM` command in the SMTP conversation belongs to the transport
**envelope**, while the `From:` field belongs to the message headers
seen by the recipient. Historically, both could be supplied without
SMTP itself providing proof of the identity of the person sending the
message.

The modern separation between authenticated message submission and
server-to-server transfer, together with mechanisms such as SPF, DKIM
and DMARC, would come much later. Email worked because the network had
first been designed to allow systems to communicate; as the Internet
grew, increasingly elaborate layers of authentication, reputation and
abuse control had to be built on top of that original model.

## Components and hosts

- **USERS** (`206.20.95.4`) — popper / imapd.
- The POP's access server (carrying the dial-up session).
- The customer's mail client.

## Representative evidence

The Pointest/Gorgonzola material preserves the POP3 service configuration
(`systems/pops/gorgonzola/pointest/Linux/popper/POPPER`), documenting how
popper was used in an Internet Force POP made autonomous by Marco after Internet Force's closure.

→ Complete configuration/evidence:
[`systems/pops/gorgonzola/pointest/Linux/popper/POPPER`](../systems/pops/gorgonzola/pointest/Linux/popper/POPPER)

## How it connects to the rest of the POP

It depends on [mail](04-email.en.md) for delivery and on
[authentication](10-authentication-tacacs.en.md) to identify the session user. The
service runs on USERS, one of the [central servers](01-architecture.en.md).

## Related original material

- [`docs/04-email.en.md`](04-email.en.md) — SMTP transport and delivery.
- [`systems/users/README.en.md`](../systems/users/README.en.md) — the USERS server.

---

← [Build a POP](00-build-an-isp.en.md) ·
Previous: [Mail (Sendmail)](04-email.en.md) ·
Next: [Web server](05-web-news-ftp.en.md) →
