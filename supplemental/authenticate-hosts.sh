#!/bin/bash

# This adds all SSH host keys of all key types to ~/.ssh/known_hosts if not already present.
# As authenticity of hosts is not checked, this actually may bear a security risk.

# Input can be a file passed as argument or is read from stdin if no argument is given.

SCRIPTPATH=$(dirname "$(readlink -f "$0")")
while read host
do
    echo "Processing $host ..."
    "$SCRIPTPATH"/authenticate-host.sh $host
done < "${1:-/dev/stdin}"
