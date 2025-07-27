PROJECT = vm

update_external_roles:
	@echo updating role ... $<
	bin/role_update.sh

run_localhost: update_external_roles
	@echo run ansible for localhost... $<
	ANSIBLE_CONFIG=./config/local/ansible.cfg ansible-playbook src/playbooks/base.yml -i ./inventory/localhost_inventory.txt

run_ms01: update_external_roles
	@echo run ansible for ms01 ... $<
	ANSIBLE_CONFIG=./config/ms01/ansible.cfg ansible-playbook src/playbooks/base.yml -i ./inventory/ms01_inventory.txt

run_ping:
	@echo run ansible ping ms01... $<
	ANSIBLE_CONFIG=./config/ms01/ansible.cfg ansible -i ./inventory/ms01_inventory.txt ms01 -m ping
