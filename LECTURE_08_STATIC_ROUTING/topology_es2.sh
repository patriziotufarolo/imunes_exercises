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

do_cmd "sudo himage PC1Dep1 ip addr add 172.16.5.2/24 dev eth0" "Configuro l'ip 172.16.5.2/24 sull'interfaccia eth0 di PC1Dep1"
do_cmd "sudo himage PC2Dep1 ip addr add 172.16.5.3/24 dev eth0" "Configuro l'ip 172.16.5.3/24 sull'interfaccia eth0 di PC2Dep1"
do_cmd "sudo himage PC1Dep2 ip addr add 172.17.5.2/24 dev eth0" "Configuro l'ip 172.17.5.2/24 sull'interfaccia eth0 di PC1Dep2"
do_cmd "sudo himage PC2Dep2 ip addr add 172.17.5.3/24 dev eth0" "Configuro l'ip 172.17.5.3/24 sull'interfaccia eth0 di PC2Dep2"

do_cmd "sudo himage RouterDep1 ip addr add 172.16.5.1/24 dev eth0"  "Configuro l'ip 172.16.5.1/24 sull'interfaccia eth0 del router RouterDep1"
do_cmd "sudo himage RouterDep1 ip addr add 192.168.0.1/24 dev eth1" "Configuro l'ip 192.168.0.1/24 sull'interfaccia eth1 del router RouterDep1"

do_cmd "sudo himage RouterDep2 ip addr add 172.17.5.1/24 dev eth0"  "Configuro l'ip 172.17.5.1/24 sull'interfaccia eth0 del router RouterDep2"
do_cmd "sudo himage RouterDep2 ip addr add 192.168.0.2/24 dev eth1" "Configuro l'ip 192.168.0.2/24 sull'interfaccia eth1 del router RouterDep2"

for pc in PC1Dep1 PC2Dep1
do
	do_cmd "sudo himage $pc ip route add 172.17.5.0/24 via 172.16.5.1" "Configuro la rotta per far raggiungere la rete del dipartimento 2 al dipartimento 1 tramite RouterDep1"
done

for pc in PC1Dep2 PC2Dep2
do
	do_cmd "sudo himage $pc ip route add 172.16.5.0/24 via 172.17.5.1" "Configuro la rotta per far raggiungere la rete del dipartimento 1 al dipartimento 2 tramite RouterDep2"
done

do_cmd "sudo himage RouterDep1 ip route add 172.17.5.0/24 via 192.168.0.2" "Configuro la rotta per far raggiungere la rete del dipartimento 2 a RouterDep1"
do_cmd "sudo himage RouterDep2 ip route add 172.16.5.0/24 via 192.168.0.1" "Configuro la rotta per far raggiungere la rete del dipartimento 1 a RouterDep2"

do_cmd "sudo himage PC1Dep1 traceroute 172.17.5.1" "Traceroute DEP1=>DEP2"
do_cmd "sudo himage PC1Dep2 traceroute 172.16.5.1" "Traceroute DEP2=>DEP1"
