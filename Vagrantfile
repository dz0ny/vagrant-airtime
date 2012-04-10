# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "oneiric64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://images.ansolabs.com/vagrant/oneiric64.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :hostonly, "192.168.1.77"

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
  # config.vm.network :bridged

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port 80, 8080
  config.vm.forward_port 8000, 8000
  config.vm.forward_port 3000, 3000
  config.vm.forward_port 3001, 3001

  config.vm.customize ["modifyvm", :id, "--memory", "458"]
  config.vm.share_folder "airtime-devel", "/opt/airtime","./airtime-devel"
  config.vm.host_name = "airtime-devel"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe "airtime"
  end

end
