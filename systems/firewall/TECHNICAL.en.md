[🇮🇹 Italiano](TECHNICAL.md) · 🇬🇧 **English**

# Check Point FireWall-1 2.0a --- technical guide

> **Internet Force 1995--1996 Historical Archive**\
> Historical reconstruction and technical documentation based on
> original Internet Force materials preserved by **Marco Iannacone**.\
> Author and archive curator: **Marco Iannacone** · https://pippo.com

Internet Force ran **Check Point FireWall-1 2.0a** on a Sun SPARCstation
5 with SunOS 4.1.4.

Recovered interfaces:

``` text
le0  206.20.95.129/25   office
qe0  206.20.95.10       fw-data
qe1  206.20.95.11       fw-users
qe2  206.20.95.12       fw-shell
qe3  10.0.0.1/8         fw-world
```

On the recovered `rc.route` the five interfaces appear in this order:

``` text
ifconfig le0 netmask 255.255.255.128

ifconfig qe3 fw-world netmask 255.0.0.0

ifconfig qe0 fw-data netmask 255.255.255.192

ifconfig qe1 fw-users netmask 255.255.255.192

ifconfig qe2 fw-shell netmask 255.255.255.192
```

### Host-specific routing

On the DATA segment the recovered file replaces the connected network
route with host-specific routes toward `fw-data`:

``` text
route delete intfnet fw-data
route add host data fw-data 0
route add host 206.20.95.20 fw-data 0
route add host 206.20.95.29 fw-data 0
route add host 206.20.95.32 fw-data 0
route add host 206.20.95.33 fw-data 0
```

Instead of leaving the whole segment reachable through that interface,
these routes made only specific hosts reachable along a determined path.

The original `FW-policy.gif` preserves the 15-rule policy. Significant
paths include TACACS from terminal servers to USERS, customer/office
access to selected server services, administrative access from
DVLP/Marco, the external news feed, bidirectional X11 between the
`dvlp, marco` source/destination sets, and a final
`Any → Any → Any STOP` rule.

The 15 rules, with source, destination, service and action:

| # | Source | Destination | Services | Action |
|---|---|---|---|---|
| 1 | Any | Any | domain, ident | accept |
| 2 | Any | servers | icmp echo-reply/request, http, smtp | accept |
| 3 | intf.com | intf.com | Any | accept |
| 4 | intf.com | servers | ftp, nntp | accept |
| 5 | clients | intf.com | Any | accept |
| 6 | clients, officenet | servers | ftp, nntp, pop-2, pop-3 | accept |
| 7 | ts | users | tacacs | accept |
| 8 | ts | Shell | telnet | accept |
| 9 | Shell | users | NFS | accept |
| 10 | dvlp, marco | servers | telnet | accept |
| 11 | dvlp | firewall | telnet, FW1, FW1_log | accept |
| 12 | news.ios.com | data | nntp | accept |
| 13 | xpert.com | dvlp, marco | talk, deslogin | accept |
| 14 | dvlp, marco | marco, dvlp | X11 | accept |
| 15 | Any | Any | Any | STOP |

The historical policy screenshot is preserved in
[`checkpoint/FW-policy.gif`](checkpoint/FW-policy.gif).

Ordinary subscriber Internet traffic did **not** traverse FireWall-1; it
remained on the world/backbone path. The firewall protected central
services and the office network.

The recovered `rc.local` starts FireWall-1 with the following block:

``` text
# FW-1 Start
if [ -f /etc/fw/bin/fwstart ]; then
	FWDIR=/etc/fw
	export FWDIR
	/etc/fw/bin/fwstart
fi
# FW-1 END
```

The script exports `FWDIR=/etc/fw` and runs `fwstart`. The recovered
`rc.local` does not contain an explicit compiled-or-loaded policy path:
the startup line is the one above.

## Continue exploring

-   [Security: services and hardening](../../docs/06-security.en.md)
-   [The dial-up session](../../docs/02-dialup-session.en.md)
-   [DNS](../../docs/03-dns.en.md)
