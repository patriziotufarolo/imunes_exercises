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

sudo hcp root-server/db.rootdns root:/etc/bind/db.rootdns
sudo hcp root-server/named.conf.local root:/etc/bind/named.conf.local

sudo hcp com/db.com dnsCom:/etc/bind/db.com
sudo hcp com/named.conf.local dnsCom:/etc/bind/named.conf.local

sudo hcp net/db.net dnsNet:/etc/bind/db.net
sudo hcp net/named.conf.local dnsNet:/etc/bind/named.conf.local

sudo hcp org/db.org dnsOrg:/etc/bind/db.org
sudo hcp org/named.conf.local dnsOrg:/etc/bind/named.conf.local


sudo hcp prova.com/db.prova.com provaDotCom:/etc/bind/db.prova.com
sudo hcp prova.com/named.conf.local provaDotCom:/etc/bind/named.conf.local

sudo hcp prova.net/db.prova.net provaDotNet:/etc/bind/db.prova.net
sudo hcp prova.net/named.conf.local provaDotNet:/etc/bind/named.conf.local

sudo hcp prova.org/db.prova.org provaDotOrg:/etc/bind/db.prova.org
sudo hcp prova.org/named.conf.local provaDotOrg:/etc/bind/named.conf.local

sudo himage root named
sudo himage dnsCom named
sudo himage dnsNet named
sudo himage dnsOrg named
sudo himage provaDotOrg named 
sudo himage provaDotNet named
sudo himage provaDotCom named


for server in $(seq 1 6); do
echo "nameserver 10.0.0.10" | sudo himage pc$server tee /etc/resolv.conf
done

