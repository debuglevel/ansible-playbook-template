# Development notes

## Pull changes from `debuglevel/ansible-template`

Add remote via `git remote add upstream https://github.com/debuglevel/ansible-template.git` and retrieve repository via `git pull upstream`. Merge into your current branch via `git merge upstream/master`.

TODO: This is doubled.

## Tests

### Lightweight tests / linting

* Lint YAML with `yamllint .`
* Check Ansible syntax with `ansible-playbook --syntax-check`
* Check for bad practices with `ansible-lint` or reformat with `ansible-lint --write`

### Molecule

#### Create a new role with tests

TODO

#### Create tests in an existing role

```bash
cd roles/vhosts
molecule init scenario -r vhosts -d docker # To create tests using the Ansible verifier
molecule init scenario -r vhosts -d docker --verifier-name testinfra testinfra # To create tests using the testinfra verifier (I assume it to be less cumbersome than writing tests using Ansible)
```

Note: Idempotence is tested with any verifier as it is part of the `idempotence` step. You therefore do not need an extra `ansible` verifier to ensure it.

#### Run all test scenarios

To not only run `default`, but just all scenarios:

```bash
cd roles/vhosts
molecule test --all
```

### Check and diff mode

Run `ansible-playbook` against a host with `--check` for read-only and `-diff` to display changes: <https://docs.ansible.com/ansible/latest/user_guide/playbooks_checkmode.html>

## Requirements

### Install Vagrant

We use Vagrant to start a fresh virtual machine image we can test our Ansible stuff against.

Install Vagrant according to <https://www.vagrantup.com/downloads>.

### Install hypervisor

To actually use Vagrant, you need a "provider".

- On Linux, use VirtualBox.
  - On Ubuntu, install it via: `sudo apt install virtualbox virtualbox-ext-pack`
- On Windows, use Hyper-V. Be aware that you must execute `vagrant` in a shell with administrator privileges.

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

### Lint with `yamllint`

- Install via `pip install yamllint`.
- Run `yamllint .` to check for YAML issues.

### Lint with `ansible-lint`

- Install via `pip install ansible-lint`.
- Run `ansible-lint playbook.yaml` to check a playbook for common issues.

See also <https://ansible-lint.readthedocs.io/en/latest/>

## Checking Python files

### Format with `black`

- Install via `pip install black`.
- Run `black .` to format Python files.

## Merge upstream git template

- This assumes you leave `master` alone and do all your work in a separate branch (e.g. `home`).
- Your `git remote` should contain the `upstream` remote:

```
origin  git@github.com:debuglevel/ansible-home.git (fetch)
origin  git@github.com:debuglevel/ansible-home.git (push)
upstream        git@github.com:debuglevel/ansible-template.git (fetch)
upstream        git@github.com:debuglevel/ansible-template.git (push)
```

- Get data from the upstream branches: `git fetch upstream`.
- You now have a `upstream/master` branch: `git branch -a`
- Checkout your `master` branch: `git checkout master`
- Merge `upstream/master` into your `master`: `git merge upstream/master`
- Checkout your development branch: `git checkout home`
- Merge `master`: `git merge master`
- You may have conflicts to resolve; fix them and commit the changes.

TL;DR: `git fetch upstream && git checkout master && git merge upstream/master && git checkout home && git merge master && echo "== Check for conflicts, resolve them, commit"`
