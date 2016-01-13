#!/bin/bash
cd $SETUP_HOME

# write our own /etc/my.cnf
sudo rm /etc/my.cnf

sudo echo "[mysqld]" >> /etc/my.cnf
sudo echo "datadir=/var/lib/mysql" >> /etc/my.cnf
sudo echo "socket=/var/lib/mysql/mysql.sock" >> /etc/my.cnf
sudo echo "log-bin=mysql-bin" >> /etc/my.cnf
sudo echo "symbolic-links=0" >> /etc/my.cnf
sudo echo "sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES" >> /etc/my.cnf
sudo echo "server-id=1" >> /etc/my.cnf
sudo echo "bind-address=$DB_HOST" >> /etc/my.cnf

sudo echo "" >> /etc/my.cnf
sudo echo "[mysqld_safe]" >> /etc/my.cnf
sudo echo "log-error=/var/log/mysqld.log" >> /etc/my.cnf
sudo echo "pid-file=/var/run/mysqld/mysqld.pid" >> /etc/my.cnf

# enable automatic (re-)start
sudo chkconfig mysqld on
sudo service mysqld restart

# add a DB user 'delphix' with all grants and remote access permissions
#mysql -hdb.delphix.local -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'delphix'@'%' IDENTIFIED BY 'delphix' WITH GRANT OPTION;"
mysql -hdb.delphix.local -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'delphix'@'localhost' IDENTIFIED BY 'delphix' WITH GRANT OPTION;"
mysql -hdb.delphix.local -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'delphix'@'db.delphix.local' IDENTIFIED BY 'delphix' WITH GRANT OPTION;"
mysql -hdb.delphix.local -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'delphix'@'source.delphix.local' IDENTIFIED BY 'delphix' WITH GRANT OPTION;"
mysql -hdb.delphix.local -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'delphix'@'target.delphix.local' IDENTIFIED BY 'delphix' WITH GRANT OPTION;"

# create an admin user for replication etc
mysql -hdb.delphix.local -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'delphix_admin'@'localhost' IDENTIFIED BY 'delphix' WITH GRANT OPTION;"
mysql -hdb.delphix.local -uroot -e "GRANT REPLICATION SLAVE ON *.* TO 'delphix_admin'@'localhost';"
mysql -hdb.delphix.local -uroot -e "GRANT SELECT, RELOAD, REPLICATION CLIENT, SHOW VIEW, EVENT, TRIGGER ON *.* TO 'delphix_admin'@'localhost';"

mysql -hdb.delphix.local -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'delphix_admin'@'db.delphix.local' IDENTIFIED BY 'delphix' WITH GRANT OPTION;"
mysql -hdb.delphix.local -uroot -e "GRANT REPLICATION SLAVE ON *.* TO 'delphix_admin'@'db.delphix.local';"
mysql -hdb.delphix.local -uroot -e "GRANT SELECT, RELOAD, REPLICATION CLIENT, SHOW VIEW, EVENT, TRIGGER ON *.* TO 'delphix_admin'@'db.delphix.local';"

mysql -hdb.delphix.local -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'delphix_admin'@'de.delphix.local' IDENTIFIED BY 'delphix' WITH GRANT OPTION;"
mysql -hdb.delphix.local -uroot -e "GRANT REPLICATION SLAVE ON *.* TO 'delphix_admin'@'de.delphix.local';"
mysql -hdb.delphix.local -uroot -e "GRANT SELECT, RELOAD, REPLICATION CLIENT, SHOW VIEW, EVENT, TRIGGER ON *.* TO 'delphix_admin'@'de.delphix.local';"

mysql -hdb.delphix.local -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'delphix_admin'@'source.delphix.local' IDENTIFIED BY 'delphix' WITH GRANT OPTION;"
mysql -hdb.delphix.local -uroot -e "GRANT REPLICATION SLAVE ON *.* TO 'delphix_admin'@'source.delphix.local';"
mysql -hdb.delphix.local -uroot -e "GRANT SELECT, RELOAD, REPLICATION CLIENT, SHOW VIEW, EVENT, TRIGGER ON *.* TO 'delphix_admin'@'source.delphix.local';"

mysql -hdb.delphix.local -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'delphix_admin'@'target.delphix.local' IDENTIFIED BY 'delphix' WITH GRANT OPTION;"
mysql -hdb.delphix.local -uroot -e "GRANT REPLICATION SLAVE ON *.* TO 'delphix_admin'@'target.delphix.local';"
mysql -hdb.delphix.local -uroot -e "GRANT SELECT, RELOAD, REPLICATION CLIENT, SHOW VIEW, EVENT, TRIGGER ON *.* TO 'delphix_admin'@'target.delphix.local';"

# see http://www.cyberciti.biz/tips/how-do-i-enable-remote-access-to-mysql-database-server.html
# SELECT * from information_schema.user_privileges;