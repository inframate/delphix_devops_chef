#
# Cookbook Name:: delphix
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

#
# make sure the delphix API gem is installed
#
chef_gem 'delphix_rb' do
  compile_time false
  #source '/home/vagrant/delphix.gem'
  action :install
end
