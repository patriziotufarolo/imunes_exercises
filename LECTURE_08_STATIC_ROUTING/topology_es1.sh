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

do_cmd "sudo himage router1 ip addr add 10.0.0.1/24 dev eth0" "Configuro l'ip 10.0.0.1/24 sull'interfaccia eth0 del router"
do_cmd "sudo himage router1 ip addr add 10.0.1.1/24 dev eth1" "Configuro l'ip 10.0.1.1/24 sull'interfaccia eth1 del router"

do_cmd "sudo himage pc1 ip addr add 10.0.0.2/24 dev eth0" "Configuro l'ip 10.0.0.2/24 sul PC1"
do_cmd "sudo himage pc2 ip addr add 10.0.1.2/24 dev eth0" "Configuro l'ip 10.0.0.2/24 sul PC2"
do_cmd "sudo himage pc1 ip route add 10.0.1.2 via 10.0.0.1" "Imposto la rotta per raggiungere 10.0.1.2 (PC1) tramite 10.0.0.1 (Router/eth0) su PC1"
do_cmd "sudo himage pc2 ip route add 10.0.0.2 via 10.0.1.1" "Imposto la rotta per raggiungere 10.0.0.2 (PC1) tramite 10.0.1.1 (Router/eth1) su PC2"
do_cmd_pid "sudo xterm -e 'himage router1 tcpdump -i eth0 icmp'" "Apro tcpdump su eth0" pid1
do_cmd_pid "sudo xterm -e 'himage router1 tcpdump -i eth1 icmp'" "Apro tcpdump su eth1" pid2
do_cmd "sudo himage pc1 ping -c5 10.0.1.2" "PING pc1 => pc2"
do_cmd "sudo himage pc2 ping -c5 10.0.0.2" "PING pc1 => pc2"

read -rsp $'\nPremere nuovamente invio per chiudere XTerm\n'
child_pid1=$(ps --ppid $pid1 -o pid=)
child_pid2=$(ps --ppid $pid2 -o pid=)
if sudo kill -0 $child_pid1; then
	sudo kill $child_pid1
fi
if sudo kill -0 $child_pid2; then
	sudo kill $child_pid2
fi
