
#require 'delphix'

def whyrun_supported?
  true
end

action :install do
  require 'delphix'

  Chef::Log.info "Installing #{ @new_resource }"

  # set the DE url
  Delphix.url = new_resource.engine_url

  # authenticate the connection
  Delphix.authenticate!(new_resource.username, new_resource.password)

  group = Delphix::Group.create new_resource.name
end
