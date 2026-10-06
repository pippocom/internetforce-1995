@       IN      SOA     xacct.com. limor.xpert.com. (
                                1996070203      ; Serial
                                10800           ; Refresh 3 hours
                                3600            ; Retry 1 hour
                                604800          ; Expire after a week
                                86400 )         ; Minimum ttl 1 day
                   NS      dns.xpert.com.
                   NS      dns.xacct.com.
xacct.com.      MX  0  xpert.com.
        A  199.203.132.2
; *****************************************************************
; This file is auto-generated from a master file -- do not edit it,
; but arrange that the master is edited instead.
; *****************************************************************
www      A  199.203.132.2
dns      A  199.203.132.2
localhost      A  127.0.0.1
