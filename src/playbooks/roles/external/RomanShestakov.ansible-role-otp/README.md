# ansible-role-otp
Install erlang OTP from source

how to run a specific role locally
export ANSIBLE_ROLES_PATH=/path/to/role
ansible localhost --playbook-dir $ANSIBLE_ROLES_PATH --module-name include_role --args name=<role_name>

# possible to change into /home/romanshestakov/development and then run ansible
    
e.g
export ANSIBLE_ROLES_PATH=/home/romanshestakov/development;
sudo ansible localhost --playbook-dir $ANSIBLE_ROLES_PATH --module-name include_role --args name=ansible-role-otp
  
to install prerequisite dependencies libwxgtk use ansible-role-wxWidgets

