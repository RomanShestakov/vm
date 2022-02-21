#!/bin/bash -eux

# Install EPEL repository.
#rpm -ivh http://mirror.pnl.gov/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

# Install Ansible.
yum -y install python38 wget
yum clean all
#easy_install pip
python3 -m pip install ansible
