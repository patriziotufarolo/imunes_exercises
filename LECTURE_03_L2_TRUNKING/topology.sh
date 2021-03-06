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

local EXPERIMENT;
EXPERIMENT="$(sudo himage -e pc1)"
do_cmd "sudo ovs-vsctl set port ${EXPERIMENT}-n0-e0 trunks=10,20" "Imposto il trunk delle VLAN con TAG 10 e 20 su n0-e0"
do_cmd "sudo ovs-vsctl set port ${EXPERIMENT}-n1-e0 trunks=10,20" "Imposto il trunk delle VLAN con TAG 10 e 20 su n1-e0"
do_cmd "sudo ovs-vsctl set port ${EXPERIMENT}-n0-e1 tag=10" "Imposto n0-e1 (PC1) su VLAN con TAG 10"
do_cmd "sudo ovs-vsctl set port ${EXPERIMENT}-n1-e2 tag=10" "Imposto n1-e2 (PC4) su VLAN con TAG 10"
do_cmd "sudo ovs-vsctl set port ${EXPERIMENT}-n0-e2 tag=20" "Imposto n0-e2 (PC2) su VLAN con TAG 20" 
do_cmd "sudo ovs-vsctl set port ${EXPERIMENT}-n1-e1 tag=20" "Imposto n1-e1 (PC3) su VLAN con TAG 20" 
do_cmd "sudo ovs-vsctl set port ${EXPERIMENT}-n1-e3 tag=30" "Imposto n1-e3 (PC5) su VLAN con TAG 30" 
do_cmd "sudo ovs-vsctl set port ${EXPERIMENT}-n1-e4 tag=30" "Imposto n1-e4 (PC6) su VLAN con TAG 30"
do_cmd "sudo ovs-vsctl show" "Stampo la configurazione"

do_cmd "sudo himage pc1 ping -c 5 10.0.0.23"							"=> Ping pc1 => pc4 COMUNICANO"
do_cmd "sudo himage pc1 ping -c 5 10.0.0.21"							"=> Ping pc1 => pc2 NON COMUNICANO"
do_cmd "sudo himage pc1 ping -c 5 10.0.0.22"							"=> Ping pc1 => pc3 NON COMUNICANO"
do_cmd "sudo himage pc2 ping -c 5 10.0.0.22"							"=> Ping pc2 => pc3 COMUNICANO"
do_cmd "sudo himage pc5 ping -c 5 10.0.0.25"							"=> Ping pc5 => pc6 COMUNICANO"
do_cmd "sudo himage pc5 ping -c 5 10.0.0.22"							"=> Ping pc5 => pc2 NON COMUNICANO"
do_cmd "sudo himage pc5 ping -c 5 10.0.0.23"							"=> Ping pc5 => pc4 NON COMUNICANO"
echo
