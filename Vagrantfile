# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Use Ubuntu 14.04 Trusty Tahr 64-bit as our operating system
  config.vm.box = "debian/jessie64"

  # Configurate the virtual machine to use 2GB of RAM
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end 

  config.vm.provision :shell, path: "install-rvm.sh", args: "stable"
  config.vm.provision :shell, path: "install-ruby.sh", args: "2.3.0"

   config.vm.provision "capistrano" do |cap|
    cap.capfile = '../Group_app/Capfile'
    cap.rubystring = 'ruby 2.3.0p0' 
    cap.stage = 'testing'
    cap.tasks = ['rvm:install'] 
    cap.environment = { 'ENV_VAR' => 'VALUE' } 
    cap.hiera_root = '../hiera' 
  end

  # Forward the Rails server default port to the host
  config.vm.network :forwarded_port, guest: 3000, host: 3000

  # Use Chef Solo to provision our virtual machine
end
