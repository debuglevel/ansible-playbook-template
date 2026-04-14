# Ansible installation

To run this playbook, you will need Linux and Ansible.
Windows is not supported -- just use WSL if you are working on a Windows machine.

See also https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html.

## Python requirements

Ansible requires a Python version within a certain range (see requirements.txt).
https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#node-requirement-summary.

You may use `pyenv` (https://github.com/pyenv/pyenv) to manage multiple Python versions (or to install a newer one than the one provided by yout distribution):
```sh
pyenv install -l  # List available Python versions.
pyenv install 3.12.12  # Install a Python version.
pyenv shell 3.12.12  # Make THIS shell use the Python version.
python --version  # This should print the version.

python3 -m venv venv  # Create a venv.
source ./venv/bin/activate  # Activate the venv.
python --version  # This should print the version.
```

The venv should remember the Python version via `pyvenv.cfg`.

## Install Ansible via `pip` in a virtual environment

As always when you use Python:
Just use a virtual environment -- you will do yourself a favor.

```sh
# Install the venv module if necessary.
sudo apt-get update && sudo apt-get install -y python3-venv

# Create the virtual environment if it does not yet exist.
python3 -m venv venv

# Activate the virtual environment.
source venv/bin/activate

# Install dependencies.
pip3 install --upgrade pip  # Update pip, as old versions may cause errors
pip3 install --requirement requirements.txt
```

> [!CAUTION]
> In WSL, it might be better to not create the virtual environment under `/mnt/c` as it will be quite slow.

## Install Ansible dependencies

```sh
ansible-galaxy install --role-file requirements.yaml
```
