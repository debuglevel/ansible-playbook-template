#!/usr/bin/env python3

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
    print(f"Printing hosts in inventory file '{inventory_file_name}'...", file=sys.stderr)

    data_loader = DataLoader()
    inventory = InventoryManager(loader=data_loader, sources=[inventory_file_name])

    for host in inventory.get_hosts():
        print(f"Printing host '{host}'...", file=sys.stderr)
        print(host)
        print(f"Printed host '{host}'.", file=sys.stderr)
        print(f"", file=sys.stderr)

    print(f"Printed hosts in inventory file '{inventory_file_name}'.", file=sys.stderr)
    print(f"", file=sys.stderr)
