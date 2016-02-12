# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'time'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# box sizing
VB_MEMORY=1024
VB_CPUS=1

# generic setup
DOMAIN_NAME="delphix.local"
SETUP_HOME='/home/delphix'

DELPHIX_ENGINE_IP ||= ENV['DELPHIX_ENGINE_IP'] || '172.16.138.157'
VMWARE_NETWORK_ADAPTER ||= ENV['VMWARE_NETWORK_ADAPTER'] || 'vmnet8'

IP_BASE = DELPHIX_ENGINE_IP.split('.')[0..2].join('.')

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant environment requires a box to build off of.
  config.vm.box = "ratchetcc/delphix"

  # size of the box
  config.vm.provider :virtualbox do |vb|
    vb.memory = VB_MEMORY
    vb.cpus = VB_CPUS
  end

  # disable typical plug-ins
  if Vagrant.has_plugin?("vagrant-hostmanager") then
    # manage /etc/hosts on both host & guests
    config.hostmanager.enabled = false # manage guest /etc/hosts
    config.hostmanager.manage_host = false # manage host's /etc/hosts
  end

  # update guest additions
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end

  # rebuild the /etc/hosts file ...
  config.vm.provision "shell", inline: "sudo rm /etc/hosts"

  # add the IP of the Delphix Engine etc. to each machine's /etc/hosts
  config.vm.provision "shell", inline: "sudo echo '#{DELPHIX_ENGINE_IP} de.delphix.local' >> /etc/hosts"
  config.vm.provision "shell", inline: "sudo echo '#{IP_BASE}.200 source.delphix.local' >> /etc/hosts"
  config.vm.provision "shell", inline: "sudo echo '#{IP_BASE}.210 target.delphix.local' >> /etc/hosts"

  #config the delphix provisioner
  config.delphix.enabled = true
  config.delphix.engine_url = "http://#{DELPHIX_ENGINE_IP}"
  config.delphix.engine_user = 'delphix_admin'
  config.delphix.engine_password = 'delphix'

  #
  # define the source instance
  #
  config.vm.define "source" do |node|
    # networking
    node_name = "source"
    public_ipv4 = "#{IP_BASE}.200"

    node.vm.hostname = "#{node_name}.#{DOMAIN_NAME}"
    node.vm.network "public_network", ip: public_ipv4, bridge: VMWARE_NETWORK_ADAPTER

    # add the IP of the db server ...
    config.vm.provision "shell", inline: "echo 'export DB_HOST=#{public_ipv4}' >> /etc/profile"
    config.vm.provision "shell", inline: "echo 'export MYSQL_DB_PORT=3306' >> /etc/profile"

    config.vm.provision "shell", inline: "sudo echo '127.0.0.1 localhost #{node_name}' >> /etc/hosts"
    config.vm.provision "shell", inline: "sudo echo '#{public_ipv4} db.delphix.local' >> /etc/hosts"

    # configure MySQL
    config.vm.provision "shell", path: "setup/setup_mysql.sh"

    # install the app
    config.vm.provision "shell", path: "setup/install_crm_mysql.sh"
    config.vm.provision "shell", path: "setup/setup_crm_mysql.sh"
    config.vm.provision "shell", path: "setup/setup_crm_scripts.sh"
    config.vm.provision "shell", inline: "chown -R delphix:delphix #{SETUP_HOME}/app_mysql" # fix permissions

    # configure the environment
    node.delphix.env_name = node_name
    node.delphix.env_ip = public_ipv4
    node.delphix.user = 'delphix'
    node.delphix.password = 'delphix'
    node.delphix.toolkit_path = '/home/delphix/toolkit'

    # register the environment in Delphix
    node.vm.provision :delphix, run: "always"

    # add Chef and add groups
    node.vm.provision "chef_solo" do |chef|
      chef.cookbooks_path = "cookbooks"

      chef.add_recipe "create_groups"
    end

  end

  #
  # define the target instance
  #
  config.vm.define "target" do |node|
    # networking
    node_name = "target"
    public_ipv4 = "#{IP_BASE}.210"

    node.vm.hostname = "#{node_name}.#{DOMAIN_NAME}"
    node.vm.network "public_network", ip: public_ipv4, bridge: VMWARE_NETWORK_ADAPTER

    # add the IP of the db server ...
    config.vm.provision "shell", inline: "echo 'export DB_HOST=#{public_ipv4}' >> /etc/profile"
    config.vm.provision "shell", inline: "echo 'export MYSQL_DB_PORT=5506' >> /etc/profile"
    config.vm.provision "shell", inline: "sudo echo '127.0.0.1 localhost #{node_name}' >> /etc/hosts"
    config.vm.provision "shell", inline: "sudo echo '#{public_ipv4} db.delphix.local' >> /etc/hosts"

    # configure MySQL
    config.vm.provision "shell", path: "setup/setup_mysql.sh"

    # install the app
    config.vm.provision "shell", path: "setup/install_crm_mysql.sh"
    config.vm.provision "shell", path: "setup/setup_crm_scripts.sh"
    config.vm.provision "shell", inline: "chown -R delphix:delphix #{SETUP_HOME}/app_mysql" # fix permissions

    # configure the environment
    node.delphix.env_name = node_name
    node.delphix.env_ip = public_ipv4
    node.delphix.user = 'delphix'
    node.delphix.password = 'delphix'
    node.delphix.toolkit_path = '/home/delphix/toolkit'

    # register the environment in Delphix
    node.vm.provision :delphix, run: "always"

    # add Chef and create a new VDB
    node.vm.provision "chef_solo" do |chef|
      chef.cookbooks_path = "cookbooks"
      #chef.log_level = :debug

      chef.add_recipe "create_vdb"
    end
  end

end
