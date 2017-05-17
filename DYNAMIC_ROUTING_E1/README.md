# Esercizio 1 su Routing Dinamico

1. Dopo aver lanciato l’esperimento (con assegnamento automatico degli indirizzi IP disabilitato), assegnare gli indirizzi IP degli host con i comandi della suite iproute2, abilitare i demoni Zebra e OSPFd modificando /etc/quagga/daemons e riavviare il demone quagga (service quagga restart)

2. Assegnare gli indirizzi IP dei router utilizzando Quagga tramite «vtysh»

3. Assegnare ai pc una rotta di default verso il proprio router

4. Dopo aver verificato il funzionamento della rete, abilitare OSPF sui router, dichiarando le reti ad essi conosciute tramite il comando «network» permettendo a PC1 di comunicare con PC2 (verificare con ping e traceroute)

5. Per ogni rete bisogna dichiarare un’area OSPF (a 32 bit), noi utilizzeremo l’area 0.0.0.0 (backbone)
