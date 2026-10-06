;
;	PRIMARY DNS configuration
;	Copyright (C) 1995, Xpert Unix Systems.
;	
directory /usr/local/etc/named/named-data

; type	  domain			source host/file	backup file
cache	  .				root.cache
primary   internetforce.com  			primary/internetforce.com
primary   intf.com       			primary/intf.com
primary   pippo.com                 primary/pippo.com
primary	  internetforce.it 			primary/internetforce.it
primary   canalemoda.com			primary/canalemoda.com
primary   sicilia.com				primary/sicilia.com
primary   pesaro.com                primary/pesaro.com
primary   art-diary.com				primary/art-diary.com
primary   creo-mi.com               primary/creo-mi.com
primary   boldyoung.com             primary/boldyoung.com
primary   loveisland.com            primary/loveisland.com
primary   shiseidoit.com            primary/shiseidoit.com
primary   pcpesaro.com				primary/pcpesaro.com
primary   calabria.com              primary/calabria.com
primary   glassonline.com			primary/glassonline.com
primary   tecnos.com				primary/tecnos.com
primary   nassetti.com				primary/nassetti.com
primary   financialreports.com      primary/financialreports.com
primary   net-pool.com              primary/net-pool.com
primary	  promotion.it				primary/promotion.it
primary   tera-it.com				primary/tera-it.com
secondary cnn.it			206.20.228.70 secondary/cnn.it
secondary 228.20.206.IN-ADDR.ARPA       206.20.228.70 secondary/db.206.20.228
primary   95.20.206.IN-ADDR.ARPA	primary/db.206.20.95
primary   115.20.206.IN-ADDR.ARPA	primary/db.206.20.115
primary   224.20.206.IN-ADDR.ARPA       primary/db.206.20.224
primary   225.20.206.IN-ADDR.ARPA       primary/db.206.20.225
primary   226.20.206.IN-ADDR.ARPA       primary/db.206.20.226
primary   227.20.206.IN-ADDR.ARPA       primary/db.206.20.227
