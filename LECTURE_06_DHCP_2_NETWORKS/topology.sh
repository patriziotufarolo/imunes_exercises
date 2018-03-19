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

do_cmd "sudo himage DHCPServer ip addr add 172.16.0.65/28 dev eth0" "Assegno l'indirizzo 172.16.0.65/28 al server DHCP sull'interfaccia eth0"
do_cmd "sudo himage DHCPServer ip addr add 192.168.0.49/29 dev eth1" "Assegno l'indirizzo 192.168.0.49/29 al server DHCP sull'interfaccia eth1"
do_cmd "sudo himage DHCPServer sh -c 'echo > /etc/dhcp/dhcpd.conf'" "Svuoto il file /etc/dhcp/dhcpd.conf"

do_cmd "cat | sudo himage DHCPServer sh -c 'cat > /etc/dhcp/dhcpd.conf << EOF
default-lease-time 7200;
subnet 172.16.0.64 netmask 255.255.255.240 {
	range 172.16.0.66 172.16.0.69;
	default-lease-time 3600;
}
subnet 192.168.0.48 netmask 255.255.255.248 {
	range 192.168.0.50 192.168.0.53;
}
EOF'" "Configuro il server DHCP"

do_cmd_pid "xterm -e 'sudo himage DHCPServer dhcpd -d'" "Avvio il server DHCP" pid1

for pcid in {1..6}; do
do_cmd "sudo himage pc${pcid} dhclient eth0" "Avvio il client DHCP su pc${pcid}"
done
for pcid in {1..6}; do
do_cmd "sudo himage pc${pcid} ip addr show dev eth0" "Mostro l'ip di pc${pcid}"
done

if pidof $pid1; then
	kill -9 $pid1
fi
