#!/bin/bash

echo "------------------------------------"
echo "~   Corso di Reti di Calcolatori   ~"
echo "~ Universita degli Studi di Milano ~"
echo "------------------------------------"

echo "Autore: Patrizio Tufarolo <patrizio@tufarolo.eu>"
echo

Color_Off='\e[0m' 
Purple='\e[0;35m'
ok_colorato_per_log() {
        RED=$(tput setaf 1)
        GREEN=$(tput setaf 2)
        NORMAL=$(tput sgr0)
        LENMSG="$1"
        let COL=$(tput cols)-${LENMSG}
        printf "%${COL}s%s%s%s%s%s" "$NORMAL" "[" "$GREEN" "OK" "$NORMAL" "]"
        echo ---
}
do_cmd() {
	local cmd;
	local msg;
	cmd="$1"
	msg="$2"
	echo -e $Purple $cmd $Color_Off;
	echo -n $msg
	eval "$cmd" 2>/dev/null 1>/dev/null
	ok_colorato_per_log ${#msg}
}
do_cmd_pid() {
	local cmd;
	local msg;
	local pid;
	cmd="$1"
	msg="$2"
	echo -e $Purple $cmd $Color_Off;
	echo -n $msg
	eval "$cmd"
	pid="$!"
	echo $pid > .pid
	ok_colorato_per_log ${#msg}
}

sudo -i exit


do_cmd "sudo ip netns add h1"							"=> Creo un namespace chiamato h1"
do_cmd "sudo ip netns add h2" 							"=> Creo un namespace chiamato h2"
do_cmd "sudo ovs-vsctl add-br s1"						"=> Creo uno switch chiamato s1"
do_cmd "sudo ip link add h1-eth0 type veth peer name s1-eth0"			"=> Creo una veth chiamata h1-eth0 con peer s1-eth0"
do_cmd "sudo ip link add h2-eth0 type veth peer name s1-eth1"			"=> Creo una veth chiamata h2-eth0 con peer s1-eth1"

do_cmd "sudo ovs-vsctl add-port s1 s1-eth0"					"=> Assegno l'interfaccia s1-eth0 a s1"
do_cmd "sudo ovs-vsctl add-port s1 s1-eth1"					"=> Assegno l'interfaccia s1-eth1 a s1"

do_cmd "sudo ip link set up dev s1-eth0"					"=> Accendo s1-eth0"
do_cmd "sudo ip link set up dev s1-eth1"					"=> Accendo s1-eth1"

do_cmd "sudo ip link set h1-eth0 netns h1"					"=> Sposto h1-eth0 in h1"
do_cmd "sudo ip link set h2-eth0 netns h2"					"=> Sposto h2-eth0 in h2"
do_cmd "sudo ip netns exec h1 ip addr add 10.0.0.1/24 dev h1-eth0"		"=> Assegno l'IP 10.0.0.1/24 a h1-eth0 di h1"
do_cmd "sudo ip netns exec h2 ip addr add 10.0.0.2/24 dev h2-eth0"		"=> Assegno l'IP 10.0.0.2/24 a h2-eth0 di h2"

do_cmd "sudo ip netns exec h1 ip link set up dev h1-lo"				"=> Accendo l'interfaccia h1-lo"
do_cmd "sudo ip netns exec h1 ip link set up dev h1-eth0"			"=> Accendo l'interfaccia h1-eth0"
do_cmd "sudo ip netns exec h2 ip link set up dev h2-lo" 			"=> Accendo l'interfaccia h2-lo"
do_cmd "sudo ip netns exec h2 ip link set up dev h2-eth0"			"=> Accendo l'interfaccia h2-eth0"

do_cmd_pid 	"sudo ip netns exec h1 python2 -m SimpleHTTPServer 80 &"	"=> Avvio un server HTTP sulla porta 80 di h1"
do_cmd		"sudo ip netns exec h2 firefox 10.0.0.1"			"=> Avvio Firefox su h2 e lo faccio connettere al server HTTP di h1"

./cleanup.sh
