
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

  # lookup the group reference
  group = Delphix::Group.list.lookup_by_name group_name

  # lookup the dSource reference
  dsource = Delphix::Database.list.lookup_by_name source_name

  # lookup the repository reference, i.e. the DB installation on the target Environment
  # discover all repositories
  repos = Delphix::Repository.list
  repos_on_target = repos.filter_by 'environment', target_env
  repos = repos_on_target.filter_by 'type', 'MySQLInstall'
  repository = repos.first # there could be more than one though !

  # provision a new VDB now that we have the basic details
  Delphix::VDB.create new_resource.name, dsource.reference, group.reference, repository.reference, mount_base, port_number

end
