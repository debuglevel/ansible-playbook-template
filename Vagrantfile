# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.provision "shell", inline: "echo Hello from general provisioning!"

    config.vm.provider "virtualbox" do |vbox|
        vbox.memory = "1024"
    end

    config.vm.define "backend01" do |backend01|
        backend01.vm.box = "ubuntu/xenial64"
        backend01.vm.network "private_network", ip: "10.0.1.1"

        backend01.vm.provision "shell", inline: "echo Hello from specific provisioning!"
    end

    config.vm.define "backend02" do |backend02|
        backend02.vm.box = "ubuntu/xenial64"
        backend02.vm.network "private_network", ip: "10.0.1.2"

        backend02.vm.provision "shell", inline: "echo Hello from specific provisioning!"
    end

    config.vm.define "greenlight01" do |greenlight01|
        greenlight01.vm.box = "ubuntu/xenial64"
        greenlight01.vm.network "private_network", ip: "10.0.2.1"

        greenlight01.vm.provision "shell", inline: "echo Hello from specific provisioning!"
    end

    config.vm.define "loadbalancer01" do |loadbalancer01|
        loadbalancer01.vm.box = "ubuntu/bionic64"
        loadbalancer01.vm.network "private_network", ip: "10.0.3.1"

        loadbalancer01.vm.provision "shell", inline: "echo Hello from specific provisioning!"
    end

    config.vm.define "storage01" do |storage01|
        storage01.vm.box = "ubuntu/bionic64"
        storage01.vm.network "private_network", ip: "10.0.4.1"

        storage01.vm.provision "shell", inline: "echo Hello from specific provisioning!"
    end
end
