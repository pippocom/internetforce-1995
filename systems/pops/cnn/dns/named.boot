 	;
;    File:       named.boot
;    Purpose:    give the DNS its startup parameters and
;                list of startup files.
;
;    XFRNETS parameter limits the transfer of zone information
;    to machines matching the subnet wildcard/mask entries listed
;
XFRNETS 
;
;    establish a loopback entry for this machine, and tell
;    it to load its identity from named.127.0.0
;
primary 0.0.127.IN-ADDR.ARPA named.127.0.0
;
;    set ourselves as primary server for the zone
;
primary cnn.it named.zoneinfo
;
;    provide reverse address-to-host mapping
;    You need to substitute your subnet address
;    for the strings 'ccc', 'bbb', 'aaa'.
;
primary 228.20.206.in-addr.arpa named.206.20.228
;
;    prime the DNS with root server 'hint' information
;
cache . named.cache
;
