#!/usr/bin/env bash

export SETUP_HOME=/home/vagrant	
export REPO=https://github.com/mickuehl/delphix_devops_ffcrm.git
export BRANCH=release
export RAILS_ENV=production

cd $SETUP_HOME

if [ ! -d "$SETUP_HOME/app" ];then
	git clone $REPO --branch $BRANCH app
	cp database_postgres.yml app/config/database.yml
else
	git pull origin $BRANCH
fi

cd app

# make sure bundler is installed
gem install bundler

# setup the app
bundle install
bundle exec rake db:create 
bundle exec rake db:migrate
bundle exec rake assets:precompile

# provision test data and launch RAILS
rake ffcrm:demo:load
#rake ffcrm:setup:admin USERNAME=delphix PASSWORD=delphix EMAIL=admin@delphix.local
#rails s -b 0.0.0.0
