#!/usr/bin/env bash

export SETUP_HOME=/home/vagrant	
export REPO=https://github.com/mickuehl/delphix_devops_ffcrm.git
export BRANCH=release
export RAILS_ENV=development

cd $SETUP_HOME

if [ ! -d "$SETUP_HOME/app" ];then
	git clone $REPO --branch $BRANCH app
	cp database.yml app/config/database.yml
else
	git pull origin $BRANCH
fi

cd app

# setup the app
bundle install
bundle exec rake db:migrate

# just launch RAILS, test data will come from the PROD instance
rails s -b 0.0.0.0