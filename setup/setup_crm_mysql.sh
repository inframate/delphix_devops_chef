#!/usr/bin/env bash

su - vagrant

export RAILS_ENV=production

cd /home/vagrant/app_mysql

# setup the app
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake assets:precompile

# provision test data
bundle exec rake ffcrm:demo:load
bundle exec rake ffcrm:setup:admin USERNAME=delphix PASSWORD=delphix EMAIL=admin@delphix.local
