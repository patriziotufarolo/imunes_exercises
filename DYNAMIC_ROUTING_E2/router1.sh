msg="=> Configuro router1"
echo -e $Purple "cat << END_ROUTER_CONF | sudo himage router1 vtysh 1>/dev/null 2>/dev/null
configure terminal
interface eth0
ip address 10.0.0.1/24
exit
interface eth1
ip address 10.0.1.1/24
exit
interface eth2
ip address 192.168.0.254/24
exit
router ospf
network 192.168.0.0/24 area 0
network 10.0.0.0/24 area 0
network 10.0.1.0/24 area 0
exit
exit
END_ROUTER_CONF
" $Color_Off

cat << END_ROUTER_CONF | sudo himage router1 vtysh 1>/dev/null 2>/dev/null
configure terminal
interface eth0
ip address 10.0.0.1/24
exit
interface eth1
ip address 10.0.1.1/24
exit
interface eth2
ip address 192.168.0.254/24
exit
router ospf
network 192.168.0.0/24 area 0
network 10.0.0.0/24 area 0
network 10.0.1.0/24 area 0
exit
exit
END_ROUTER_CONF
echo -n $msg
ok_colorato_per_log ${#msg}
