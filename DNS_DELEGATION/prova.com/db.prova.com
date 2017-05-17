$ORIGIN prova.com.
$TTL 60000
@	IN	SOA	dns.prova.com.	root.prova.com (1 28800 14400 36000000 0)
@	IN	NS	dns.prova.com.
dns.prova.com. IN	A	10.0.0.15

pc3		IN	A	10.0.0.22
pc4 	IN	A	10.0.0.23
