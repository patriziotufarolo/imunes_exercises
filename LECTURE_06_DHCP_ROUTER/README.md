# Lezione 6 - Dynamic Host Configuration Protocol
## Esercizio 2 
Realizzare in IMUNES la topologia di rete di un’azienda che dispone di una rete di classe C (192.168.0.0/24) formata da:
- Uno switch collegato a un router per la connettività a Internet
- Un host che fa da DHCP server
- 2 server a cui viene assegnato un IP statico
- 260 pc portatili, non contemporaneamente connessi (provare con 4 pc in IMUNES - possono essere connessi contemporaneamente al massimo 200 pc), nella stessa sottorete dei server
	- Assegnare l’indirizzo IP in modo dinamico tramite DHCP
	- Impostare la durata del lease DHCP in modo intelligente, così da poter prevedere la gestione di 260 diversi client
- 2 pc fissi, assegnati al CEO dell’azienda, che si è riservato di utilizzare gli ultimi due indirizzi della sottorete effettuando una configurazione semi-statica (DHCP reservation) sul DHCP server

### Soluzione
Topologia: `topology.imn`
Script di automazione: `topology.sh`
