# Lezione 3 - Livello 2 - Bridge e Switch 

## Esercizio 3 - Spanning Tree Protocol 
- Disegnare una topologia ridondante formata da: 
	- 4 switch interconnessi come i vertici di un quadrato
	- 4 pc, ciascuno connesso a uno switch

- Avviare l'esperimento e lanciare TCP Dump su uno dei PC
- Lanciare un PING tra due degli altri PC ed osserevare il flooding sulla rete
- Abilitare STP su Open-vSwitch, attenderne la convergenza e il ripristino del funzionamento della rete

### Soluzione
Topologia: `topology.imn`
Script di automazione: `topology-enable-stp.sh`
