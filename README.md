# Delphix DevOps - Vagrant

This project shows how to build a simple Delphix demo environment using Vagrant from scratch.

The Vagrantfile provisions two virtual machines (source, target) with all Delphix specific pre-requisites, installs & configures MySQL and Postgres and deploys a simple open-source application that can be used to demonstrate the Delphix Engine.

## Prerequisites

To get started, a working installation of Vagrant and VirtualBox is required. Head over to their respective websites and get the latest versions of both tools.

* [Vagrant Downloads](https://www.vagrantup.com/downloads.html)
* [VirtualBox Downloads and Source](https://www.virtualbox.org/wiki/Downloads)

For details on how to get started with Vagrant and VirtualBox, [follow this tutorial](https://docs.vagrantup.com/v2/getting-started/index.html).

Vagrant allows the installation of plugins that add custom functionallity to the Vagrantfile. The demo uses the [vagrant-delphix](https://github.com/mickuehl/vagrant-delphix) plugin to register the two virtual machines as `environments` in Delphix.

In addition to the above tools, a running Delphix Engine is required:

* [Delphix Engine 4.3.4.x](https://download.delphix.com)

## Preparing the Delphix Engine

Download and configure the Delphix Engine as usual. Documentation on how to setup Delphix [can be found here](https://docs.delphix.com).

#### Network Configuration

The Delphix Engine is delivered and deployed as a VMware virtual appliance while the demo uses VirtualBox as hypervisor. It is important that all virtual machines share the same network on the host system i.e. that they are all 

* on the same subnet, and
* they share the same network interface.

On MacOS, the correct Network Adapter configuration for the Delphix Engine VMware image is **'Share with my Mac'**.

#### User Credentials

The demo assumes that there is a Delphix admin user `delphix_admin` with password `delphix`. Create this user if necessary.

## Preparing Vagrant

The demo uses a custom Vagrant plugin to interact with the Delphix Engine. This plugin must be installed first:

	vagrant plugin install vagrant-delphix

Verify that the plugin has been installed:

	vagrant plugin list

## Provisioning

#### Preparation

The Vagrantfile requires the following configuration parameters:

* DELPHIX_ENGINE_IP
* VMWARE_NETWORK_ADAPTER

The IP address is shown at the bottom of the Delphix Engine's console window. The network adapter however requires some digging in the VMware's log file :-)

Startup the Delphix Engine (DE) as usual. Once the the DE is running, write down the IP address of the DE, e.g. `172.16.138.157`. The VMware's current network adapter configuration is hidden in the VMware's log file, `vmware.log`. 

Look for a section like this:

	2015-11-13T07:33:31.700+01:00| vmx| I120: IP=127.0.0.1 (lo0)
	...
	...
	2015-11-13T07:33:31.700+01:00| vmx| I120: IP=172.16.138.1 (vmnet8)
 
Find the line that matches the DE's subnet (172.16.138.x). In this example the network adapter would be `vmnet8`.

#### Export Network Configuration Parameters

Open a console and export the above environment variables:

	export DELPHIX_ENGINE_IP=172.16.138.157
	export VMWARE_NETWORK_ADAPTER=vmnet8

**IMPORTANT**
Start vagrant from the same console or export these ENV variables in each console you use to start/run the demo !

#### Create the Demo VMs

The first time the demo is used, both environments (source, target) must be created. This can be done with one command

	vagrant up

or individually for each environment

	vagrant up source
	vagrant up target

Depending on the type and quality of internet connection, this can take some time ... 

## Demo

Once both environments have been created, some final manual steps are necessary to complete the setup.

#### User Credentials

In order to access the demo VMs, the following vagrant command can be used:

	vagrant ssh source
or
	vagrant ssh target

The following OS users are available:

* delphix / delphix
* vagrant / vagrant (sudoer)
* root / vagrant

#### Create a dSource

