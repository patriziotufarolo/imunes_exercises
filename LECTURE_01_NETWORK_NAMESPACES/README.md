# Lezione 1 - Software Defined Networking e IMUNES

## Esercizio: Realizzare una semplice topologia composta da due Linux namespace che comunicano attraverso uno switch Open-vSwitch.

- Crea due namespace
- Crea un bridge in Open-vSwitch
- Crea due link veth
- Assegna una veth a ciascun namespace
- Assegna l'ip alle veth
- Attiva i link
- Assegna le peer al bridge Open-vSwitch
- Testa la comunicazione

