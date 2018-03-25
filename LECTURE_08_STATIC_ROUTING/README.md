# Lezione 8 - Livello 3 - Routing Statico 
## Esercizio 1 
- Dopo aver disabilitato l’autoassegnamento degli indirizzi IP
creare in IMUNES una topologia di rete composta da:
	- 2 PC, pc1 e pc2
	- 1 router, connesso ai due pc
- Configurare gli indirizzi IP per pc1, pc2 e router, in modo che pc1 e pc2 appartengano a due reti diverse e il router appartenga ad entrambe le reti
- Aggiungere una rotta che permetta a pc1 di contattare pc2 passando per il router, e viceversa
- Avviare un traceroute da pc1 a pc2
- Avviare un ping da pc1 a pc2, ed osservarlo tramite tcpdump sul router

### Soluzione
Topologia: `topology-es1.imn`
Script di automazione: `topology-es1.sh`

## Esercizio 2 
L’azienda «A» possiede due dipartimenti
Il primo dipartimento contiene due postazioni collegate a un core switch, che hanno IP appartenente alla rete 172.16.5.0/24
Il core switch è connesso tramite un router a una rete condivisa a un altro dipartimento che dispone di una topologia di rete esattamente analoga, con IP appartenenti alla rete 172.17.5.0/24
La rete condivisa, composta dai due router connessi tra loro, ha IP appartenenti a 192.168.0.0/24

Dopo aver disabilitato l’autoassegnamento degli indirizzi IP, realizzare questa topologia con IMUNES e configurare opportunamente la tabella di routing per far dialogare i PC dei due dipartimenti.
Utilizzare traceroute per visualizzare il percorso dei pacchetti generati dai PC del primo dipartimento e destinati ai PC del secondo dipartimento, e viceversa

### Soluzione
Topologia: `topology_es2.imn`
Script di automazione: `topology_es2.sh`
