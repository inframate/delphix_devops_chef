#!/usr/bin/env bash

su - delphix

export RAILS_ENV=production

cd $SETUP_HOME/app_mysql

# setup the app
bundle exec rake db:create 
bundle exec rake db:migrate
bundle exec rake assets:precompile

# provision test data
rake ffcrm:setup:admin USERNAME=delphix PASSWORD=delphix EMAIL=admin@delphix.local
#rake ffcrm:demo:load