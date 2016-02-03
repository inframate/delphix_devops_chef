
#require 'delphix'

def whyrun_supported?
  true
end

action :install do
  require 'delphix'

  Chef::Log.info "Installing #{ @new_resource }"

  source_db = new_resource.source_db
  target_env = new_resource.target_env
  mount_base = new_resource.mount_base
  group_name = new_resource.group_name
  port_numer = new_resource.port_number

  # set the DE url
  Delphix.url = new_resource.engine_url

  # authenticate the connection
  Delphix.authenticate!(new_resource.username, new_resource.password)

  # add new VDB to group 'DEV'
  #groups = Delphix.groups
  #group = Delphix.lookup_by_name groups, group_name

  # find the staging db
  #environments = Delphix.environments
  #environment = Delphix.lookup_by_name environments, target_env

  #repositories = Delphix.repositories environment.reference
  #repository_ref = Delphix.lookup_by_type repositories, 'PgSQLInstall' # assuming that there is only 1 PSQL installation !!

  # find the source DB
  #databases = Delphix.databases
  #source_db = Delphix.lookup_by_name databases, source_db

  # provision a new VDB
  #Delphix.provision_psql new_resource.name, repository_ref[0].reference, group.reference, mount_base, port_numer, source_db.reference

end
