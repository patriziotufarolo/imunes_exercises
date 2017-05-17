$TTL 60000
@	IN	SOA	dns.com.	root.dns.com (1 28800 14400 36000000 0)
@	IN	NS	dns.com.
dns.com.	IN	A	10.0.0.12

prova.com.	IN	NS	dns.prova.com.
dns.prova.com. IN	A	10.0.0.15
