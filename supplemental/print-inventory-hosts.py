#!/usr/bin/env python

# Reads all hosts from an inventory file and prints them to stdout.

import sys
from ansible.parsing.dataloader import DataLoader
from ansible.inventory.manager import InventoryManager
import pprint

if __name__ == "__main__":
    if len(sys.argv) < 1 + 1:
        print("Usage: print-inventory-hosts.py <inventory file>")
        exit(255)

    inventory_file_name = sys.argv[1]
    print(f"Using inventory file '{inventory_file_name}'...", file=sys.stderr)

    data_loader = DataLoader()
    inventory = InventoryManager(loader=data_loader, sources=[inventory_file_name])

    # for host in inventory.get_groups_dict()['all']:
    #    print(host)

    for host in inventory.get_hosts():
        print(host)
        # print(host.vars['ansible_host'])
