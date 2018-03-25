# Lezione 3 - Livello 2 - Bridge e Switch 

## Esercizio 3 - Mirroring 
- Creare una topologia su IMUNES composta da:
	- 1 Switch
	- 3 PC chiamati:
		- PC1
		- PC2
		- Sonda
e avviare l'esperimento.
- Impostare la porta su cui è collegato il PC Sonda come porta di "mirror" di tutto il traffico di rete passante per lo switch
- Avviare tcpdump sul PC Sonda
- Effettuare un pinga da PC1 e PC2 ed osservare, mediante tcpdump, il traffico di rete

### Soluzione

Topologia: `topology.imn`
Script di automazione: `topology-enable-mirror.sh`
