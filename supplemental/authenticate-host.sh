#!/bin/bash

# This adds all SSH host keys of all key types to ~/.ssh/known_hosts if not already present.
# As authenticity of hosts is not checked, this actually may bear a security risk.

if [ $# -lt 1 ]; then
    echo "Too few arguments specified:"
    echo "authenticate-host.sh <hostname>"
    exit 255
fi

host=$1
echo "Adding SSH host keys for '$host' to ~/.ssh/known_hosts if not present..."

echo "Scanning '$host' for SSH host keys..."
output=$(ssh-keyscan -T 120 $host)
#echo "Output of ssh-keyscan:"
#echo $output

host_keys_count=$(echo -n "$output" | grep -c '^')
echo "Found $host_keys_count host keys"

known_hosts_changed=false
IFS=$'\n'
for output_line in $output
do
    host_key_type=$(echo $output_line | cut -d " " -f 2)
    host_key=$(echo $output_line | cut -d " " -f 3)
    #echo "Processing $host_key_type host key '$host_key'..."
    echo "Processing $host_key_type host key..."

    echo "Checking if host key for $host is present in ~/.ssh/known_hosts..."
    if grep -Fq "$host_key" ~/.ssh/known_hosts
    then
        echo "Host key for $host already present."
    else
        echo "Host key for $host not present. Adding to ~/.ssh/known_hosts..."
        echo $output_line >> ~/.ssh/known_hosts
        if [ "$known_hosts_changed" = false ] ; then
            known_hosts_changed=true
        fi
    fi
done

if [ "$known_hosts_changed" = true ] ; then
    echo "Exiting with return code 1 to indicate changes to ~/.ssh/known_hosts"
    echo
    exit 1
fi

echo
