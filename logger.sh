#!/bin/bash

# Use me like this:
#   [...ansible-playbook...] 2>&1 | ./logger.sh
#                            ^^^^^^^^^^^^^^^^^^
# Then I will manage various files in the `logs` directory:
#   ansible-playbook-latest.log.ansi                      is just your latest run.
#   ansible-playbook-all.log.ansi                         are all runs.
#   runs/ansible-playbook-timed-2026-05-11_16-50.log.ansi is from a specific datetime (in a separate directory so they do not get into your way).
#
# The files are called *.ansi because `force_color=true` is set in `ansible.cfg` to retain ANSI colors.
#   `less --RAW-CONTROL-CHARS foo.log.ansi` (-R) to view it.
#   `batcat foo.log.ansi` to view it.
#   `ansi2txt < foo.log.ansi > foo.log.txt` from `colorized-logs` to remove ANSI.
#   In VSCode, install extension `iliazeus.vscode-ansi`.

mkdir -p logs
mkdir -p logs/runs

# Like ISO8601, but sanitized for Windows.
TIMESTAMP=$(date +"%Y-%m-%d_%H-%m-%s")

LOG_LATEST="logs/ansible-playbook-latest.log.ansi"
LOG_ALL="logs/ansible-playbook-all.log.ansi"
LOG_TIMED="logs/runs/ansible-playbook-timed-${TIMESTAMP}.log.ansi"

# Reads from stdin.
# Writes to each file.
tee "${LOG_LATEST}" | tee -a "${LOG_ALL}" | tee "${LOG_TIMED}"
