# -*- mode: ruby -*-
# vi: set ft=ruby :

# some of the scrips are re-used from this github project:
# https://github.com/ANXS/erlang

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# run shell provision on the host machine to download external roles for Ansible
# https://github.com/enginyoyen/ansible-best-practises
system("
    if [ #{ARGV[0]} = 'up' ]; then
        echo 'You are doing vagrant up and can execute your script'
        ./provision/scripts/role_update.sh
    fi
")

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  # config.vm.box = "centos/7"
  # config.vm.box = "precise64"
  # config.vm.box = "virtualbox-ubuntu1404"
  config.vm.box = "virtualbox-centos7"
  config.vm.hostname = "base.local"
  config.vm.network :private_network, ip: "192.168.111.222"
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # sync folders
  config.vm.synced_folder "/Users/romanshestakov/development/unix_programming", "/home/vagrant/unix_programming"


  # # Enable SSH agent forwarding for github
  # # https://coderwall.com/p/p3bj2a
  # config.ssh.username = 'vagrant'
  # config.ssh.private_key_path = [ '~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa' ]
  config.ssh.forward_agent = true
  config.ssh.insert_key = false

  # run ansible
  config.vm.provision "ansible" do |ansible|
    ansible.sudo = true
    ansible.verbose = "vvv"
    # ansible.playbook = 'provision/ansible/playbooks/full.yml'
    ansible.playbook = 'provision/ansible/playbooks/vm.yml'
    # ansible.playbook = 'provision/ansible/playbooks/experiment.yml'
    ansible.inventory_path = 'provision/ansible/playbooks/production.ini'
    ansible.host_key_checking = false
  end
end
