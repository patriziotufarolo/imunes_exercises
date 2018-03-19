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
pid=
do_cmd_pid() {
	local cmd;
	local msg;
	cmd="$1"
	msg="$2"
	echo
	echo -e $bldgrn $cmd $Color_Off;
	eval "$cmd & "
	pid=$!
	echo -n "$msg"
	ok_colorato_per_log ${#msg}
	read -rsp $'\nPremere invio per continuare...\n'
}


sudo -i exit

EXPERIMENT="$(sudo himage -e pc1)"

do_cmd "sudo himage pc1 ip neigh flush 10.0.0.21"						"=> Flush ARP" 
do_cmd_pid "xterm -e 'sudo himage PCSonda tcpdump -i eth0 arp'"					"=> Avvio TCPDump su PCSonda in una XTERM separata"
do_cmd "sudo himage pc1 ping -c 1 10.0.0.21"							"=> Effettuo il PING"
do_cmd "sudo himage pc1 ip neigh"								"=> Stampo la tabella ARP"
read -rsp $'\nPremere invio nuovamente per chiudere XTERM...\n'
sudo kill -9 $pid 1>/dev/null 2>/dev/null;
