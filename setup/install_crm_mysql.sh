#!/usr/bin/env bash

export REPO=https://github.com/mickuehl/delphix_devops_ffcrm.git
export BRANCH=release

cd $SETUP_HOME

if [ ! -d "$SETUP_HOME/app_mysql" ];then
	git clone $REPO --branch $BRANCH app_mysql
	cp app_mysql/config/database.de.mysql.yml app_mysql/config/database.yml
else
	cd $SETUP_HOME/app_mysql
	git pull origin $BRANCH
fi

chown -R delphix:delphix $SETUP_HOME/app_mysql

su - delphix
cd $SETUP_HOME/app_mysql

# make sure bundler is installed and all gems are available
bundle install
