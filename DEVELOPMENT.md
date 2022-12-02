# Development notes

## Update subtrees

Some git repositories might be included as subtrees.
Use `update-git-subtrees.sh` to update them.

## Merge upstream changes from `debuglevel/ansible-template`

This template is based on `debuglevel/ansible-template`.

You can merge upstream changes into your current branch:

1. Add remote via `git remote add upstream https://github.com/debuglevel/ansible-template.git`.
2. Retrieve the repository via `git pull upstream`.
3. Merge into the current branch via `git merge upstream/master`.

## Merge upstream git template (alternative/additional notes)

* This assumes you leave `master` alone and do all your work in a separate branch (e.g. `home`).
* Your `git remote` should contain the `upstream` remote:

```plain
origin          git@github.com:debuglevel/ansible-home.git (fetch)
origin          git@github.com:debuglevel/ansible-home.git (push)
upstream        git@github.com:debuglevel/ansible-template.git (fetch)
upstream        git@github.com:debuglevel/ansible-template.git (push)
```

* Get data from the upstream branches: `git fetch upstream`.
* You now have a `upstream/master` branch: `git branch -a`
* Checkout your `master` branch: `git checkout master`
* Merge `upstream/master` into your `master`: `git merge upstream/master`
* Checkout your development branch: `git checkout home`
* Merge `master`: `git merge master`
* You may have conflicts to resolve; fix them and commit the changes.

TL;DR: `git fetch upstream && git checkout master && git merge upstream/master && git checkout home && git merge master && echo "== Check for conflicts, resolve them, commit"`

## Tests, Checks, Linting et cetera

Ansible stuff can be linted, verified, checked, tested in various ways.

### YAML linting with `yamllint`

Install via `pip install yamllint`.
Lint the plain YAML with `yamllint .`.
It is configured in `.yamllint`.

### Ansible linting with `ansible-lint`

Install via `pip install ansible-lint`.

* Run `ansible-lint playbook.yaml` (or just `ansible-lint`) to check a playbook for common issues or bad practices.
* Reformat it with `ansible-lint --write`.

See also

* <https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html#ansible-lint>
* <https://ansible-lint.readthedocs.io/en/latest/>

### Ansible checks

Check Ansible syntax with `ansible-playbook --syntax-check`:

> "The ansible-playbook command offers several options for verification, including --check, --diff, --list-hosts, --list-tasks, and --syntax-check"
(<https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html#ansible-lint>).

### Molecule

Molecule is about what Unit-Tests would do on a programming language.

#### Create a new role with tests

TODO

#### Create tests in an existing role

```bash
cd roles/vhosts
molecule init scenario -r vhosts -d docker  # To create tests using the Ansible verifier. You probably do not want this unless you are really in love with Ansible.
molecule init scenario -r vhosts -d docker --verifier-name testinfra testinfra  # To create tests using the testinfra verifier, which is just a bit of Python.
```

Note: Idempotence is tested with *any* verifier, as it is part of the `idempotence` step.
You therefore do not need an extra `ansible` verifier to ensure it.

#### Run test scenarios

```bash
cd roles/vhosts
molecule test --all
```

### Formatting Python files with `black`

* Install via `pip install black`.
* Run `black .` to format Python files.

## Requirements

### Install Vagrant

We use Vagrant to start a fresh virtual machine image we can test our Ansible stuff against.

Install Vagrant according to <https://www.vagrantup.com/downloads>.

### Install hypervisor

To actually use Vagrant, you need a "provider".

* On Linux, use VirtualBox.
  * On Ubuntu, install it via: `sudo apt install virtualbox virtualbox-ext-pack`
* On Windows, use Hyper-V.
Be aware that you must execute `vagrant` in a shell with administrator privileges.

## Vagrant

### Start virtual machine and run Ansible playbook

Create and boot a virtual machine via `vagrant up`.
This will use `Vagrantfile` which in turn runs Ansible to test (or at least execute) the playbook.

### Run provision (i.e. Ansible playbook) again

Run the provision scripts again via `vagrant provision` without recreating the virtual machine.

### Destroy virtual machine

Shut down and destroy the virtual machine via `vagrant destroy`.

### Destroy and start virtual machine

Destroy and start the virtual machine again via `vagrant destroy -f && vagrant up`.

## Turn into a Collection

This repository could be turned into a collection according to this guide: <https://docs.ansible.com/ansible-core/devel/dev_guide/developing_collections_structure.html>

But this also puts `playbook.yaml` into a `playbooks/` subdirectory which does not work well unless you actually install the collection -- which I guess is just some additional PITA during development (maybe a symlink in ~/.ansible/collection or whatever to this directory would also do the trick).
Unless this gives you some real benefit, you probably should not do it.
