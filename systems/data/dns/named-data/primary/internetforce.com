@  IN	SOA	dns dnsmaster.internetforce.com. (
		1996091101	 ; Serial
		10800		 ; Refresh 3 hours
		3600		 ; Retry 1 hour
		604800		 ; Expire after a week
		86400 )	 ; Minimum ttl 1 day
				NS	styx.ios.com.
				NS	noc.ios.com.
				NS	harley.ios.com.
; *****************************************************************
; This file is auto-generated from a master file -- do not edit it,
; but arrange that the master is edited instead.
; *****************************************************************
localhost      A  127.0.0.1
data      A  206.20.95.3
users      A  206.20.95.4
shell      A  206.20.95.5
fw-data      A  206.20.95.10
fw-users      A  206.20.95.11
fw-shell      A  206.20.95.12
firewall      A  206.20.95.129
dvlp      A  206.20.95.130
anna      A  206.20.95.131
franz      A  206.20.95.132
maxi      A  206.20.95.133
html      A  206.20.95.134
aps      A  206.20.95.135
cust2      A  206.20.95.136
isa      A  206.20.95.137
marco      A  206.20.95.140
PcDemo      A  206.20.95.141
oracolo      A  206.20.95.142
mailhost     CNAME  users.internetforce.com.
mail     CNAME  users.internetforce.com.
loghost     CNAME  dvlp.internetforce.com.
ftp     CNAME  data.internetforce.com.
www     CNAME  users.internetforce.com.
news     CNAME  news.ios.com.
proxy     CNAME  data.internetforce.com.
www1     CNAME  data.internetforce.com.
dns      A  206.20.95.3
dns2      A  206.20.95.4
internetforce.com.      MX  0  users.internetforce.com.
        MX  1  data.internetforce.com.
        A  206.20.95.4
ppp1-milano      A  206.20.95.70
ppp2-milano      A  206.20.95.71
ppp3-milano      A  206.20.95.72
ppp4-milano      A  206.20.95.73
ppp5-milano      A  206.20.95.74
ppp6-milano      A  206.20.95.75
ppp7-milano      A  206.20.95.76
ppp8-milano      A  206.20.95.77
ppp9-milano      A  206.20.95.78
ppp10-milano      A  206.20.95.79
ppp11-milano      A  206.20.95.80
ppp12-milano      A  206.20.95.81
ppp13-milano      A  206.20.95.82
ppp14-milano      A  206.20.95.83
ppp15-milano      A  206.20.95.84
ppp16-milano      A  206.20.95.85
ppp1-pesaro      A  206.20.115.2
ppp2-pesaro      A  206.20.115.3
ppp3-pesaro      A  206.20.115.4
ppp4-pesaro      A  206.20.115.5
ppp5-pesaro      A  206.20.115.6
ppp6-pesaro      A  206.20.115.7
ppp7-pesaro      A  206.20.115.8
ppp8-pesaro      A  206.20.115.9
ppp9-pesaro      A  206.20.115.10
ppp10-pesaro      A  206.20.115.11
ppp11-pesaro      A  206.20.115.12
ppp12-pesaro      A  206.20.115.13
ppp13-pesaro      A  206.20.115.14
ppp14-pesaro      A  206.20.115.15
ppp15-pesaro      A  206.20.115.16
ppp16-pesaro      A  206.20.115.17
ppp1-palermo      A  206.20.224.2
ppp2-palermo      A  206.20.224.3
ppp3-palermo      A  206.20.224.4
ppp4-palermo      A  206.20.224.5
ppp5-palermo      A  206.20.224.6
ppp6-palermo      A  206.20.224.7
ppp7-palermo      A  206.20.224.8
ppp8-palermo      A  206.20.224.9
ppp9-palermo      A  206.20.224.10
ppp10-palermo      A  206.20.224.11
ppp11-palermo      A  206.20.224.12
ppp12-palermo      A  206.20.224.13
ppp13-palermo      A  206.20.224.14
ppp14-palermo      A  206.20.224.15
ppp15-palermo      A  206.20.224.16
ppp16-palermo      A  206.20.224.17
ppp1-gorgonzola      A  206.20.225.2
ppp2-gorgonzola      A  206.20.225.3
ppp3-gorgonzola      A  206.20.225.4
ppp4-gorgonzola      A  206.20.225.5
ppp5-gorgonzola      A  206.20.225.6
ppp6-gorgonzola      A  206.20.225.7
ppp7-gorgonzola      A  206.20.225.8
ppp8-gorgonzola      A  206.20.225.9
ppp9-gorgonzola      A  206.20.225.10
ppp10-gorgonzola      A  206.20.225.11
ppp11-gorgonzola      A  206.20.225.12
ppp12-gorgonzola      A  206.20.225.13
ppp13-gorgonzola      A  206.20.225.14
ppp14-gorgonzola      A  206.20.225.15
ppp15-gorgonzola      A  206.20.225.16
ppp16-gorgonzola      A  206.20.225.17
