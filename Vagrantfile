# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

$root_script = <<SCRIPT
echo 'updating apt...'
sudo apt-get update
echo 'installing git, vim, openjdk7, and ant...'
sudo apt-get install -y git vim openjdk-7-jdk ant
SCRIPT

$user_script = <<SCRIPT
echo 'getting minijava...'
cd /vagrant/
mkdir source
cd source
git clone https://github.com/mambocab/MiniJavaLLVM.git
cd MiniJavaLLVM
ant ubuntu_depends
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/trusty64"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Use VBoxManage to customize the VM to provide more memory. 
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end
  #require 'time'
  #timezone = 'Etc/GMT' + ((Time.zone_offset(Time.now.zone)/60)/60).to_s
  #config.vm.provision :shell, :inline => "if [ $(grep -c UTC /etc/timezone) -gt 0 ]; then echo \"#{timezone}\" | # #sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata; fi"




  config.vm.provision "shell", inline: $root_script
  config.vm.provision "shell", inline: $user_script, privileged: false
  #
  # View the documentation for the provider you're using for more
  # information on available options.

end
