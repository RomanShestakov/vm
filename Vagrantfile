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
  config.vm.provider "docker" do |d|
    d.build_dir = "."
    d.has_ssh = true
    d.privileged = true
    d.volumes = ["/sys/fs/cgroup:/sys/fs/cgroup:rw"]
    # configure docker container
    d.create_args = [ '--cgroupns=host', '--cpuset-cpus=2', '--memory=4g' ]
  end

  # sync folders
  config.vm.synced_folder "/Users/romanshestakov/development", "/home/vagrant/development"

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
