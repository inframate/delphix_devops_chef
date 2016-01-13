#!/bin/bash
cd /tmp

# add the offical repo first
wget http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
sudo yum -y localinstall mysql-community-release-el6-5.noarch.rpm 

# install the server
sudo yum -y install mysql-community-server mysql-devel
