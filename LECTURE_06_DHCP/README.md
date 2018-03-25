# Lezione 6 - Dynamic Host Configuration Protocol
## Esercizio 1
- Disabilitare l’autoassegnamento degli indirizzi IPv4 e IPv6 su IMUNES
- Creare una topologia composta da
	- 1 Switch
	- 1 Host (server DHCP) e 4 PC, collegati allo switch
- Avviare l’esperimento
- Assegnare l’indirizzo IP 172.16.0.1/16 all’host
- Partire da un file /etc/dhcp/dhcpd.conf vuoto con il comando
`echo > /etc/dhcp/dhcpd.conf`
- Popolare il file dhcpd.conf 
	- Distribuendo l’IP dell’host come DNS e default gateway
	- Allocando gli IP da 172.16.1.1 a 172.16.1.254 ai PC
- Avviare il demone dhcpd ( `dhcpd -d` )
- Avviare tcpdump su uno dei PC per osservare il traffico in tempo reale
- Lanciare su tutti i PC il comando dhclient eth0 e osservare tcpdump

### Soluzione
Topologia: `topology.imn`
Script di automazione: `topology.sh`
