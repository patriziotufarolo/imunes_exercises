#!/bin/bash

echo "------------------------------------"
echo "~   Corso di Reti di Calcolatori   ~"
echo "~ Universita degli Studi di Milano ~"
echo "------------------------------------"

echo "Autore: Patrizio Tufarolo <patrizio@tufarolo.eu>"
echo

Color_Off='\e[0m' 
bldgrn='\e[1;32m'

ok_colorato_per_log() {
        RED=$(tput setaf 1)
        GREEN=$(tput setaf 2)
        NORMAL=$(tput sgr0)
        LENMSG="$1"
        let COL=$(tput cols)-${LENMSG}
        printf "%${COL}s%s%s%s%s%s" "$NORMAL" "[" "$GREEN" "OK" "$NORMAL" "]"
}
do_cmd() {
	local cmd;
	local msg;
	cmd="$1"
	msg="$2"
	echo
	echo -e $bldgrn $cmd $Color_Off;
	eval "$cmd" 2>/dev/null
	echo
	echo -n "$msg"
	ok_colorato_per_log ${#msg}
	read -rsp $'\nPremere invio per continuare...\n'
}
do_cmd_pid() {
	local cmd;
	local msg;
	local pid;
	local __resultvar=$3;
	cmd="$1"
	msg="$2"
	
	echo
	echo -e $bldgrn $cmd $Color_Off;
	eval "$cmd & "
	pid=$!
	echo -n "$msg"
	ok_colorato_per_log ${#msg}
	read -rsp $'\nPremere invio per continuare...\n'
	eval $__resultvar=$pid;
}



sudo -i exit

EXPERIMENT="$(sudo himage -e pc1)"

do_cmd "sudo himage DHCPServer ip addr add 172.16.0.1/16 dev eth0" "Assegno l'indirizzo 172.16.0.1 al server DHCP"
do_cmd "sudo himage DHCPServer sh -c 'echo > /etc/dhcp/dhcpd.conf'" "Svuoto il file /etc/dhcp/dhcpd.conf"

do_cmd "cat | sudo himage DHCPServer sh -c 'cat > /etc/dhcp/dhcpd.conf << EOF
option domain-name-servers 172.16.0.1;
option subnet-mask 255.255.0.0;
option routers 172.16.0.1;

subnet 172.16.0.0 netmask 255.255.0.0 {
	range 172.16.1.1 172.16.1.254;
}
EOF'" "Configuro il server DHCP"

do_cmd_pid "xterm -e 'sudo himage DHCPServer dhcpd -d'" "Avvio il server DHCP" pid1
do_cmd_pid "xterm -e 'sudo himage DHCPServer tcpdump'" "Apro TCPDump" pid2
for pcid in {1..4}; do
do_cmd "sudo himage pc${pcid} dhclient eth0" "Avvio il client DHCP su pc${pcid}"
done
read -rsp $'\nPremere nuovamente invio per chiudere XTerm\n'
if pidof $pid1; then
kill -9 $pid1
fi
if pidof $pid2; then
kill -9 $pid2
fi
