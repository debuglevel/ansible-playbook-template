# Ansible Playbook Template

This repository provides a template for Ansible projects.

## Install Ansible

You have to install `ansible` on a controller node. This just might just be a laptop with a recent version of Python. Python on Windows is not supported - just use WSL instead.

See also <https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html>

If you're lower than Python 3.8, install it: <https://askubuntu.com/questions/1197683/how-do-i-install-python-3-8-in-lubuntu-18-04>

### Install Ansible via `pip` in a virtual environment

You probably do yourself a favor if you install Ansible in a virtual environment:

```sh
sudo apt-get update && sudo apt-get install python3-venv # Maybe you need to install the venv module
#sudo apt-get install python3.8 python3.8-dev python3.8-distutils python3.8-venv # Install Python 3.8 if necessary (e.g. Ubuntu 18.04)
#python -m venv venv # Create a virtual environment if one does not already exist
python3.8 -m venv venv # ... if your default Python is too old (e.g. Ubuntu 18.04)
source venv/bin/activate # Activate the virtual environment
pip install --upgrade pip # Maybe update pip, as old versions may cause errors
python -m pip install ansible # Works without "python3.8" as we're in a virtual environment now
```

In WSL, it might be better to not create the virtual environment under `/mnt/c` as this is pretty slow.

### Install Ansible dependency stuff

```sh
ansible-galaxy install -r requirements.yaml
```

## Add all hosts to `known_hosts`

If you never connected to the hosts via SSH before, SSH will ask you to verify their fingerprint.

This snippet should do the trick, although it actually might be a security risk as it just accepts all SSH fingerprints:

```bash
cd supplemental
./print-inventory-hosts.py ../inventory | ./authenticate-hosts.sh
cd ..
```

## Authorize your SSH key on the hosts

Running `ansible` requires that your SSH key is in each `.ssh/authorized_keys` of the `ansible_user` of each host specified in `inventory`.

For now, this template does not automate copying it into this file.

## Use `ssh-agent`

Ansible will probably ask you all the time to provide your password. You can use `ssh-agent` to keep it unlocked in memory:

```sh
eval "$(ssh-agent -s)"
ssh-add # Use default identity file

# ssh-add ~/.ssh/id_ed25519 # Provide another identity file
```

## Use Ansible

- Use `--inventory=` to specify an inventory other than `/ect/ansible/hosts`.
- Use `--remote-user=user` to use the `user` user to connect via SSH (instead of the current user's username)
- Use `--verbose` to see detailed output from modules.
- Use `--e "letsencrypt_email=bla@bla.bla"` to override a variable. (But you should use the `inventory` file specify them.)
- Use `--ask-become-pass` to provide a sudo password.

- Simple test against all hosts

  - `ansible all --inventory=inventory -m ping`
  - `ansible all --inventory=inventory -a "/bin/echo hello"`

- If your path contains a space, you might need to use `python3.8 venv/bin/ansible` or `python3.8 "$(which ansible)"` instead, because the space seems to kill the shebang.

- "The ansible-playbook command offers several options for verification, including --check, --diff, --list-hosts, --list-tasks, and --syntax-check" (<https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html#ansible-lint>)
- "You can use ansible-lint for detailed, Ansible-specific feedback on your playbooks" (<https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html#ansible-lint>)

### Run this playbook

- Run the playbook via `ansible-playbook --inventory=inventory --ask-become-pass playbook.yaml` (or `python3.8 "$(which ansible-playbook)" --inventory=inventory --ask-become-pass playbook.yaml` if you've got a space in your path)
