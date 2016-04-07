#!/usr/bin/env bash

export REPO=https://github.com/mickuehl/delphix_devops_ffcrm.git
export BRANCH=release
export APP_HOME=/home/vagrant/app_mysql


if [ ! -d "$APP_HOME" ];then
	git clone $REPO --branch $BRANCH $APP_HOME
	cp app_mysql/config/database.de.mysql.yml app_mysql/config/database.yml
else
	cd $APP_HOME
	git pull origin $BRANCH
fi

chown -R vagrant:vagrant $APP_HOME
cd $APP_HOME

# install bundler first
sudo /usr/local/bin/gem install bundler
#--install-dir $SETUP_HOME/.gem/ruby/2.2.0

# make sure bundler is installed and all gems are available
bundle install
#--path $SETUP_HOME/.gem/ruby/2.2.0
#chown -R delphix:delphix $SETUP_HOME/.gem/ruby/2.2.0
