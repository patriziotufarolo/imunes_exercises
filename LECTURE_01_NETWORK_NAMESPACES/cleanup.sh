#!/bin/bash
sudo ip netns del h1 1>/dev/null 2>/dev/null
sudo ip netns del h2 1>/dev/null 2>/dev/null

sudo ip link del s1-eth0 1>/dev/null 2>/dev/null

sudo ip link del s1-eth1 1>/dev/null 2>/dev/null

sudo ovs-vsctl del-br s1 1>/dev/null 2>/dev/null

if [ -f .pid ]; then
	sudo kill $(cat .pid);
	if ! pidof $(cat .pid); then
		rm .pid
	fi
fi
