@       IN      SOA     topmusic.com. yahel.xpert.com. (
                                1996070203      ; Serial
                                10800           ; Refresh 3 hours
                                3600            ; Retry 1 hour
                                604800          ; Expire after a week
                                86400 )         ; Minimum ttl 1 day
                   NS      mailhost.xpert.com.
                   NS      dns.telhai.ac.il.
topmusic.com.      MX  0  mailhost.xpert.com.
        A  199.203.132.7
        HINFO  "p.o.box 1240, Tivon 36000, ISRAEL"
        TXT  "life is virtual"
; *****************************************************************
; This file is auto-generated from a master file -- do not edit it,
; but arrange that the master is edited instead.
; *****************************************************************
localhost      A  127.0.0.1
www     CNAME  topmusic.com.
