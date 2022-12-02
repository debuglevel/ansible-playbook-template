# Ansible Playbook for BigBlueButton

This Ansible playbook deploys a BigBlueButton environment:

* BigBlueButton via `bbb-install.sh` on a "throw-away" backend host (i.e. has no persistence and could be resetted and deployed every night).
* Greenlight as frontend on a persistent host; access via <https://HOST/> and <https://HOST/b>.
* [greenstatic/bigbluebutton-monitoring](https://github.com/greenstatic/bigbluebutton-monitoring) as Prometheus exporter on the backend host on <https://HOST/bigbluebutton-monitoring/>.
* [greenstatic/bigbluebutton-exporter](https://bigbluebutton-exporter.greenstatic.dev/) as Prometheus exporter on the backend host on <https://HOST/bigbluebutton-exporter/metrics>.
* [prometheus/node_exporter](https://github.com/prometheus/node_exporter) as Prometheus exporter on every host on <https://HOST/node-exporter/metrics>.

## Install Ansible

You have to install Ansible on a controller node (i.e. the host you want Ansible run from; most likely your workstation or a CI/CD container).
This might just be a laptop with a recent version of Python.
Python on Windows is not supported - just use WSL instead.

See also <https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html>

If you're lower than Python 3.8, install it: <https://askubuntu.com/questions/1197683/how-do-i-install-python-3-8-in-lubuntu-18-04>

### Install Ansible via `pip` in a virtual environment

You probably do yourself a favor if you install Ansible in a virtual environment:

```sh
sudo apt-get update && sudo apt-get install -f python3-venv # Maybe you need to install the venv module
#sudo apt-get install python3.8 python3.8-dev python3.8-distutils python3.8-venv # Install Python 3.8 if necessary (e.g. Ubuntu 18.04)
#python -m venv venv # Create a virtual environment if one does not already exist
python3.8 -m venv venv # ... if your default Python is too old (e.g. Ubuntu 18.04)
source venv/bin/activate # Activate the virtual environment
pip install --upgrade pip # Maybe update pip, as old versions may cause errors
pip install ansible # Works without "python3.8" as we're in a virtual environment now
pip install molecule[docker] pytest-testinfra yamllint ansible-lint # If you want to run linting/tests
```

In WSL, it might be better to not create the virtual environment under `/mnt/c` as this is pretty slow.

### Install Ansible dependencies

```sh
ansible-galaxy install -r requirements.yaml
```

## Add all hosts to `~/.ssh/known_hosts`

If you never connected to the hosts via SSH before, SSH will ask you to verify their fingerprint.

This snippet should do the trick, although it actually might be a security risk as it just accepts all SSH fingerprints:

```bash
for i in inventory*; do
  echo "== Processing $i..."
  supplemental/print-inventory-hosts.py $i | supplemental/authenticate-hosts.sh
done
```

## Authorize your SSH key on the hosts

Running `ansible` requires that your SSH key is in each `.ssh/authorized_keys` of the `ansible_user` of each host specified in `inventory`.

For now, this template does not automate copying it into this file.

## Use `ssh-agent`

Ansible will probably ask you all the time to provide your password.
You should use `ssh-agent` to keep it unlocked in memory:

```sh
eval "$(ssh-agent -s)"
ssh-add # Use default identity file

# ssh-add ~/.ssh/id_ed25519 # Provide another identity file
```

## Use Ansible

* Use `--inventory=` to specify an inventory other than `/ect/ansible/hosts`.
Multiple inventories are allowed.
Use `--inventory=localhost,` to specify a host without an inventory.
* Use `--remote-user=user` to use the `user` user to connect via SSH (instead of the current user's username).
But you should probably configure `ansible_user` this in your inventory instead.
* Use `--verbose` to see detailed output from modules.
* Use `--e "letsencrypt_email=bla@bla.bla"` to override a variable.
For a more permanent solution you should use the `*_vars` files.
* Use `--ask-become-pass` to let Ansible ask for the sudo password.

### CAVEATs

If your path contains a space, you might need to use `python3.8 venv/bin/ansible` or `python3.8 "$(which ansible)"` instead, because the space seems to kill the shebang.

`ansible.cfg` will not be used if the current directory is world-writable.
As this is not too easy to change on WSL, you can just set ENV `ANSIBLE_CONFIG="./ansible.cfg"`.

### Test configuration

To test your configuration, issue a simple command to all hosts in `inventory`:

```sh
ansible all --inventory=inventory -m ping
ansible all --inventory=inventory -a "/bin/echo hello"
```

### Run this playbook

* Run the playbook via `ANSIBLE_CONFIG="./ansible.cfg" ansible-playbook --inventory=inventory --ask-become-pass playbook.yaml`.
  * Use `ANSIBLE_CONFIG="./ansible.cfg" python3.8 "$(which ansible-playbook)" --inventory=inventory --ask-become-pass playbook.yaml` if you've got a space in your path.
