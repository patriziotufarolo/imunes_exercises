#!/bin/bash

echo "------------------------------------"
echo "~   Corso di Reti di Calcolatori   ~"
echo "~ Universita degli Studi di Milano ~"
echo "------------------------------------"

echo "Autore: Patrizio Tufarolo <patrizio@tufarolo.eu>"
echo


# MIT License
#  
# Copyright (c) 2018 Patrizio Tufarolo
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
##

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

EXPERIMENT="$(sudo himage -e pc1)"

do_cmd "sudo himage DHCPServer ip addr add 172.16.0.1/16 dev eth0" "Assegno l'indirizzo 172.16.0.1 al server DHCP"
do_cmd "sudo himage DHCPServer sh -c 'echo > /etc/dhcp/dhcpd.conf'" "Svuoto il file /etc/dhcp/dhcpd.conf"

do_cmd "cat | sudo himage DHCPServer sh -c 'cat > /etc/dhcp/dhcpd.conf << EOF
option domain-name-servers 172.16.0.1;
option subnet-mask 255.255.0.0;
option routers 172.16.0.1;

subnet 172.16.0.0 netmask 255.255.0.0 {
	range 172.16.1.1 172.16.1.254;
}
EOF'" "Configuro il server DHCP"

do_cmd_pid "sudo xterm -e 'himage DHCPServer dhcpd -d'" "Avvio il server DHCP" pid1
do_cmd_pid "sudo xterm -e 'himage DHCPServer tcpdump'" "Apro TCPDump" pid2
for pcid in {1..4}; do
do_cmd "sudo himage pc${pcid} dhclient eth0" "Avvio il client DHCP su pc${pcid}"
done
read -rsp $'\nPremere nuovamente invio per chiudere XTerm\n'
child_pid1=$(ps --ppid $pid1 -o pid=)
if sudo kill -0 $pid1; then
sudo kill $pid1
fi
child_pid2=$(ps --ppid $pid2 -o pid=)
if sudo kill -0 $pid2; then
sudo kill $pid2
fi
