;
;    boot file for name server - System setup by M. Iannacone
;

directory /etc/named

cache      .						root_nameservers
primary    0.0.127.in-addr.arpa				localhost-rev

primary    infosfera.it					infosfera.it
primary    140.235.194.in-addr.arpa			db.194.235.140

