# Lezione 3 - Livello 2 - Bridge e Switch 

## Esercizio 2 - Trunking
Disegnare una topologia di rete su IMUNES che abbia:
- Due switch interconnessi mediante un link
- Tre VLAN analoghe a quelle dell'esercizio precedente

Abilitare il trunking tra i due switch esclusivamente per le VLAN Segreteria e Docenti, ma NON per la VLAN studenti.

Collegare allo switch n.1 due PC:
- 1 PC andrà assegnato alla VLAN segreteria
- 1 PC andrà assegnato alla VLAN docenti 

Collegare allo switch n.2 tre PC
- 1 PC andrà assegnato alla VLAN segreteria
- 1 PC andrà assegnato alla VLAN docenti 
- 1 PC andrà assegnato alla VLAN studenti 

ed effettuare i test di comunicazione.

### Soluzione
Topologia: `topology.imn`
Script di automazione: `topology.sh`

## Parte 2
Cosa succede collegando un PC con vlan studenti allo switch n.1? Riuscirà a comunicare con gli altri PC della stessa vlan?

### Soluzione
Topologia: `topology-studente.imn`
Script di automazione: `topology-studente.sh`


