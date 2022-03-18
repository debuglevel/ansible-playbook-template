# BigBlueButton Ansible Playbook

This ansible playbook installs BigBlueButton 2.4 on a host and a few other things:

* Install BBB via `bbb-install.sh`
* ...

## Install Ansible

You have to install ansible on your controller node. This just might just be a laptop with a recent version of Python. Windows seems not to be supported - just use WSL instead.

See also <https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html>

If you're lower than Python 3.8, install it: <https://askubuntu.com/questions/1197683/how-do-i-install-python-3-8-in-lubuntu-18-04>

### Install ansible via `pip` in a virtual environment

You probably do yourself a favor if you install ansible in a virtual environment:

```sh
#python -m venv venv # Create a virtualenv if one does not already exist
python3.8 -m venv venv # ... if your default Python is too old (e.g. Ubuntu 18.04)
source venv/bin/activate # Activate the virtual environment
pip install --upgrade pip # Maybe update pip, as old versions may cause errors
python -m pip install ansible # Works without "python3.8" as we're in a venv
```

### Install ansible dependency stuff

```sh
ansible-galaxy install -r requirements.yaml
```

## Use Ansible

* Use `-i inventory` to use `inventory` as jour inventory file.
* Use `-u user` to use the `user` user to connect via SSH (instead of the current user's username)
* Use `--verbose` to see detailed output from modules.
* Use `--e "letsencrypt_email=bla@bla.bla"` to override variables. (But you should use the `inventory` file specify them.)
* Use `--ask-become-pass` to provide a sudo password.

* Simple test against all hosts
  * `ansible all -i inventory -m ping`
  * `ansible all -i inventory -a "/bin/echo hello"`

* If your path contains a space, you might need to use `python3.8 venv/bin/ansible` or `python3.8 "$(which ansible)"` instead, because the space seems to kill the shebang.

* "The ansible-playbook command offers several options for verification, including --check, --diff, --list-hosts, --list-tasks, and --syntax-check" (<https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html#ansible-lint>)
* "You can use ansible-lint for detailed, Ansible-specific feedback on your playbooks" (<https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html#ansible-lint>)

### Run this playbook

* Run the playbook via `ansible-playbook -i inventory --ask-become-pass playbook.yaml` (or `python3.8 "$(which ansible-playbook)" -i inventory --ask-become-pass playbook.yaml` if you've got a space in your path)
