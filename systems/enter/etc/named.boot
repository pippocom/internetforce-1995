;
;    boot file for name server
;

;
; Place where DNS files resides
;
;directory		/etc/named.data

;
; Sept 26 1996. This DNS is primary for:
;
primary		enter.it		/etc/named.data/enter.data
primary		algobit.it		/etc/named.data/algobit.data
primary		bitspcs.com		/etc/named.data/bitspcs.data
primary		racdyn.it		/etc/named.data/racdyn.data
primary		ant.it			/etc/named.data/ant.data
primary		anthares.it		/etc/named.data/anthares.data
primary		eurocrea.it		/etc/named.data/eurocrea.data
;primary		netstore.it		/etc/named.data/netstore.data
primary		txt.it			/etc/named.data/txt.data
primary		cmc.milano.it		/etc/named.data/cmc.data
primary		cmc.mi.it		/etc/named.data/cmc-mi.data
primary		hyperphar.it		/etc/named.data/hyperphar.data
primary		internetforce.com	/etc/named.data/iforce.data
primary		intf.com		/etc/named.data/intf.data

;
; Here the back-conversions
;
primary		0.0.127.in-addr.arpa		/etc/named.data/127.addr
primary		50.20.194.in-addr.arpa		/etc/named.data/194.20.50.addr
primary		74.185.194.in-addr.arpa		/etc/named.data/194.185.74.addr
primary		100.185.194.in-addr.arpa	/etc/named.data/194.185.100.addr
primary		206.20.95.in-addr.arpa		/etc/named.data/206.20.95.addr

;
; Here the secondary
;
secondary	inet.it		194.20.8.4 194.20.8.1	/etc/named.data/inet.it

;
; The root cache
;
cache		.	/etc/named.data/db.root
