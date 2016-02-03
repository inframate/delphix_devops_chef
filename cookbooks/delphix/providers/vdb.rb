
#require 'delphix'

def whyrun_supported?
  true
end

action :install do
  require 'delphix'

  Chef::Log.info "Installing #{ @new_resource }"

  source_name = new_resource.source_db
  target_env = new_resource.target_env
  mount_base = new_resource.mount_base
  group_name = new_resource.group_name
  port_number = new_resource.port_number

  # set the DE url
  Delphix.url = new_resource.engine_url

  # authenticate the connection
  Delphix.authenticate!(new_resource.username, new_resource.password)

  # provision a new VDB
  vdb = Delphix::VDB.create new_resource.name, source_name, group_name, target_env, mount_base, port_number

end
