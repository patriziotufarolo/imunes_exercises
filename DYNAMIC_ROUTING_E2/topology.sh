#!/bin/bash
Color_Off='\e[0m' 
Purple='\e[0;35m'
ok_colorato_per_log() {
        RED=$(tput setaf 1)
        GREEN=$(tput setaf 2)
        NORMAL=$(tput sgr0)
        LENMSG="$1"
        let COL=$(tput cols)-${LENMSG}
        printf "%${COL}s%s%s%s%s%s" "$NORMAL" "[" "$GREEN" "OK" "$NORMAL" "]"
        echo ---
}
sudo -i exit





cmd="sudo himage pc1 ip addr add 192.168.0.1/24 dev eth0"
msg="=> Impostato IP 192.168.0.1/24 sull'host pc1"
echo -e $Purple $cmd $Color_Off
echo -n $msg
$cmd 2>/dev/null 1>/dev/null
ok_colorato_per_log ${#msg}

cmd="sudo himage pc2 ip addr add 192.168.1.1/24 dev eth0"
msg="=> Impostato IP 192.168.1.1/24 sull'host pc2"
echo -e $Purple $cmd $Color_Off
echo -n $msg
$cmd 2>/dev/null 1>/dev/null
ok_colorato_per_log ${#msg}

cmd="sudo himage pc1 ip route add 0.0.0.0/0 via 192.168.0.254"
msg="Aggiungo route di default su pc1"
echo -e $Purple $cmd $Color_Off
$cmd 1>/dev/null 2>/dev/null
echo -n $msg
ok_colorato_per_log ${#msg}

cmd="sudo himage pc2 ip route add 0.0.0.0/0 via 192.168.1.254"
msg="Aggiungo route di default su pc1"
echo -e $Purple $cmd $Color_Off 
$cmd 1>/dev/null 2>/dev/null
echo -n $msg
ok_colorato_per_log ${#msg}

for router in $(seq 1 5); do

    cmd="sudo himage router${router} sed -i -e s/zebra=no/zebra=yes/g -e s/ospfd=no/ospfd=yes/g /etc/quagga/daemons"
    msg="Abilito Zebra e OSPFd su router${router}"
    echo -e $Purple $cmd $Color_Off
    echo -n $msg
    $cmd 1>/dev/null 2>/dev/null
    ok_colorato_per_log ${#msg}


    cmd="sudo himage router${router} service quagga restart"
    msg="Riavvio demone quagga su router${router}"
    echo -e $Purple $cmd $Color_Off
    echo -n $msg
    $cmd 2>/dev/null 1>/dev/null
    ok_colorato_per_log ${#msg}

    source router${router}.sh

done
