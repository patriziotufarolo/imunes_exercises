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
	eval "$cmd"  2>/dev/null
	echo
	echo -n "$msg"
	ok_colorato_per_log ${#msg}
}

sudo -i exit

local EXPERIMENT;
EXPERIMENT="$(sudo himage -e pc1)"

do_cmd "sudo ovs-vsctl set bridge ${EXPERIMENT}-n0 stp_enable=true" "Abilito STP su n0"
do_cmd "sudo ovs-vsctl set bridge ${EXPERIMENT}-n1 stp_enable=true" "Abilito STP su n1"
do_cmd "sudo ovs-vsctl set bridge ${EXPERIMENT}-n2 stp_enable=true" "Abilito STP su n2"
do_cmd "sudo ovs-vsctl set bridge ${EXPERIMENT}-n3 stp_enable=true" "Abilito STP su n3"

echo
