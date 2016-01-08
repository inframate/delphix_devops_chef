# Delphix Vagrant

A basic Vagrantfile that provisions a CentOS server with PostgreSQL and MySQL to be used in Delphix demos.

## Prerequisites

To get started, a working installation of Vagrant and VirtualBox is required. Head over to their websites and get the latest versions of both tools.

* [Vagrant Downloads](https://www.vagrantup.com/downloads.html)
* [VirtualBox Downloads and Source](https://www.virtualbox.org/wiki/Downloads)

For details on how to get started with Vagrant and VirtualBox, [follow this tutorial](https://docs.vagrantup.com/v2/getting-started/index.html).

### Preparing the Delphix Engine

The Delphix Engine is delivered / deployed as a VMware virtual appliance while the demo environment uses VirtualBox as its hypervisor. It is important that all virtual machines share the same network on the host system i.e. that they are all 

* on the same subnet, and
* they share the same network interface.

On a Mac OS, the correct Network Adapter configuration of the Delphix Engine VMware image is **'Share with my Mac'**.

#### Network Configuration

Startup and configure the Delphix Engine (DE) as usual. Once the the DE is running, write down the IP address of the DE, e.g. `172.16.138.153`. In addition to the IP address we have to know which network adapter is used by VMware to run the Delphix engine. This information can be found in the VMware's log file, `vmware.log`. Look for a section like this:

	2015-11-13T07:33:31.700+01:00| vmx| I120: IP=127.0.0.1 (lo0)
	...
	
	2015-11-13T07:33:31.700+01:00| vmx| I120: IP=172.16.138.1 (vmnet8)
 
Find the line that matches the DE's subnet. In this example the network adapter would be `vmnet8`.

#### User Credentials

The demo assumes that there is a Delphix admin user `delphix_admin` with password `delphix`.

#### Exporting the Network Configuration

The Vagrantfile and the Chef recipies require the following configuration parameters:

* DELPHIX_ENGINE_IP
* VMWARE_NETWORK_ADAPTER

Open a console and export the above environment variables:

	export DELPHIX_ENGINE_IP=172.16.138.153
	export VMWARE_NETWORK_ADAPTER=vmnet8

Start vagrant from the same console or export these ENV variables in each console you use to start the demo !

## Provision the virtual machines

The DevOps demo currently uses three virtual machines:

* `source`: used to host the PostgeSQL staging database
* `target`: the **production** environment, with a full app stack (ruby, RAILS, & PostgreSQL)

