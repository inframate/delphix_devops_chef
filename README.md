# Delphix Vagrant

This project shows how to build a simple Delphix demo environment from scratch using Vagrant.

The Vagrantfile provisions two virtual machines (source, target) with all Delphix specific pre-requisites, installs & configures MySQL and Postgres and deploys a simple open-source application that can be used to demonstrate the Delphix Engine.

## Prerequisites

To get started, a working installation of Vagrant and VirtualBox is required. Head over to their websites and get the latest versions of both tools.

* [Vagrant Downloads](https://www.vagrantup.com/downloads.html)
* [VirtualBox Downloads and Source](https://www.virtualbox.org/wiki/Downloads)

For details on how to get started with Vagrant and VirtualBox, [follow this tutorial](https://docs.vagrantup.com/v2/getting-started/index.html).

Vagrant allows the installation of plugins that add custom functionallity to the Vagrantfile. The demo uses the [vagrant-delphix](https://github.com/mickuehl/vagrant-delphix) plugin to register the two virtual machines as `environments` in Delphix.

In addition to the above tools, a running Delphix Engine is required:

* [Delphix Engine 4.3.4.x](https://download.delphix.com)

## Preparing the Delphix Engine

### Network Configuration

### User Credentials

## Preparing the Vagrantfile


## Reference

