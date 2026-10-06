@       IN      SOA     xpert.com. limor.xpert.com. (
                                1996091601      ; Serial
                                10800           ; Refresh 3 hours
                                3600            ; Retry 1 hour
                                604800          ; Expire after a week
                                86400 )         ; Minimum ttl 1 day
		   NS	   dns.xpert.com.
		   NS	   dns.netvision.net.il.
		   NS	   nypop.elron.net.
xpert.com.      MX  10  mailhost.xpert.com.
        MX  20  mail.netvision.net.il.
        MX  30  nypop.elron.net.
        A  199.203.132.1
; *****************************************************************
; This file is auto-generated from a master file -- do not edit it,
; but arrange that the master is edited instead.
; *****************************************************************
localhost      A  127.0.0.1
ftp     CNAME  xpert.com.
www     CNAME  xpert.com.
gopher     CNAME  xpert.com.
news     CNAME  xpert.com.
mailhost      A  199.203.132.1
dns      A  199.203.132.8
pcLimor      A  199.203.132.3
pcShiri      A  199.203.132.4
server      A  199.203.132.5
pcEran      A  199.203.132.6
xterm1      A  199.203.132.10
pcElla      A  199.203.132.14
pcYarden      A  199.203.132.15
pcAnatoly      A  199.203.132.16
kalimero      A  199.203.132.254
kalimero-cisco      A  199.203.99.233
xpert2501      A  199.203.99.234
test      NS  dimka.test.xpert.com.
dimka.test      A  199.203.132.50
