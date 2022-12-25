# Stop all VMs containing "Ansible" in name
Get-VM | where { $_.Name -match 'Ansible' } | Stop-VM

# Restore their snapshot named "installiert"
Get-VM | where { $_.Name -match 'Ansible' } | Foreach-Object { Restore-VMSnapshot -Name 'installiert' -VMName $_.Name -Confirm:$false }


# Temporary section:
#Get-VM | where {$_.Name -match 'Ansible'} | Start-VM
#Get-VM | where { $_.Name -match 'Ansible 1' } | Start-VM
#Get-VM | where { $_.Name -match 'Ansible 2' } | Start-VM
Get-VM | where { $_.Name -match 'Ansible 5' } | Start-VM
#Get-VM | where { $_.Name -match 'Ansible 6' } | Start-VM
