@  IN	SOA	canalemoda.com dnsmaster.internetforce.com. (
		1996050201	 ; Serial
		10800		 ; Refresh 3 hours
		3600		 ; Retry 1 hour
		604800		 ; Expire after a week
		86400 )	 ; Minimum ttl 1 day
				NS	harley.ios.com.
				NS	dns.internetforce.com.
				NS	dns2.internetforce.com.
sicily.com.      MX  0  internetforce.com.
; *****************************************************************
; This file is auto-generated from a master file -- do not edit it,
; but arrange that the master is edited instead.
; *****************************************************************
www      A  206.20.95.21
localhost      A  127.0.0.1
