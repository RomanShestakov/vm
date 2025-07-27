FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

# Install packages needed for SSH and interactive OS
RUN apt-get update && \
    yes | unminimize && \
    apt-get -y install \
        openssh-server \
        passwd \
        sudo \
        man-db \
        curl \
        wget \
        locales \
        vim-tiny && \
    apt-get -qq clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# # extra packages used for dev
# RUN apt-get update && \
#     yes | unminimize && \
#     apt-get -y install \
#     # gcc is part of build essensial
#     build-essential \
#     gdb \
#     # llvm
#     clang-11 \
#     clangd-11 \
#     llvm-11 \
#     llvm-11-dev \
#     llvm-11-tools \
#     autoconf \
#     automake \
#     #make \
#     rsync \
#     strace \
#     git \
#     tmux \
#     cmake \
#     pkg-config \
#     cmake-data \
#     # used by apt-get to install emacs
#     software-properties-common \
#     # gcc-9 \
#     # g++-9 \
#     libboost-all-dev \
#     # erlang \
#     # googletest \
#     libgtest-dev \
#     libwebsockets-dev \
#     libcurl4-openssl-dev \
#     libjsoncpp-dev \
#     libmbedtls-dev \
#     # zlib for ws compression
#     zlib1g-dev \
#     # package capture for tcp connection watch
#     libtins-dev \
#     libzmq3-dev \
#     flatbuffers-compiler \
#     libflatbuffers-dev

# # install emacs-28
# # https://ubuntuhandbook.org/index.php/2022/06/install-gnu-emacs-28-1-ubuntu-22-04-20-04/
# RUN add-apt-repository -y ppa:kelleyk/emacs && \
#   apt update && \
#   apt install -y emacs28-nativecomp

# # install erlang
# RUN wget -O- https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | sudo apt-key add - && \
# echo "deb https://packages.erlang-solutions.com/ubuntu focal contrib" | sudo tee /etc/apt/sources.list.d/erlang-solution.list && \
# apt update && \
# apt install -y erlang

# Set the locale
RUN locale-gen --no-purge en_US.UTF-8

# # create symlink for clangd
# RUN ln -s /usr/bin/clangd-11 /usr/bin/clangd

# Enable systemd (from Matthew Warman's mcwarman/vagrant-provider)
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*; \
    rm -f /etc/systemd/system/*.wants/*; \
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*; \
    rm -f /lib/systemd/system/anaconda.target.wants/*;

# Enable ssh for vagrant
RUN systemctl enable ssh.service;
EXPOSE 22

# Create the vagrant user
RUN useradd -m -G sudo -s /bin/bash vagrant && \
    echo "vagrant:vagrant" | chpasswd && \
    echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant && \
    chmod 440 /etc/sudoers.d/vagrant

# Establish ssh keys for vagrant
RUN mkdir -p /home/vagrant/.ssh; \
    chmod 700 /home/vagrant/.ssh
ADD https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub /home/vagrant/.ssh/authorized_keys
RUN chmod 600 /home/vagrant/.ssh/authorized_keys; \
    chown -R vagrant:vagrant /home/vagrant/.ssh

# Run the init daemon
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]



