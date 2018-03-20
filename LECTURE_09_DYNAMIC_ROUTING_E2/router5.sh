
do_cmd "cat << END_ROUTER_CONF | sudo himage router5 vtysh 1>/dev/null 2>/dev/null
configure terminal
interface eth0
ip address 10.0.2.5/24
exit
interface eth1
ip address 10.0.4.5/24
exit
interface eth2
ip address 192.168.1.254/24
exit
router ospf
network 192.168.1.0/24 area 0
network 10.0.2.0/24 area 0
network 10.0.4.0/24 area 0
exit
exit
END_ROUTER_CONF" "=> Configuro router5"
