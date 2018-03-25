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


do_cmd "sudo himage pc1 ip addr add 172.25.0.1/24 dev eth0"		"Assegno l'IP 172.25.0.1 a PC1"
do_cmd "sudo himage pc2 ip addr add 172.25.0.254/24 dev eth0"		"Assegno l'IP 172.25.0.254 a PC2"

read -rsp $'\nPremere invio per continuare...\n'

do_cmd "sudo himage pc3 ip addr add 172.25.1.1/25 dev eth0"		"Assegno l'IP 172.25.1.1 a PC3"
do_cmd "sudo himage pc4 ip addr add 172.25.1.126/25 dev eth0"		"Assegno l'IP 172.25.2.14 a PC4"

read -rsp $'\nPremere invio per continuare...\n'

do_cmd "sudo himage pc5 ip addr add 172.25.1.129/28 dev eth0"		"Assegno l'IP 172.25.2.1 a PC5"
do_cmd "sudo himage pc6 ip addr add 172.25.1.142/28 dev eth0"		"Assegno l'IP 172.25.2.126 a PC6"

read -rsp $'\nPremere invio per continuare...\n'

do_cmd "sudo himage pc7 ip addr add 172.25.2.1/24 dev eth0"		"Assegno l'IP 172.25.3.1 a PC7"
do_cmd "sudo himage pc8 ip addr add 172.25.2.128/24 dev eth0"		"Assegno l'IP 172.25.3.127 a PC8"

echo
