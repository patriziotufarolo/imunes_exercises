# Lezione 9 - Quagga e Routing dinamico con OSPF
## Esercizio 1

- Dopo aver lanciato l’esperimento (con assegnamento automatico degli indirizzi IP disabilitato), assegnare gli indirizzi IP degli host con i comandi della suite iproute2, abilitare i demoni Zebra e OSPFd modificando `/etc/quagga/daemons` e riavviare il demone quagga (`service quagga restart`)
- Assegnare gli indirizzi IP dei router utilizzando Quagga tramite `vtysh`
- Assegnare ai pc una rotta di default verso il proprio router
- Dopo aver verificato il funzionamento della rete, abilitare OSPF sui router, dichiarando le reti ad essi conosciute tramite il comando `network` permettendo a PC1 di comunicare con PC2 (verificare con ping e traceroute)
- Per ogni rete bisogna dichiarare un’area OSPF (a 32 bit), noi utilizzeremo l’area 0.0.0.0 (backbone)

### Soluzione
Topologia: `topology.imn`
Script di automazione: `topology.sh`
