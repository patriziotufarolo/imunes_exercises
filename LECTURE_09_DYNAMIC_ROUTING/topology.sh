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

do_cmd "sudo himage PC1Dep1 ip addr add 172.16.5.2/24 dev eth0"				"=> Impostato IP 172.16.5.2/24 sull'host pc1"
do_cmd "sudo himage PC2Dep1 ip addr add 172.16.5.3/24 dev eth0"				"=> Impostato IP 172.16.5.3/24 sull'host pc2"
do_cmd "sudo himage PC1Dep1 ip route add 0.0.0.0/0 via 172.16.5.1"				"=> Aggiungo route di default su pc1"
do_cmd "sudo himage PC2Dep1 ip route add 0.0.0.0/0 via 172.16.5.1"				"=> Aggiungo route di default su pc2"
do_cmd "sudo himage PC1Dep2 ip addr add 172.17.5.2/24 dev eth0"				"=> Impostato IP 172.17.5.2/24 sull'host pc3"
do_cmd "sudo himage PC2Dep2 ip addr add 172.17.5.3/24 dev eth0"				"=> Impostato IP 172.17.5.3/24 sull'host pc4"
do_cmd "sudo himage PC1Dep2 ip route add 0.0.0.0/0 via 172.17.5.1"				"=> Aggiungo route di default su pc3"
do_cmd "sudo himage PC2Dep2 ip route add 0.0.0.0/0 via 172.17.5.1"				"=> Aggiungo route di default su pc4"
do_cmd "sudo himage RouterDep1 sed -i -e s/zebra=no/zebra=yes/g -e s/ospfd=no/ospfd=yes/g /etc/quagga/daemons"	"=> Abilito Zebra e OSPFd su router1"
do_cmd "sudo himage RouterDep1 service quagga restart"					"=> Riavvio demone quagga su router1"
do_cmd "sudo himage RouterDep2 sed -i -e s/zebra=no/zebra=yes/g -e s/ospfd=no/ospfd=yes/g /etc/quagga/daemons"	"=> Abilito Zebra e OSPFd su router2"
do_cmd "sudo himage RouterDep2 service quagga restart" 					"=> Riavvio demone quagga su router2"
do_cmd "cat << END_ROUTER_CONF | sudo himage RouterDep1 vtysh 1>/dev/null 2>/dev/null
configure terminal
interface eth0
ip address 172.16.5.1/24
exit
interface eth1
ip address 192.168.0.1/24
exit
router ospf
network 192.168.0.0/24 area 0
network 172.16.5.0/24 area 0
exit
exit
END_ROUTER_CONF
cat << END_ROUTER_CONF | sudo himage RouterDep1 vtysh 1>/dev/null 2>/dev/null
configure terminal
interface eth0
ip address 172.16.5.1/24
exit
interface eth1
ip address 192.168.0.1/24
exit
router ospf
network 192.168.0.0/24 area 0
network 172.16.5.0/24 area 0
exit
exit
END_ROUTER_CONF" "=> Configuro Router1"

do_cmd "cat << END_ROUTER_CONF | sudo himage RouterDep2 vtysh 1>/dev/null 2>/dev/null
configure terminal
interface eth0
ip address 172.17.5.1/24
exit
interface eth1
ip address 192.168.0.2/24
exit
router ospf
network 192.168.0.0/24 area 0
network 172.16.5.0/24 area 0
exit
exit
END_ROUTER_CONF
cat << END_ROUTER_CONF | sudo himage RouterDep2 vtysh 1>/dev/null 2>/dev/null
configure terminal
interface eth0
ip address 172.17.5.1/24
exit
interface eth1
ip address 192.168.0.2/24
exit
router ospf
network 192.168.0.0/24 area 0
network 172.17.5.0/24 area 0
exit
exit
END_ROUTER_CONF" "=> Configuro Router2"

echo "[ ATTENDO CHE LE ROTTE SIANO PROPAGATE ]"
do_cmd "sudo himage PC1Dep1 bash -c 'until ping -c1 172.17.5.1 &>/dev/null; do :; done'" "Rotte propagate"
do_cmd "sudo himage PC1Dep1 traceroute 172.17.5.1" "Traceroute DEP1=>DEP2"
do_cmd "sudo himage PC1Dep2 traceroute 172.16.5.1" "Traceroute DEP2=>DEP1"

