# ansible-role-emacs
Ansible role to install emacs

how to run a specific role locally
export ANSIBLE_ROLES_PATH=/path/to/role
ansible localhost --module-name include_role --args name=<role_name>

** Why build emacs from sources?
for some unknown reasons ubuntu emacs distribution is built without treesitter
so to use treesitter you need to build from sources

** How to check what options emacs is built with

C-h v system-configuration-options
