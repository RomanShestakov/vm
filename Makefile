PROJECT = vm

update_external_roles:
	@echo updating role ... $<
	bin/role_update.sh

lint: update_external_roles
	@echo run lint ... $<
	ANSIBLE_CONFIG=./config/local/ansible.cfg ansible-playbook src/playbooks/base.yml --syntax-check

run_localhost: update_external_roles lint
	@echo run ansible for localhost... $<
	ANSIBLE_CONFIG=./config/local/ansible.cfg ansible-playbook src/playbooks/base.yml -i ./inventory/localhost_inventory.txt

run_ms01: update_external_roles
	@echo run ansible for ms01 ... $<
	ANSIBLE_CONFIG=./config/ms01/ansible.cfg ansible-playbook src/playbooks/base.yml -i ./inventory/ms01_inventory.txt

run_ping:
	@echo run ansible ping ms01... $<
	ANSIBLE_CONFIG=./config/ms01/ansible.cfg ansible -i ./inventory/ms01_inventory.txt ms01 -m ping

run_adhoc:
	@echo run ansible ad-hoc local... $<
# can drop -m command - it is dfault module
# ANSIBLE_CONFIG=./config/local/nsible.cfg ansible -i ./inventory/local_inventory.txt localhost -a "free -h"
	ANSIBLE_CONFIG=./config/local/ansible.cfg ansible -i ./inventory/local_inventory.txt localhost -m command -a "free -h"

run_vagrant_destroy:
	@echo run vagrant destroy... $<
	 sudo vagrant destroy

run_vagrant_docker: run_vagrant_destroy
	@echo run vagrant docker... $<
# sudo vagrant destroy
#vagrant plugin install vagrant-env
	sudo vagrant up --provider=docker
