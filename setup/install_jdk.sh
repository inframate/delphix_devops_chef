#!/bin/bash

# see https://www.digitalocean.com/community/tutorials/how-to-install-java-on-centos-and-fedora
# see http://tecadmin.net/steps-to-install-java-on-centos-5-6-or-rhel-5-6/

# setup Oracle JDK 7
cd /opt
sudo wget -q --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u75-b13/jdk-7u75-linux-x64.tar.gz"
sudo tar xzf jdk-7u75-linux-x64.tar.gz

cd /opt/jdk1.7.0_75
sudo alternatives --install /usr/bin/java java /opt/jdk1.7.0_75/bin/java 2
#sudo alternatives --config java
sudo alternatives --install /usr/bin/jar jar /opt/jdk1.7.0_75/bin/jar 2
sudo alternatives --install /usr/bin/javac javac /opt/jdk1.7.0_75/bin/javac 2
sudo alternatives --set jar /opt/jdk1.7.0_75/bin/jar
sudo alternatives --set javac /opt/jdk1.7.0_75/bin/javac 

sudo echo "# JDK7" >> /etc/profile
sudo echo "export JAVA_HOME=/opt/jdk1.7.0_75" >> /etc/profile
sudo echo "export PATH=$PATH:/opt/jdk1.7.0_75/bin:/opt/jdk1.7.0_75/jre/bin" >> /etc/profile
