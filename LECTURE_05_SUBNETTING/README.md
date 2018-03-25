# Lezione 5 - Livello 3: Il protocollo IP

## Esercizio 1 - Subnetting FLSM
- Suddividere lo spazio di indirizzamento 192.168.0.0/24 in quattro porzioni
- Creare uno switch
- Per ciascuna subnet ottenuta dal punto *1* creare 4 pc e collegarli allo switch
- Effettuare le prove di connettività con il comando `ping`. 

### Soluzione

Topologia: `topology-flsm.imn`
Script di automazione: `topology-flsm.sh`

## Esercizio 2 - Subnetting VLSM
- Suddividere lo spazio di indirizzamento della rete 172.25.0.0/15 in 4 sottoreti:
	- 1 sottorete da 254 host
	- 1 sottorete da 14 host
	- 1 sottorete da 126 host
	- 1 sottorete da 128 host
- Per ciascuna subnet ottenuta dal punto *1* creare 2 pc e collegarli allo switch
- Effettuare le prove di connettività con il comando `ping`. 

### Soluzione
Topologia: `topology-vlsm.imn`
Script di automazione: `topology-vlsm.sh`
Script di automazione alternativo: `topology-vlsm-alternative.sh`

