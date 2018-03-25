# Lezione 6 - Dynamic Host Configuration Protocol
## Esercizio 3 
- Realizzare in IMUNES, dopo aver disabilitato l’autoassegnamento degli indirizzi IP, una topologia di rete così composta:
	- 1 Host che fa da DHCP server
	- 2 switch, entrambi connessi all’host
	- 4 pc connessi a ciascuno switch
- Avviare l’esperimento
- Assegnare a ciascuna interfaccia del server DHCP un indirizzo IP
	- Sulla interfaccia eth0 assegnare il primo indirizzo ip della rete 172.16.0.64/28
	- Sulla interfaccia eth1 assegnare il primo indirizzo ip della rete 192.168.0.48/29
- Configurare sul server DHCP le due subnet assegnando indirizzi presi da un pool di dimensione 4

### Soluzione
Topologia: `topology.imn`
Script di automazione: `topology.sh`
