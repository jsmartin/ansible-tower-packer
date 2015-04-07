# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.network "private_network", ip: "10.42.0.42"
  config.vm.hostname = "tower"
  config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
  end
end
