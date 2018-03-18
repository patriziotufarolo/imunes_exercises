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

do_cmd "sudo ovs-vsctl set port ${EXPERIMENT}-n0-e0 tag=10"
do_cmd "sudo ovs-vsctl set port ${EXPERIMENT}-n0-e1 tag=10"
do_cmd "sudo ovs-vsctl set port ${EXPERIMENT}-n0-e2 tag=20"
do_cmd "sudo ovs-vsctl set port ${EXPERIMENT}-n0-e3 tag=20"
do_cmd "sudo ovs-vsctl set port ${EXPERIMENT}-n0-e4 tag=30"
do_cmd "sudo ovs-vsctl set port ${EXPERIMENT}-n0-e5 tag=30"
do_cmd "sudo ovs-vsctl show"

do_cmd "sudo himage pc1 ping -c 5 10.0.0.21"							"=> Ping pc1 => pc2 COMUNICANO"
do_cmd "sudo himage pc3 ping -c 5 10.0.0.23"							"=> Ping pc3 => pc4 COMUNICANO"
do_cmd "sudo himage pc5 ping -c 5 10.0.0.25"							"=> Ping pc5 => pc6 COMUNICANO"
do_cmd "sudo himage pc1 ping -c 1 10.0.0.22"							"=> Ping pc1 => pc3 NON COMUNICANO"
do_cmd "sudo himage pc1 ping -c 1 10.0.0.24"							"=> Ping pc1 => pc5 NON COMUNICANO"
do_cmd "sudo himage pc3 ping -c 1 10.0.0.24"							"=> Ping pc3 => pc5 NON COMUNICANO"
echo
