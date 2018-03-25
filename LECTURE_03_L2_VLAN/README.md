# Lezione 3 - Livello 2 - Bridge e Switch 

## Esercizio 1 - VLAN
 Disegnare su IMUNES una possibile topologia di rete di ateneo per la sede di Crema dell'Università degli Studi di Milano.
La topologia deve essere gestita tramite un unico switch e deve avere 3 VLAN completamente separate tra loro:
	- VLAN Segreteria (tag: 10)
	- VLAN Docenti (tag: 20)
	- VLAN Studenti (tag: 30)

- A ogni VLAN devono essere collegati almeno due computer
- In fase di disegno, avvalersi degli strumenti grafici di IMUNES per raffiguare le VLAN
- Impostare i VLAN tag opportunamente mediante Open-vSwitch
### Soluzione
Topologia: `topology.imn`
Script di automazione: `topology.sh`
