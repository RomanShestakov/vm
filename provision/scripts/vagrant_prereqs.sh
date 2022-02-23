#!/bin/bash

# Install dependencies for vagrant
yum -y install openssh-server
yum -y install openssh-clients
yum -y install passwd
yum -y install sudo
yum clean all

systemctl enable sshd.service

# Add vagrant stuff
useradd vagrant
echo "vagrant" | passwd --stdin vagrant
usermod -a -G wheel vagrant

mkdir /home/vagrant/.ssh

# Allow vagrant to login
cd ~vagrant
ls -la
pwd
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > .ssh/authorized_keys
chown -R vagrant:vagrant .ssh
chmod 0700 .ssh
chmod 0600 .ssh/authorized_keys

##########
ln -sf \
    /usr/share/zoneinfo/UTC \
    /etc/localtime \
  && echo "NETWORKING=yes" \
    > /etc/sysconfig/network \
  && sed -i \
    -e 's~^#PermitRootLogin yes~PermitRootLogin no~g' \
    -e 's~^PasswordAuthentication yes~PasswordAuthentication no~g' \
    -e 's~^#UseDNS yes~UseDNS no~g' \
    /etc/ssh/sshd_config \
  && sed -i \
    -e 's~^# %wheel\tALL=(ALL)\tALL~%wheel\tALL=(ALL) ALL~g' \
    -e 's~\(.*\) requiretty$~#\1requiretty~' \
  /etc/sudoers \
  && echo "vagrant ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/vagrant_user

  echo "finished the script"

  cat /etc/sysconfig/network
  cat /etc/ssh/sshd_config
  cat /etc/sudoers.d/vagrant_user
