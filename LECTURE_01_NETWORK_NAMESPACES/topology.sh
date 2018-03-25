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

do_cmd_pid 	"sudo xterm -e 'ip netns exec h1 python2 -m SimpleHTTPServer 80'"	"=> Avvio un server HTTP sulla porta 80 di h1"	pid1
do_cmd		"sudo ip netns exec h2 firefox 10.0.0.1"			"=> Avvio Firefox su h2 e lo faccio connettere al server HTTP di h1"



child_pid=$(ps --pid $pid1 -o pid=)
if sudo kill -0 $pid1; then
	sudo kill $pid1
fi
if sudo kill -0 $child_pid; then
	sudo kill $child_pid
fi

./cleanup.sh
