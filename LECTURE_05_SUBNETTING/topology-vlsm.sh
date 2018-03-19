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
	echo -e ${bldgrn}${cmd}${Color_Off};
	eval "$cmd" 2>/dev/null
	echo -n "$msg"
	ok_colorato_per_log ${#msg}
}
do_cmd_pid() {
	local cmd;
	local msg;
	local pid;
	local __resultvar=$3;
	cmd="$1"
	msg="$2"
	
	echo -e ${bldgrn}${cmd}${Color_Off};
	eval "$cmd & "
	pid=$!
	echo -n "$msg"
	ok_colorato_per_log ${#msg}
	read -rsp $'\nPremere invio per continuare...\n'
	eval $__resultvar=$pid;
}



sudo -i exit

EXPERIMENT="$(sudo himage -e pc1)"


do_cmd "sudo himage pc1 ip addr add 172.25.0.1/24 dev eth0"		"Assegno l'IP 172.25.0.1 a PC1"
do_cmd "sudo himage pc2 ip addr add 172.25.0.254/24 dev eth0"		"Assegno l'IP 172.25.0.254 a PC2"

read -rsp $'\nPremere invio per continuare...\n'

do_cmd "sudo himage pc3 ip addr add 172.25.1.1/28 dev eth0"		"Assegno l'IP 172.25.1.1 a PC3"
do_cmd "sudo himage pc4 ip addr add 172.25.1.14/28 dev eth0"		"Assegno l'IP 172.25.2.14 a PC4"

read -rsp $'\nPremere invio per continuare...\n'

do_cmd "sudo himage pc5 ip addr add 172.25.2.1/25 dev eth0"		"Assegno l'IP 172.25.2.1 a PC5"
do_cmd "sudo himage pc6 ip addr add 172.25.2.126/25 dev eth0"		"Assegno l'IP 172.25.2.126 a PC6"

read -rsp $'\nPremere invio per continuare...\n'

do_cmd "sudo himage pc7 ip addr add 172.25.3.1/24 dev eth0"		"Assegno l'IP 172.25.3.1 a PC7"
do_cmd "sudo himage pc8 ip addr add 172.25.3.128/24 dev eth0"		"Assegno l'IP 172.25.3.127 a PC8"

echo
