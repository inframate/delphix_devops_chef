#
# Cookbook Name:: devops_setup
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "delphix"

delphix_group "PRODUCTION" do
  engine_url "http://de.delphix.local"
end

delphix_group "DEV" do
  engine_url "http://de.delphix.local"
end
