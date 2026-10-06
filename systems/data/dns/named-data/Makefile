# Yoav: if you get the error message "whatever is 5% shorter than previous..."
# then change the appropriate line in this file and add the -short
# as in the next line.
#makezones-0.10 -short <michlala>.source <michlala>.com ........
#

all :	primary/internetforce.com \
	primary/internetforce.it \
	primary/canalemoda.com \
	primary/sicilia.com \
	primary/pesaro.com \
	primary/intf.com \
	primary/creo-mi.com \
	primary/pippo.com \
	primary/boldyoung.com \
	primary/loveisland.com \
	primary/shiseidoit.com \
	primary/calabria.com \
	primary/glassonline.com \
	primary/nassetti.com \
	primary/net-pool.com \
	primary/tecnos.com \
	primary/financialreports.com \
	primary/pcpesaro.com \
        primary/promotion.it \
        primary/tera-it.com \
	secondary/cnn.it \
	primary/art-diary.com 

primary/internetforce.com : internetforce.source
	makezones-0.10 internetforce.source internetforce.com primary/internetforce.com primary/db.206.20.115 primary/db.206.20.224 primary/db.206.20.225 primary/db.206.20.95  primary/db.206.20.226
	kill -HUP `cat /etc/named.pid`


primary/intf.com : intf.source
	makezones-0.10 intf.source intf.com primary/intf.com
	kill -HUP `cat /etc/named.pid`


primary/internetforce.it : internetforce.it.source
	makezones-0.10 internetforce.it.source internetforce.it primary/internetforce.it
	kill -HUP `cat /etc/named.pid`

primary/canalemoda.com : canalemoda.source
	makezones-0.10 canalemoda.source canalemoda.com primary/canalemoda.com
	kill -HUP `cat /etc/named.pid`

primary/sicilia.com : sicilia.source
	makezones-0.10 sicilia.source sicilia.com primary/sicilia.com
	kill -HUP `cat /etc/named.pid`

primary/pesaro.com : pesaro.source
	makezones-0.10 pesaro.source pesaro.com primary/pesaro.com
	kill -HUP `cat /etc/named.pid`

primary/creo-mi.com : creo-mi.source
	makezones-0.10 creo-mi.source creo-mi.com primary/creo-mi.com
	kill -HUP `cat /etc/named.pid`

primary/art-diary.com : art-diary.source
	makezones-0.10 art-diary.source art-diary.com primary/art-diary.com
	kill -HUP `cat /etc/named.pid`

primary/pippo.com : pippo.source
	makezones-0.10 pippo.source pippo.com primary/pippo.com
	kill -HUP `cat /etc/named.pid`

primary/pcpesaro.com : pcpesaro.source
	makezones-0.10 pcpesaro.source pcpesaro.com primary/pcpesaro.com
	kill -HUP `cat /etc/named.pid`

primary/boldyoung.com : boldyoung.source
	makezones-0.10 boldyoung.source boldyoung.com primary/boldyoung.com
	kill -HUP `cat /etc/named.pid`

primary/loveisland.com : loveisland.source
	makezones-0.10 loveisland.source loveisland.com primary/loveisland.com
	kill -HUP `cat /etc/named.pid`

primary/shiseidoit.com : shiseidoit.source
	makezones-0.10 shiseidoit.source shiseidoit.com primary/shiseidoit.com
	kill -HUP `cat /etc/named.pid`

primary/glassonline.com : glassonline.source
	makezones-0.10 glassonline.source glassonline.com primary/glassonline.com
	kill -HUP `cat /etc/named.pid`

primary/nassetti.com : nassetti.source
	makezones-0.10 nassetti.source nassetti.com primary/nassetti.com
	kill -HUP `cat /etc/named.pid`

primary/net-pool.com : net-pool.source
	makezones-0.10 net-pool.source net-pool.com primary/net-pool.com
	kill -HUP `cat /etc/named.pid`

primary/tera-it.com : tera-it.source
	makezones-0.10 tera-it.source tera-it.com primary/tera-it.com primary/db.206.20.227
	kill -HUP `cat /etc/named.pid`

secondary/cnn.it : cnn.it.source
	makezones-0.10 cnn.it.source cnn.it secondary/cnn.it secondary/db.206.20.228
	kill -HUP `cat /etc/named.pid`

primary/calabria.com : calabria.source
	makezones-0.10 calabria.source calabria.com primary/calabria.com
	kill -HUP `cat /etc/named.pid`

primary/tecnos.com : tecnos.source
	makezones-0.10 tecnos.source tecnos.com primary/tecnos.com
	kill -HUP `cat /etc/named.pid`

primary/financialreports.com : financialreports.source
	makezones-0.10 financialreports.source financialreports.com primary/financialreports.com
	kill -HUP `cat /etc/named.pid`

primary/promotion.it : promotion.it.source
	makezones-0.10 promotion.it.source promotion.it primary/promotion.it
	kill -HUP `cat /etc/named.pid`

