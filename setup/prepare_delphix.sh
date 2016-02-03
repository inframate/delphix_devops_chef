#!/bin/bash

# create locations for app and Delphix engine toolkit
export SETUP_HOME=/home/delphix
export TOOLKIT_HOME=$SETUP_HOME/toolkit

sudo echo "# DELPHIX #" >> /etc/profile
sudo echo "export SETUP_HOME=/home/delphix" >> /etc/profile
sudo echo "export TOOLKIT_HOME=$SETUP_HOME/toolkit" >> /etc/profile

# create a delphix user 
useradd delphix
echo delphix | passwd delphix --stdin

# toolkit location
sudo mkdir -p $TOOLKIT_HOME
chown delphix:delphix $TOOLKIT_HOME
chmod 0770 $TOOLKIT_HOME

# add the user to wheel, i.e. sudoer group
sudo usermod -a -G wheel delphix
