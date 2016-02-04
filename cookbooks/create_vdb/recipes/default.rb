#
# Cookbook Name:: devops_dev
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "delphix"

delphix_vdb "CRM_DEV" do

  engine_url "http://de.delphix.local"

  source_db 'CRM_SOURCE'
  target_env 'MYSQL_INSTALL-2' #'target'
  group_name 'DEV'
  mount_base '/home/delphix/toolkit/V/mysql'
  port_number 5506

  action :install
end
