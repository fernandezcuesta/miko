#!/bin/bash

add_nfs_rules() {
    sudo iptables -I TRAFFIC -m tcp -p tcp --dport 111 -j ACCEPT -m comment --comment 'vagrant-NFS'
    sudo iptables -I TRAFFIC -m tcp -p tcp --dport 2049 -j ACCEPT -m comment --comment 'vagrant-NFS'
    sudo iptables -I TRAFFIC -m tcp -p tcp --dport 20048 -j ACCEPT -m comment --comment 'vagrant-NFS'
    sudo iptables -I TRAFFIC -m udp -p udp --dport 111 -j ACCEPT -m comment --comment 'vagrant-NFS'
    sudo iptables -I TRAFFIC -m udp -p udp --dport 2049 -j ACCEPT -m comment --comment 'vagrant NFS'
    sudo iptables -I TRAFFIC -m udp -p udp --dport 20048 -j ACCEPT -m comment --comment 'vagrant NFS'
}

rem_nfs_rules() {
    sudo iptables -D TRAFFIC -m tcp -p tcp --dport 111 -j ACCEPT -m comment --comment 'vagrant-NFS'
    sudo iptables -D TRAFFIC -m tcp -p tcp --dport 2049 -j ACCEPT -m comment --comment 'vagrant-NFS'
    sudo iptables -D TRAFFIC -m tcp -p tcp --dport 20048 -j ACCEPT -m comment --comment 'vagrant-NFS'
    sudo iptables -D TRAFFIC -m udp -p udp --dport 111 -j ACCEPT -m comment --comment 'vagrant-NFS'
    sudo iptables -D TRAFFIC -m udp -p udp --dport 2049 -j ACCEPT -m comment --comment 'vagrant NFS'
    sudo iptables -D TRAFFIC -m udp -p udp --dport 20048 -j ACCEPT -m comment --comment 'vagrant NFS'
}

if [ -z "$1" ] ; then
    rc="start"
else
    rc="$1"
fi
#
case "$rc" in
    start)
        add_nfs_rules
        ;;
    stop)
        rem_nfs_rules
        ;;
esac
