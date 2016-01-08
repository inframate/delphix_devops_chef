#!/usr/bin/env bash

export SETUP_HOME=/home/vagrant	
export RAILS_ENV=development

cd $SETUP_HOME/app

rails s -b 0.0.0.0
