# Usage

This Ansible playbook deploys a TEMPLATE environment:

* ...

- [Hosts preparations](<Hosts preparations>)
- [Controller preparation](<Controller preparation>)

## Run this playbook

* Run the playbook via `ANSIBLE_CONFIG="./ansible.cfg" ansible-playbook --inventory=inventory.yaml --ask-vault-pass playbook.yaml`.
  * Use `ANSIBLE_CONFIG="./ansible.cfg" python3.10 "$(which ansible-playbook)" --inventory=inventory.yaml --ask-vault-pass playbook.yaml` if you’ve got a space in your path.

- [Deployment](Deployment)
- [Tags](Tags)

## Useful commands

```sh
# Check on which hosts unattended-upgrades is installed.
ansible all --inventory=inventory.yaml -a "bash -c 'apt list unattended-upgrades 2> /dev/null | grep unatt'"

# Create a random hex string with 32 characters.
openssl rand -hex 16
```
