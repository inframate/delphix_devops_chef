# Delphix Vagrant

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

## Reference

