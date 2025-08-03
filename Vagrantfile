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
        bin/role_update.sh
    fi
")

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "docker" do |docker|
    # ***************************************
    # option 1 -
    # build using the existing image from the docker hub
    # to build this image and load it to the docker hub
    # see README
    # docker.image = "rshestakov/vm:6.0"
    # ***************************************
    # option 2 -
    # build docker container locally from scratch
    # and them run ansible to install all the required packages
    # build using local Dockerfile
    #docker.build_dir = "./provision/centos8"
    #docker.build_dir = "./provision/ubuntu"
    docker.build_dir = "./docker/ubuntu"
    # ***************************************
    docker.has_ssh = true
    docker.privileged = true
    docker.remains_running = true
    docker.volumes = ["/sys/fs/cgroup:/sys/fs/cgroup:rw"]
    # configure docker container
    #docker.create_args = [ '--cgroupns=host', '--cpuset-cpus=1', '--memory=6g' ]
    docker.create_args = [ '--cgroupns=host', '--memory=6g' ]
  end

  # don't insert new private key
  config.ssh.insert_key = false

  #config.vm.network :forwarded_port, guest: 8000, host: 8000
  #config.vm.network :forwarded_port, guest: 8001, host: 8001

  # location of the private key
  config.ssh.private_key_path = ['~/.vagrant.d/insecure_private_key']

  # sync folders - depending on where playbook is run
  shared_folder_path_linux = "/home/romanshestakov/development"
  shared_folder_path_mac = "/home/romanshestakov/development"
  
  # Check if the directory exists before attempting to sync
  if File.directory?( shared_folder_path_linux )
    config.vm.synced_folder shared_folder_path_linux, "/home/vagrant/development"
  elsif File.directory?( shared_folder_path_mac )
    config.vm.synced_folder shared_folder_path_mac, "/home/vagrant/development"
  else
    puts "WARNING!: The shared folder source '#{shared_folder_path_linux}' and '#{shared_folder_path_mac}' does not exist and will be skipped."
  end
  
  # part of Option2 - when docker container is built locally
  # run ansible
  config.vm.provision "ansible" do |ansible|
    ansible.compatibility_mode="2.0"
    ansible.sudo = true
    ansible.verbose = "vvv"
    ansible.playbook = 'src/playbooks/base.yml'
    ansible.config_file = './config/docker/ansible.cfg' 
    ansible.host_key_checking = false
    # ansible.extra_vars = {
    # }
  end
end







