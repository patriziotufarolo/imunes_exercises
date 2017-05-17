

sudo hcp root-server/db.rootdns root:/etc/bind/db.rootdns
sudo hcp root-server/named.conf.local root:/etc/bind/named.conf.local

sudo hcp com/db.com dnsCom:/etc/bind/db.com
sudo hcp com/named.conf.local dnsCom:/etc/bind/named.conf.local

sudo hcp net/db.net dnsNet:/etc/bind/db.net
sudo hcp net/named.conf.local dnsNet:/etc/bind/named.conf.local

sudo hcp org/db.org dnsOrg:/etc/bind/db.org
sudo hcp org/named.conf.local dnsOrg:/etc/bind/named.conf.local


sudo hcp prova.com/db.prova.com provaDotCom:/etc/bind/db.prova.com
sudo hcp prova.com/named.conf.local provaDotCom:/etc/bind/named.conf.local

sudo hcp prova.net/db.prova.net provaDotNet:/etc/bind/db.prova.net
sudo hcp prova.net/named.conf.local provaDotNet:/etc/bind/named.conf.local

sudo hcp prova.org/db.prova.org provaDotOrg:/etc/bind/db.prova.org
sudo hcp prova.org/named.conf.local provaDotOrg:/etc/bind/named.conf.local

sudo himage root named
sudo himage dnsCom named
sudo himage dnsNet named
sudo himage dnsOrg named
sudo himage provaDotOrg named 
sudo himage provaDotNet named
sudo himage provaDotCom named


for server in $(seq 1 6); do
echo "nameserver 10.0.0.10" | sudo himage pc$server tee /etc/resolv.conf
done

