# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'time'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# box sizing
VB_MEMORY=1024
VB_CPUS=1

# version of the delphix gem
DELPHIX_GEM_VERSION='0.5.0'

# generic setup
DOMAIN_NAME="delphix.local"
SETUP_HOME='/home/vagrant'

DELPHIX_ENGINE_IP ||= ENV['DELPHIX_ENGINE_IP'] || '172.16.138.157'
VMWARE_NETWORK_ADAPTER ||= ENV['VMWARE_NETWORK_ADAPTER'] || 'vmnet8'

IP_BASE = DELPHIX_ENGINE_IP.split('.')[0..2].join('.')

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  # Every Vagrant environment requires a box to build off of.
  config.vm.box = "bento/centos-6.7"  
  
  if Vagrant.has_plugin?("vagrant-hostmanager") then
    # manage /etc/hosts on both host and guests
    config.hostmanager.enabled = false # manage guest /etc/hosts
    config.hostmanager.manage_host = false # manage host's /etc/hosts
  end
  
  # update guest additions
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end
  
  # size of the box
  config.vm.provider :virtualbox do |vb|
    vb.memory = VB_MEMORY
    vb.cpus = VB_CPUS
  end
  
  # common provisioning tasks, used on all environments
  config.vm.provision "shell", path: "setup/bootstrap.sh"
  config.vm.provision "shell", path: "setup/postgres.sh"
  config.vm.provision "shell", path: "setup/mysql.sh"
  config.vm.provision "shell", path: "setup/delphix.sh"
  
  # add a JDK
  config.vm.provision "shell", inline: "sudo yum -y install java-1.7.0-openjdk"
  
  # install ruby and upload the delphix gem
  config.vm.provision "shell", path: "setup/ruby.sh"
  config.vm.provision "file", source: "pkg/delphix-#{DELPHIX_GEM_VERSION}.gem", destination: "#{SETUP_HOME}/delphix.gem"
  # RAILS pre-requisites
  config.vm.provision "shell", path: "setup/rails_prereqisites.sh"
  
  # add the IP of the Delphix Engine etc. to each machine's /etc/hosts
  config.vm.provision "shell", inline: "sudo echo '#{DELPHIX_ENGINE_IP} de.delphix.local' >> /etc/hosts"
  config.vm.provision "shell", inline: "sudo echo '#{IP_BASE}.200 source.delphix.local' >> /etc/hosts"
  config.vm.provision "shell", inline: "sudo echo '#{IP_BASE}.210 target.delphix.local' >> /etc/hosts"
  
  # db ports
  config.vm.provision "shell", inline: "sudo echo 'export DB_PORT_PGS=5432' >> /etc/profile"
  config.vm.provision "shell", inline: "sudo echo 'export DB_PORT_MYSQL=5506' >> /etc/profile"
  
  # add some files to the environments
  config.vm.provision "file", source: "scripts/ffcrm_prod.sh", destination: "#{SETUP_HOME}/ffcrm_prod.sh"
  config.vm.provision "file", source: "scripts/ffcrm_dev.sh", destination: "#{SETUP_HOME}/ffcrm_dev.sh"
  config.vm.provision "file", source: "conf/database_postgres.yml", destination: "#{SETUP_HOME}/database_postgres.yml"
  config.vm.provision "file", source: "conf/database_mysql.yml", destination: "#{SETUP_HOME}/database_mysql.yml"
  
  # define the source instance
  config.vm.define "source" do |node|
    # networking
    node_name = "source"
    public_ipv4 = "#{IP_BASE}.200"
  
    node.vm.hostname = "#{node_name}.#{DOMAIN_NAME}"
    node.vm.network "public_network", ip: public_ipv4, bridge: VMWARE_NETWORK_ADAPTER
        
    # add the IP of the db servers
    config.vm.provision "shell", inline: "sudo echo 'export DB_HOST=#{public_ipv4}' >> /etc/profile"
    
  end
  
  # define the target instance
  config.vm.define "target" do |node|
    # networking
    node_name = "target"
    public_ipv4 = "#{IP_BASE}.210"
  
    node.vm.hostname = "#{node_name}.#{DOMAIN_NAME}"
    node.vm.network "public_network", ip: public_ipv4, bridge: VMWARE_NETWORK_ADAPTER
        
    # add the IP of the db servers
    config.vm.provision "shell", inline: "echo 'export DB_HOST=#{public_ipv4}' >> /etc/profile"
    
  end
  
end
