#!/usr/bin/env bash

# disable SELINUX
sudo setenforce 0

# shutdown iptables
sudo service iptables save
sudo service iptables stop
sudo chkconfig iptables off

# disable IPv6. NOTE: this due to some home-network quirks, nothing else ...
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1

# update the system first
sudo yum clean all
#sudo yum -y update

# make sure we are on a defined local
sudo localedef -v -c -i en_US -f UTF-8 en_US.UTF-8

# some basics
sudo yum -y install git unzip wget

# ntp
sudo yum -y install ntp
sudo chkconfig ntpd on
sudo ntpdate time.apple.com

# nfs
sudo yum -y install nfs-utils nfs-utils-lib
sudo chkconfig nfs on 
sudo service rpcbind restart
sudo service nfs restart

# get the development toolchain in place first
sudo yum groupinstall -y 'development tools'
