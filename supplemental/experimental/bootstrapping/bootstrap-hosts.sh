#!/bin/bash
if [ $# -lt 2 ]; then
    echo "Too few arguments specified:"
    echo "bootstrap-hosts.sh <ssh user> <ssh public key file> <inventory file>"
    exit 255
fi

user=$1
publickeyfile=$2
inventory=$3

# wait until all hosts are up
echo "Waiting for hosts to be up..."
for host in $(../misc/list-inventory-hosts.py $inventory); do
  ../misc/wait-for-it.sh -h $host -p 22 --timeout=0
done
echo "All hosts are up now."
echo 

#../misc/list-inventory-hosts.py $inventory | ../misc/authenticate-hosts.sh
#../misc/list-inventory-hosts.py $inventory | ../misc/authorize-ssh-key.sh $user $publickeyfile

echo "Starting ansible-playbook..."
echo "  You will now be asked for the SSH password for user $user"
echo

ansible-playbook bootstrap.yml -i $inventory --key-file=$publickeyfile --user=$user -K -k
