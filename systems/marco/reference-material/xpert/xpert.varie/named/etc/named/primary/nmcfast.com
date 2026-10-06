@       IN      SOA     nmcfast.com. limor.xpert.com. (
                                1996082002      ; Serial
                                10800           ; Refresh 3 hours
                                3600            ; Retry 1 hour
                                604800          ; Expire after a week
                                86400 )         ; Minimum ttl 1 day
                   NS      dns.xpert.com.
                   NS      mailhost.xpert.com.
nmcfast.com.      MX  0  mailhost.xpert.com.
; *****************************************************************
; This file is auto-generated from a master file -- do not edit it,
; but arrange that the master is edited instead.
; *****************************************************************
localhost      A  127.0.0.1
