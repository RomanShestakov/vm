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

# Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
#   # All Vagrant configuration is done here. The most common configuration
#   # options are documented and commented below. For a complete reference,
#   # please see the online documentation at vagrantup.com.

#   config.vm.define "vagrant1" do |vagrant1|
#     vagrant1.vm.box = "virtualbox-centos7"
#     vagrant1.vm.host_name = "base1.local"
#     vagrant1.vm.network :private_network, ip: "192.168.56.2"
#     vagrant1.vm.network "forwarded_port", guest: 80, host: 8080
#     vagrant1.vm.network "forwarded_port", guest: 8888, host: 8888
#     vagrant1.vm.network "forwarded_port", id: "ssh", guest: 22, host: 2222

#     vagrant1.vm.provider "virtualbox" do |pmv|
#       pmv.memory = 4096
#       pmv.cpus = 4
#     end
#   end

#   # config.vm.define "vagrant2" do |vagrant2|
#   #   vagrant2.vm.box = "virtualbox-centos7"
#   #   vagrant2.vm.host_name = "base2.local"
#   #   vagrant2.vm.network :private_network, ip: "192.168.111.223"
#   #   vagrant2.vm.network "forwarded_port", guest: 80, host: 8081
#   #   vagrant2.vm.network "forwarded_port", guest: 8888, host: 8889
#   # end

#     # sync folders
#   config.vm.synced_folder "/Users/romanshestakov/development", "/home/vagrant/development"

#   # # Enable SSH agent forwarding for github
#   # # https://coderwall.com/p/p3bj2a
#   # config.ssh.username = 'vagrant'
#   # config.ssh.private_key_path = [ '~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa' ]
#   config.ssh.forward_agent = true
#   config.ssh.insert_key = false
#   config.vm.boot_timeout = 900

#   # run ansible
#   config.vm.provision "ansible" do |ansible|
#     ansible.sudo = true
#     ansible.verbose = "vvv"
#     ansible.playbook = 'provision/ansible/playbooks/vm.yml'
#     ansible.host_key_checking = false
#   end
# end



#ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "docker" do |d|
    d.build_dir = "."
    d.has_ssh = true
    d.privileged = true
    d.create_args = ["-v", "/sys/fs/cgroup:/sys/fs/cgroup:ro"]
  end

  # config.vm.host_name = "base1.local"
  # config.vm.network :private_network, ip: "192.168.111.222"
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # config.vm.network "forwarded_port", guest: 8888, host: 8888
  # config.vm.network "forwarded_port", id: "ssh", guest: 22, host: 2222

  # run ansible
  config.vm.provision "ansible" do |ansible|
    ansible.compatibility_mode="2.0"
    ansible.sudo = true
    ansible.verbose = "vvv"
    #ansible.playbook = 'provision/ansible/playbooks/vm.yml'
    ansible.playbook = 'provision/ansible/playbooks/base.yml'
    ansible.host_key_checking = false
  end
end
