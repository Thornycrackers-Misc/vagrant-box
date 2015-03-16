# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  # config.vm.box = "ubuntu/precise32"
  config.vm.box = "ubuntu/trusty32"
 
  # Forward ports from the vagrant box to local host
  config.vm.network :forwarded_port, host: 9000, guest: 9000
  config.vm.network :forwarded_port, host: 8881, guest: 80
  config.vm.network :forwarded_port, host: 3306, guest: 3306

  # Provision via script
  #config.vm.provision :shell, path: "bootstrap.sh"

  # Provision via puppet
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.options = ['--verbose']
    puppet.module_path = "puppet/modules"
  end

  config.vm.provider :virtualbox do |virtualbox|
    # Helps OSX provision multiple cores
    virtualbox.customize ["modifyvm", :id, "--ioapic", "on"  ]
    # allocate 4096 mb RAM
    virtualbox.customize ["modifyvm", :id, "--memory", "4096"] 
    # allocate max 50% CPU
    virtualbox.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    # Give acces to multiple cpus
    virtualbox.customize ["modifyvm", :id, "--cpus", "8"]
  end

  # Needed for NFS
  config.vm.network :private_network, ip: "10.11.12.13"
  # Use NFS for shared folders, much better performance BUT doesn't work on windows
  #config.vm.synced_folder '~/Sites', '/vagrant', nfs: true
  #config.vm.synced_folder '~/Sites', '/vagrant', type: "rsync"
  config.vm.synced_folder '~/Sites', '/vagrant', type: "nfs", mount_options: ['actimeo=2']

  # Let Vagrant get an ip to allow ssh
  config.vm.network :public_network
end
