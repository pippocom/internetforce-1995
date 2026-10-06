[🇮🇹 Italiano](10-authentication-tacacs.md) · 🇬🇧 **English**

# Authentication (XTACACS)

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

Every dial-up customer, at every POP, was authenticated by one central
service on USERS rather than by local accounts on each access server. This
is what made distributed dial-up practical: a customer account worked at
any POP, and adding a POP did not mean copying users or passwords around.

## The daemon

USERS ran **XTACACS**, an extended TACACS implementation. The daemon
(`xtacacsd`, revision 3.4, built in 1995) was started at boot:

```
/etc/xtacacsd -ls
```

The core TACACS service was UDP port 49. The `-l` and `-s` options enabled
extra logging and accounting support. The daemon validated usernames and
passwords against the account database on USERS and decided, per user and
per host, whether a session was permitted.

The configuration file defined global policy and per-group rules - for
example a default password policy, whether blank passwords were allowed,
whether a name-server check was required, and rules such as "user may log in
from any host" or "this group may log in from these devices". This gave the
administrator a single place to express access policy for the whole modem
fleet.

## The access-server side

Every Cisco access server was configured identically with respect to
authentication. The relevant lines were:

```
tacacs-server host 206.20.95.4
tacacs-server extended
tacacs-server authenticate connections
tacacs-server authenticate slip always
tacacs-server notify connections
tacacs-server notify enable
tacacs-server notify logout
tacacs-server notify slip
```

Read as a whole, these settings told the access server to:

- use the XTACACS server at USERS (`206.20.95.4`) with the extended protocol;
- require authentication for incoming connections and for SLIP;
- notify the server of connection start, enables, logouts and SLIP sessions,
  which produced the accounting trail.

The dial-up lines themselves were marked `login tacacs`, so a caller was
authenticated before the line handed over a session.

## Accounting

XTACACS did more than yes/no authentication. It maintained per-Cisco login
records so that the standard UNIX `last` command could produce connection
reports, and a dedicated dial-up accounting helper (`xacctd_user`) ran on
USERS alongside the daemon. Combined with the `notify` settings above, this
gave a per-session record of who connected, when, and from which access
server - the basis for customer accounting and for capacity planning on the
modem banks.

## Relationship to the rest of the system

- **Provisioning:** a new customer account created by the provisioning tools
  on USERS was immediately usable at every POP. See
  [Customer provisioning](12-customer-provisioning.en.md).
- **Firewall:** rule 7 of the FireWall-1 policy (`ts -> users : tacacs`)
  allowed the access servers to reach USERS for authentication.
- **Dial-up flow:** authentication is step 4 of
  [the dial-up session](02-dialup-session.en.md).

Later, as the service grew in 1996, the newer POPs followed the same model;
the CNN POP was the exception that proves the rule - it initially pointed at
a local authentication address before the centralised design was restored.

---

See also: [USERS server](../systems/users/README.en.md) ·
[The dial-up session](02-dialup-session.en.md)

---

→ [Build an Internet Force POP, step by step](00-build-an-isp.en.md)
