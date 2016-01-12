#!/bin/bash

# get the development toolchain in place first
sudo yum groupinstall -y 'development tools'

# install ruby via rvm
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh

rvm requirements
rvm install 2.2.4
rvm use 2.2.4 --default

# THIS IS VERY BAD, BUT I WANT TO AVOID ACCESS RIGHTS CONFLICTS ... !
chmod -R 777 /usr/local/rvm

cd $SETUP_HOME