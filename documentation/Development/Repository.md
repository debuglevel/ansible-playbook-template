# Repository

## Merge upstream template changes from `debuglevel/ansible-playbook-template`

This template is based on `debuglevel/ansible-playbook-template`.

You can merge changes from the upstream template into your current branch:

1. Add remote via `git remote add template https://github.com/debuglevel/ansible-playbook-template.git`.
2. Retrieve the repository via `git fetch template`.
3. Merge into the current branch via `git merge template/master` or `git merge --no-commit template/master`.

## Merge upstream template (alternative/additional notes)

* This assumes you leave `master` alone and do all your work in a separate branch (e.g. `home`).
* Your `git remote` should contain the `template` remote:

```sh
$ git remote

origin          git@github.com:debuglevel/ansible-home.git (fetch)
origin          git@github.com:debuglevel/ansible-home.git (push)
template        git@github.com:debuglevel/ansible-playbook-template.git (fetch)
template        git@github.com:debuglevel/ansible-playbook-template.git (push)
```

* Get data from the template branches: `git fetch template`.
* You now have a `template/master` branch: `git branch --all`
* Checkout your `master` branch: `git checkout master`
* Merge `template/master` into your `master`: `git merge template/master`
* Checkout your development branch: `git checkout home`
* Merge `master`: `git merge master`
* You may have conflicts to resolve;
fix them and commit the changes.

TL;DR: `git fetch template && git checkout master && git merge template/master && git checkout home && git merge master && echo "== Check for conflicts, resolve them, commit"`
