# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

$script = <<SCRIPT
echo 'installing ansible...'
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
echo 'installing git...'
sudo apt-get install git
echo 'getting dotfiles...'
git clone https://github.com/asmacdo/dotfiles.git ~/dotfiles
echo 'configuring dotfiles...'
./bin/dot
echo 'getting minijava...'
git clone https://github.com/mambocab/MiniJavaLLVM.git
echo 'DONE\n================================================================='
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "hashicorp/precise64"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Use VBoxManage to customize the VM to provide more memory. 
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  config.vm.provision "shell", inline: $script
  #
  # View the documentation for the provider you're using for more
  # information on available options.

end
