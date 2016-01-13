#!/bin/bash

# install PostgreSQL 9.2
sudo rpm -ivh http://yum.postgresql.org/9.2/redhat/rhel-6-x86_64/pgdg-redhat92-9.2-7.noarch.rpm
sudo yum -y install postgresql92-server postgresql-contrib postgresql-devel

# initialize the db
sudo service postgresql-9.2 initdb

# start and enable the server
sudo service postgresql-9.2 start
sudo chkconfig postgresql-9.2 on

sudo usermod -a -G wheel postgres