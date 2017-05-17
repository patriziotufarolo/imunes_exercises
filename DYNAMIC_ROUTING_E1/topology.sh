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

cmd="sudo himage pc1 ip addr add 172.16.5.2/24 dev eth0"
msg="=> Impostato IP 172.16.5.2/24 sull'host pc1"
echo -e $Purple $cmd $Color_Off
echo -n $msg
$cmd 2>/dev/null 1>/dev/null
ok_colorato_per_log ${#msg}

cmd="sudo himage pc2 ip addr add 172.16.5.3/24 dev eth0"
msg="=> Impostato IP 172.16.5.3/24 sull'host pc2"
echo -e $Purple $cmd $Color_Off
echo -n $msg
$cmd 2>/dev/null 1>/dev/null
ok_colorato_per_log ${#msg}

cmd="sudo himage pc1 ip route add 0.0.0.0/0 via 172.16.5.1"
msg="Aggiungo route di default su pc1 e pc2"
echo -e $Purple $cmd $Color_Off
$cmd 1>/dev/null 2>/dev/null
cmd="sudo himage pc2 ip route add 0.0.0.0/0 via 172.16.5.1"
echo $cmd 
$cmd 1>/dev/null 2>/dev/null
echo -n $msg
ok_colorato_per_log ${#msg}

cmd="sudo himage pc3 ip addr add 172.17.5.2/24 dev eth0"
msg="=> Impostato IP 172.17.5.2/24 sull'host pc3"
echo -e $Purple $cmd $Color_Off
echo -n $msg
$cmd 2>/dev/null 1>/dev/null
ok_colorato_per_log ${#msg}

cmd="sudo himage pc4 ip addr add 172.17.5.3/24 dev eth0"
msg="=> Impostato IP 172.17.5.3/24 sull'host pc4"
echo -e $Purple $cmd $Color_Off
echo -n $msg
$cmd 2>/dev/null 1>/dev/null
ok_colorato_per_log ${#msg}


cmd="sudo himage pc3 ip route add 0.0.0.0/0 via 172.17.5.1"
msg="Aggiungo route di default su pc3 e pc4"
echo -e $Purple $cmd $Color_Off
$cmd
cmd="sudo himage pc4 ip route add 0.0.0.0/0 via 172.17.5.1"
echo -e $Purple $cmd $Color_Off
$cmd
echo -n $msg
ok_colorato_per_log ${#msg}





cmd="sudo himage router1 sed -i -e s/zebra=no/zebra=yes/g -e s/ospfd=no/ospfd=yes/g /etc/quagga/daemons"
msg="Abilito Zebra e OSPFd su router1"
echo -e $Purple $cmd $Color_Off
echo -n $msg
$cmd 1>/dev/null 2>/dev/null
ok_colorato_per_log ${#msg}


cmd="sudo himage router1 service quagga restart"
msg="Riavvio demone quagga su router1"
echo -e $Purple $cmd $Color_Off
echo -n $msg
$cmd 2>/dev/null 1>/dev/null
ok_colorato_per_log ${#msg}


cmd="sudo himage router2 sed -i -e s/zebra=no/zebra=yes/g -e s/ospfd=no/ospfd=yes/g /etc/quagga/daemons"
msg="Abilito Zebra e OSPFd su router2"
echo -e $Purple $cmd $Color_Off
echo -n $msg
$cmd 1>/dev/null 2>/dev/null
ok_colorato_per_log ${#msg}

cmd="sudo himage router2 service quagga restart"
msg="Riavvio demone quagga su router2"
echo -e $Purple $cmd $Color_Off
echo -n $msg
$cmd 2>/dev/null 1>/dev/null
ok_colorato_per_log ${#msg}




msg="=> Configuro router1"
echo -e $Purple "cat << END_ROUTER_CONF | sudo himage router1 vtysh 1>/dev/null 2>/dev/null
configure terminal
interface eth0
ip address 172.16.5.1/24
exit
interface eth1
ip address 192.168.0.1/24
exit
router ospf
network 192.168.0.0/24 area 0
network 172.16.5.0/24 area 0
exit
exit
END_ROUTER_CONF
" $Color_Off
cat << END_ROUTER_CONF | sudo himage router1 vtysh 1>/dev/null 2>/dev/null
configure terminal
interface eth0
ip address 172.16.5.1/24
exit
interface eth1
ip address 192.168.0.1/24
exit
router ospf
network 192.168.0.0/24 area 0
network 172.16.5.0/24 area 0
exit
exit
END_ROUTER_CONF

echo -n $msg
ok_colorato_per_log ${#msg}


msg="=> Configuro router2"
echo -e $Purple "cat << END_ROUTER_CONF | sudo himage router2 vtysh 1>/dev/null 2>/dev/null
configure terminal
interface eth0
ip address 172.17.5.1/24
exit
interface eth1
ip address 192.168.0.2/24
exit
router ospf
network 192.168.0.0/24 area 0
network 172.16.5.0/24 area 0
exit
exit
END_ROUTER_CONF
" $Color_Off
cat << END_ROUTER_CONF | sudo himage router2 vtysh 1>/dev/null 2>/dev/null
configure terminal
interface eth0
ip address 172.17.5.1/24
exit
interface eth1
ip address 192.168.0.2/24
exit
router ospf
network 192.168.0.0/24 area 0
network 172.17.5.0/24 area 0
exit
exit
END_ROUTER_CONF

echo -n $msg
ok_colorato_per_log ${#msg}
