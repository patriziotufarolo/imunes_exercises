msg="=> Configuro router4"
echo -e $Purple "cat << END_ROUTER_CONF | sudo himage router4 vtysh 1>/dev/null 2>/dev/null
configure terminal
interface eth0
ip address 10.0.4.4/24
exit
interface eth1
ip address 10.0.3.4/24
exit
router ospf
network 10.0.4.0/24 area 0
network 10.0.3.0/24 area 0
exit
exit
END_ROUTER_CONF
" $Color_Off

cat << END_ROUTER_CONF | sudo himage router4 vtysh 1>/dev/null 2>/dev/null
configure terminal
interface eth0
ip address 10.0.4.4/24
exit
interface eth1
ip address 10.0.3.4/24
exit
router ospf
network 10.0.4.0/24 area 0
network 10.0.3.0/24 area 0
exit
exit
END_ROUTER_CONF

echo -n $msg
ok_colorato_per_log ${#msg}
