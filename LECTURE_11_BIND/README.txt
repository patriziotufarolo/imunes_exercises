# Lezione 11: Domain Name Resolution  Protocol
## Esercizio 2:
- Riprodurre il funzionamento di un server DNS su internet su IMUNES creando una topologia a stella composta da uno switch, sette server DNS e sei PC.
- Configurare tutti gli host in modo da avere:
	- Un server DNS radice che delega ognuna delle seguenti zone
		- Org
		- Com
		- Net
	a ciascuno degli altri server dns.
- Per ogni zona definire una sottozona di secondo livello sul relativo server DNS (andando a costituire un sottodominio ad es. prova.org, prova.net, prova.com)

Ogni sottodominio ha un proprio server DNS, che referenzia due PC (per ogni sottodominio), di cui vanno configurati i record A in modo opportuno

### Soluzione
Topologia: `topology.imn`
Script di automazione: `topology.sh`

Sono allegati i file di configurazione che verranno copiati sui server DNS

