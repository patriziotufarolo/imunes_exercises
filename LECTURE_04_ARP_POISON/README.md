# Lezione 4 - Introduzione a L3: il protocollo ARP 

## Esercizio 2 - Arp spoofing and cache poisoning 
- Creare una topologia a stella composta da:
	- 3 PC
	- 1 Switch (centro stella)
- Su PC3 (attaccante) avviare due attacchi di ARP Spoofing contro PC1 e PC2
	- Avvelenando la cache ARP di PC1 al fine di mandare tutto il traffico IP PC1 -> PC2 verso PC3
	- Avvelenando la cache ARP di PC2 al fine di mandare tutto il traffico IP PC2 -> PC1 verso PC3
	- Osservare le ARP table compromesse

### Soluzione

Topologia: `topology.imn`
Script di automazione: `topology.sh`
