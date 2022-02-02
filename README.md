# BigBlueButton Ansible Playbook

This ansible playbook installs BBB 2.4 on a host and a few other things:

* Install BBB via `bbb-install.sh`

## Install Ansible

You have to install ansible on your controller node. This just might just be a laptop with a recent version of Python. Windows seems not to be supported (probably just use WSL).

See also <https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html>

### Install ansible via `pip` in a virtual environment

You probably do yourself a favour if you install ansible in a virtual environment:

```sh
python -m venv venv  # Create a virtualenv if one does not already exist
source venv/bin/activate   # Activate the virtual environment
python -m pip install ansible
```

