# Lezione 1 - Software Defined Networking e IMUNES
## Realizzazione della topologia di rete con Linux

### Script: Network Namespaces
Questo script realizza la topologia vista a lezione sfruttando i Namespace di Linux e Open-vSwitch

- Crea due namespace
- Crea un bridge in Open-vSwitch
- Crea due link veth
- Assegna una veth a ciascun namespace
- Assegna l'ip alle veth
- Attiva i link
- Assegna le peer al bridge Open-vSwitch
- Testa la comunicazione

