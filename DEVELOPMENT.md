# Development notes

## Requirements

### Install Vagrant

We use Vagrant to start a fresh virtual machine image we can test our Ansible stuff against.

Install Vagrant according to <https://www.vagrantup.com/downloads>.

### Install hypervisor

To actually use Vagrant, you need a "provider".
* On Linux, use VirtualBox.
  * On Ubuntu, install it via: `sudo apt install virtualbox virtualbox-ext-pack`
* On Windows, use Hyper-V. Be aware that you must execute `vagrant` in a shell with administrator privileges.

## Vagrant

### Start virtual machine and run Ansible playbook

Create and boot a virtual machine via `vagrant up`. This will use `Vagrantfile` which in turn runs Ansible to test (or at least execute) the playbook.

### Run provision (i.e. Ansible playbook) again

Run the provision scripts again via `vagrant provision` without recreating the virtual machine.

### Destroy virtual machine

Shut down and destroy the virtual machine via `vagrant destroy`.

### Destroy and start virtual machine

Destroy and start the virtual machine again via `vagrant destroy -f && vagrant up`.

## Checking Ansible playbooks

### `yamllint`

* Run `yamllint playbook.yaml` to check for YAML issues.

### `ansible-lint`

* Install via `pip install ansible-lint` and run `ansible-lint playbook.yaml` to lint a playbook.

See also <https://ansible-lint.readthedocs.io/en/latest/>