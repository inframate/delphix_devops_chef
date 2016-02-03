
actions :install
default_action :install

attribute :engine_url, :kind_of => String, :default => "http://localhost"
attribute :username, :kind_of => String, :default => "delphix_admin"
attribute :password, :kind_of => String, :default => "delphix"

attribute :source_db, :kind_of => String, :required => true
attribute :target_env, :kind_of => String, :required => true
attribute :mount_base, :kind_of => String, :required => true
attribute :group_name, :kind_of => String, :required => true
attribute :port_number, :kind_of => Fixnum, :default => 5432

