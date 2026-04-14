# Usage

- [How to prepare the hosts/managed nodes](<Hosts preparations>)
- [How to prepare the controller](<Controller preparation>) (where Ansible is running)

## Run this playbook

```shell
ANSIBLE_CONFIG="./ansible.cfg" ansible-playbook --inventory=inventory.yaml playbook.yaml

# In case there is a space in the path.
ANSIBLE_CONFIG="./ansible.cfg" python3 "$(which ansible-playbook)" --inventory=inventory.yaml playbook.yaml

# If you want to save a colored log.
ANSIBLE_FORCE_COLOR=True ansible-playbook ... | tee -a ansible.color.log
less -R ansible.color.log
# The `iliazeus.vscode-ansi` VSCode extension provides a Command `ANSI Text: Open Preview` to see the log as shown in the console.
```

- [Deployment](Deployment)
- [Tags](Tags)

## Useful commands

```sh
# Check on which hosts `unattended-upgrades` is installed.
ansible all --inventory=inventory.yaml -a "bash -c 'apt list unattended-upgrades 2> /dev/null | grep unatt'"

# Create a random hex string with 32 characters.
openssl rand -hex 16
```
