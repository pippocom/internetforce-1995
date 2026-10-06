; zone 'mtds.com'   last serial 1996081903
; from 194.204.200.1   at Mon Aug 19 23:05:14 1996
$ORIGIN com.
mtds		IN	SOA	mtds.com. dnsmaster.mtds.com. (
		1996081906 10800 3600 604800 86400 )
		IN	NS	dns2.mtds.com.
		IN	NS	dns.mtds.com.
		IN	MX	1 mailbackup.mtds.com.
		IN	MX	0 mailhost.mtds.com.
		IN	A	194.204.200.2
$ORIGIN mtds.com.
smtp		IN	A	194.204.200.2
www2		IN	CNAME	data.mtds.com.
localhost	IN	A	127.0.0.1
news		IN	CNAME	mtds-nt.mtds.com.
pcLinux		IN	A	194.204.200.42
fw-data		IN	A	194.204.200.11
pcStage		IN	A	194.204.200.40
data		IN	A	194.204.200.1
mail		IN	A	194.204.200.2
mailhost	IN	CNAME	users.mtds.com.
scooby		IN	CNAME	pcKarl.mtds.com.
pcKarl		IN	A	194.204.200.34
pcKel		IN	A	194.204.200.37
pop		IN	A	194.204.200.2
mailbackup	IN	CNAME	data.mtds.com.
fw-users	IN	A	194.204.200.12
pcSandy		IN	A	194.204.200.38
mtds-nt		IN	A	194.204.200.39
dns		IN	A	194.204.200.1
fw-office	IN	A	194.204.200.33
pcLaptop	IN	A	194.204.200.43
dns1		IN	A	194.204.200.1
dns2		IN	A	194.204.200.2
users		IN	A	194.204.200.2
firewall	IN	CNAME	fw-office.mtds.com.
pcBachir	IN	A	194.204.200.35
sdnmar		IN	A	194.204.200.44
pcAdel		IN	A	194.204.200.41
minedu		IN	A	194.204.200.45
ppp1		IN	A	194.204.200.65
ppp2		IN	A	194.204.200.66
ppp3		IN	A	194.204.200.67
www		IN	CNAME	users.mtds.com.
ppp10		IN	A	194.204.200.74
ppp4		IN	A	194.204.200.68
ppp11		IN	A	194.204.200.75
ppp5		IN	A	194.204.200.69
ppp12		IN	A	194.204.200.76
ppp6		IN	A	194.204.200.70
ppp13		IN	A	194.204.200.77
ppp7		IN	A	194.204.200.71
ppp14		IN	A	194.204.200.78
ppp8		IN	A	194.204.200.72
ppp15		IN	A	194.204.200.79
ppp9		IN	A	194.204.200.73
ppp16		IN	A	194.204.200.80
ppp17		IN	A	194.204.200.81
maillist	IN	CNAME	data.mtds.com.
ftp		IN	CNAME	data.mtds.com.
pcJim		IN	A	194.204.200.36
