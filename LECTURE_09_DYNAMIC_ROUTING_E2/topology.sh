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
        echo -e ${bldgrn}"${cmd}"${Color_Off}
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

do_cmd "sudo himage pc1 ip addr add 192.168.0.1/24 dev eth0" "=> Impostato IP 192.168.0.1/24 sull'host pc1"
do_cmd "sudo himage pc2 ip addr add 192.168.1.1/24 dev eth0" "=> Impostato IP 192.168.1.1/24 sull'host pc2"
do_cmd "sudo himage pc1 ip route add 0.0.0.0/0 via 192.168.0.254" "=> Aggiungo route di default su pc1"
do_cmd "sudo himage pc2 ip route add 0.0.0.0/0 via 192.168.1.254" "=> Aggiungo route di default su pc2"

for router in $(seq 1 5); do
	do_cmd "sudo himage router${router} sed -i -e s/zebra=no/zebra=yes/g -e s/ospfd=no/ospfd=yes/g /etc/quagga/daemons" "Abilito Zebra e OSPFd su router${router}"
	do_cmd "sudo himage router${router} service quagga restart" "=> Riavvio demone quagga su router${router}"
    	source router${router}.sh
done

echo "[ ATTENDO CHE LE ROTTE SIANO PROPAGATE ]"
do_cmd "sudo himage pc1 bash -c 'until ping -c1 192.168.1.1 &>/dev/null; do :; done'" "Rotte propagate"
do_cmd "sudo himage pc2 bash -c 'until ping -c1 192.168.0.1 &>/dev/null; do :; done'" "Rotte propagate"
do_cmd "sudo himage pc1 traceroute 192.168.1.1" "Traceroute DEP1=>DEP2"
do_cmd "sudo himage pc2 traceroute 192.168.0.1" "Traceroute DEP2=>DEP1"

echo "[ SPENGO INTERFACCIA SU ROUTER2 ]"
do_cmd "sudo himage router2 ifconfig eth0 down" "=> Interfaccia spenta"

echo "[ ATTENDO CHE LE ROTTE SIANO PROPAGATE ]"
do_cmd "sudo himage pc1 bash -c 'until ping -c1 192.168.1.1 &>/dev/null; do :; done'" "Rotte propagate"
do_cmd "sudo himage pc1 traceroute 192.168.1.1" "Traceroute DEP1=>DEP2"
do_cmd "sudo himage pc2 traceroute 192.168.0.1" "Traceroute DEP2=>DEP1"
