# Developing this playbook

- [Repository](Repository/Repository)
- [Testing](Testing/Testing)
- [Requirements](Requirements/Requirements)
- [Vagrant](Vagrant/Vagrant)

## Turn into a Collection

This repository could be turned into a collection according to this guide: https://docs.ansible.com/ansible-core/devel/dev_guide/developing_collections_structure.html

But this also puts `playbook.yaml` into a `playbooks/` subdirectory which does not work well unless you actually install the collection -- which I guess is just some additional PITA during development (maybe a symlink in ~/.ansible/collection or whatever to this directory would also do the trick).
Unless this gives you some real benefit, you probably should not do it.
