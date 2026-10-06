@  IN	SOA	dns.intf.com. dnsmaster.internetforce.com. (
		1996082901	 ; Serial
		10800		 ; Refresh 3 hours
		3600		 ; Retry 1 hour
		604800		 ; Expire after a week
		86400 )	 ; Minimum ttl 1 day
				NS	styx.ios.com.
				NS	noc.ios.com.
				NS	harley.ios.com.
				NS	dns.internetforce.com.
				NS	dns2.internetforce.com.
; *****************************************************************
; This file is auto-generated from a master file -- do not edit it,
; but arrange that the master is edited instead.
; *****************************************************************
localhost      A  127.0.0.1
data      A  206.20.95.3
users      A  206.20.95.4
shell      A  206.20.95.5
fw-data      A  206.20.95.10
fw-users      A  206.20.95.11
fw-shell      A  206.20.95.12
firewall      A  206.20.95.129
dvlp      A  206.20.95.130
anna      A  206.20.95.131
franz      A  206.20.95.132
maxi      A  206.20.95.133
html      A  206.20.95.134
aps      A  206.20.95.135
cust2      A  206.20.95.136
marco      A  206.20.95.140
mailhost     CNAME  users.intf.com.
mail     CNAME  users.intf.com.
loghost     CNAME  data.intf.com.
ftp     CNAME  data.intf.com.
www     CNAME  users.intf.com.
news     CNAME  news.ios.com.
www1     CNAME  data.intf.com.
dns      A  206.20.95.3
dns2      A  206.20.95.4
intf.com.      MX  0  users.internetforce.com.
        MX  1  data.internetforce.com.
        A  206.20.95.4
