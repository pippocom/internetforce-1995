[🇮🇹 Italiano](12-customer-provisioning.md) · 🇬🇧 **English**

# Customer provisioning

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

Adding a customer was a small process governed by a script. The tools lived on USERS,
where the customer accounts, home directories and mailboxes all belonged.

## Creating an account

A shell script (`adduser`) created the account and its environment. It took a
login name, a full name and an encrypted password, and then:

1. **Allocated a UID** — the next free number from 500 upward, in group 100.
2. **Created the home directory** under `/users/01/<login>/home`, owned by
   the new UID.
3. **Built a restricted environment** — a "jail" root at
   `/users/01/<login>` containing a minimal `etc/`, `bin/` and skeleton
   files copied from a shared template, plus a Pine configuration
   (`.pinerc`) in the home directory.
4. **Created a jailed password file** inside the account's jail, separate
   from the system `/etc/passwd`, so that programs running inside the
   restricted environment saw a consistent login entry.
5. **Appended the real account** to `/etc/passwd` with the customer's home
   directory and restricted shell.
6. **Applied a quota** by copying a quota template (`edquota -p`).

The customer's default shell was the restricted **`/bin/lynx`** shell, not a
general-purpose shell. This gave dial-up customers a controlled environment
in which they could read mail, use Lynx and access their files, without an
interactive system shell. Service and internal accounts used other
restricted shells (for example `/bin/nosh`).

## Home directory and web space

Each home directory held the customer's files, their `.mailbox` (the POP/IMAP
maildrop) and, when they used web space, a `public_html` directory served by
the web server as personal pages. This is the same `UserDir public_html`
mechanism documented on the [Web, FTP, news and mailing lists](05-web-news-ftp.en.md)
page.

## Quotas

Disk quotas were enforced on the two customer filesystems on USERS
(`/usr/export/sd1c` and `/usr/export/sd2c`).
[`quota.txt`](../systems/users/system/quota.txt) records the standard and
larger quota profiles (block and inode soft/hard limits) that were assigned to
accounts, and the routine use of `quotacheck`. Quotas were an availability
safeguard: without them a customer could exhaust a shared filesystem through
uploads or home-directory growth.

## Dial-up identity

A customer's dial-up session was authenticated centrally by XTACACS (see
[Authentication](10-authentication-tacacs.en.md)) and received an address from
the POP's dial-up pool. Because the account lived on USERS, the same login
worked from every POP.

## Mailing lists and content

Customer-facing mailing lists were managed with Majordomo on DATA, with
subscription approval handled by mail. Web content was staged on DVLP and
released to USERS (personal pages) or DATA (virtual customer sites).

## The customer Welcome Kit

New customers received a **Welcome Kit**: a printed user manual and a set of
installation floppies containing Trumpet Winsock, the Internet Force customer
program **Easy!** and the client programs for the main Internet services.
Easy!, written by Marco Iannacone, gave customers a simple launcher/interface
for the bundled Internet applications. The manual and the original disk images
are published in
[`artifacts/customer-welcome-kit/`](../artifacts/customer-welcome-kit/README.en.md).
This was the customer's side of the provisioning process, complementing the
account created on USERS and the dial-up numbers published by each POP.

## Representative configuration

From the recovered `adduser` script (`artifacts/scripts/adduser`), which creates
the account and the home inside the jail:

```sh
USERUID=500            # first uid for users
MAXUID=32767
USERBASE=/users/01     # users directories base
USERSHELL=/bin/lynx    # users default shell
SHARE_DIR=/usr/export/sd1c/shared
```

UIDs start at 500, the default shell is `lynx` (content access, not an
interactive shell) and the home lives under `/users/01`; the quota is then applied
with `edquota`.

→ Complete script: [`artifacts/scripts/adduser`](../artifacts/scripts/adduser) ·
quotas: [`systems/users/system/quota.txt`](../systems/users/system/quota.txt)

---

See also: [The dial-up session](02-dialup-session.en.md) ·
[USERS server](../systems/users/README.en.md) ·
[Email](04-email.en.md)

---

→ [Build an Internet Force POP, step by step](00-build-an-isp.en.md)
