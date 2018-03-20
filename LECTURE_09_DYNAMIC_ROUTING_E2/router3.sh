do_cmd "cat << END_ROUTER_CONF | sudo himage router3 vtysh 1>/dev/null 2>/dev/null
configure terminal
interface eth0
ip address 10.0.3.3/24
exit
interface eth1
ip address 10.0.1.3/24
exit
router ospf
network 10.0.3.0/24 area 0
network 10.0.1.0/24 area 0
exit
exit
END_ROUTER_CONF" "=> Configuro router3"
