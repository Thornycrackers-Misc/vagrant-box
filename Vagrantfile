# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/trusty64"

  # Sync folder
  config.vm.synced_folder "salt/srv/", "/srv/salt/"

  # Provision via salt
  config.vm.provision :salt do |salt|
      salt.minion_config = "salt/minion"
      salt.run_highstate = true
      salt.verbose = true
      salt.colorize = true
  end

  config.vm.provider :virtualbox do |virtualbox|
    # Helps OSX provision multiple cores
    virtualbox.customize ["modifyvm", :id, "--ioapic", "on"  ]
    # allocate 8GB RAM
    virtualbox.customize ["modifyvm", :id, "--memory", "8192"] 
    # allocate max 50% CPU
    virtualbox.customize ["modifyvm", :id, "--cpuexecutioncap", "75"]
    # Give acces to multiple cpus
    virtualbox.customize ["modifyvm", :id, "--cpus", "8"]
  end

  # Needed for NFS
  config.vm.network :private_network, ip: "10.11.12.13"
  # Use NFS for shared folders, much better performance BUT doesn't work on windows
  config.vm.synced_folder '.', '/vagrant', type: "nfs", mount_options: ['actimeo=2']

  # Let Vagrant get an ip to allow ssh
  config.vm.network :public_network
  
  # Setting a default interface 
  #config.vm.network "public_network", bridge: 'en0: Wi-Fi (AirPort)'
  
end
