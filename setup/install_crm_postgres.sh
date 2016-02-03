#!/usr/bin/env bash

export REPO=https://github.com/mickuehl/delphix_devops_ffcrm.git
export BRANCH=release
export APP_HOME=$SETUP_HOME/app_postgres

cd $SETUP_HOME

if [ ! -d "$APP_HOME" ];then
	git clone $REPO --branch $BRANCH app_postgres
	cp app_postgres/config/database.de.postgres.yml app_postgres/config/database.yml
else
	cd $APP_HOME
	git pull origin $BRANCH
fi

chown -R delphix:delphix $APP_HOME

su - delphix
cd $SETUP_HOME/app_postgres

# install bundler first
sudo /usr/local/bin/gem install bundler

# make sure bundler is installed and all gems are available
bundle install --path $HOME/.gem/ruby/2.2.0
