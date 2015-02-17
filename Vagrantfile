# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define :freeipa do |freeipa|
    freeipa.vm.box = "packer-empty"
    freeipa.vm.hostname = "freeipa.localdomain"

    freeipa.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", "1024"]
    end

    freeipa.vm.network :private_network, ip: "192.168.33.52"

    config.vm.provision "puppet" do |puppet|
       #puppet.manifests_path = "freeipa_puppet/manifests"
       puppet.manifest_file = "freeipa.pp" 
       puppet.module_path = "modules"
    end
  end


  config.vm.define :puppetmaster do |puppetmaster|
    puppetmaster.vm.box = "packer-puppetmaster"
    puppetmaster.vm.hostname = "puppetmaster.localdomain"

    puppetmaster.vm.provider "virtualbox" do |v|
      # make visible dns resolving from the virtualbox host machine
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", "1024"]
    end

    puppetmaster.vm.network :private_network, ip: "192.168.33.50"
  end

  config.vm.define :foreman do |foreman|
    foreman.vm.box = "packer-foreman"
    foreman.vm.hostname = "foreman.localdomain"

    foreman.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", "1024"]
    end

    foreman.vm.network :private_network, ip: "192.168.33.51"
    foreman.vm.network :forwarded_port, guest: 443, host: 8443
    foreman.vm.network :forwarded_port, guest: 80, host: 8080
  end

  config.vm.define :puppetdb do |puppetdb|
    puppetdb.vm.box = "packer-puppetdb"
    puppetdb.vm.box_url = "http://repository01.eur.nl/vboxes/puppetdb152.box"
    puppetdb.vm.hostname = "puppetdb.localdomain"

    puppetdb.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", "1024"]
    end

    puppetdb.vm.network :private_network, ip: "192.168.33.55"
    puppetdb.vm.network :forwarded_port, guest: 8081, host: 8081
  end


  config.vm.define :empty do |host|
    host.vm.box = "packer-empty"
    host.vm.hostname = "empty.localdomain"

    host.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", "512"]
    end

    host.vm.network :private_network, ip: "192.168.33.60"
    #host.vm.network :forwarded_port, guest: 8081, host: 8081
  end


end
