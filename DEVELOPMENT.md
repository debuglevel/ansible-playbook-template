# Development notes

## Requirements

### Install Vagrant

We use Vagrant to start a fresh virtual machine image we can test our Ansible stuff against.

Install Vagrant according to <https://www.vagrantup.com/downloads>.

### Install hypervisor

To actually use Vagrant, you need a "provider". On Linux, use VirtualBox. On Ubuntu, install it via:

```sh
sudo apt install virtualbox virtualbox-ext-pack
```

On Windows, use Hyper-V. Be aware that you need to execute `vagrant` in shell with administrator privileges.

## Vagrant

### Start virtual machine

To boot up a virtual machine:

```sh
vagrant up
```

The `Vagrantfile` runs Ansible to test the playbook easily.

### Run provision again

To run the provision scripts again:

```sh
vagrant provision
```

### Destroy virtual machine

To shut down and destroy the virtual machine:

```sh
vagrant destroy
```

### Destroy and start virtual machine

To destroy and start the virtual machine again:

```sh
vagrant destroy -f && vagrant up
```