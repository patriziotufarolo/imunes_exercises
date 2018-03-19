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

for num in {1..4}; do
	do_cmd "sudo himage pc${num} ip addr add 192.168.0.${num}/27 dev eth0"		"=> Assegno l'ip 192.168.0.${num}/27 a pc${num}"
done

read -rsp $'\nPremere invio per continuare...\n'

for num in {1..4}; do
	do_cmd "sudo himage pc$((${num}+4)) ip addr add 192.168.0.$((${num}+32))/27 dev eth0"		"=> Assegno l'ip 192.168.0.$((${num}+32))/27 a pc$((${num}+4))"
done

read -rsp $'\nPremere invio per continuare...\n'

for num in {1..4}; do
	do_cmd "sudo himage pc$((${num}+8)) ip addr add 192.168.0.$((${num}+64))/27 dev eth0"		"=> Assegno l'ip 192.168.0.$((${num}+64))/27 a pc$((${num}+4))"
done

read -rsp $'\nPremere invio per continuare...\n'

for num in {1..4}; do
	do_cmd "sudo himage pc$((${num}+12)) ip addr add 192.168.0.$((${num}+96))/27 dev eth0"		"=> Assegno l'ip 192.168.0.$((${num}+96))/27 a pc$((${num}+4))"
done

