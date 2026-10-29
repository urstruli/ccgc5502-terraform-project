output "hostnames" {
  description = "Hostnames of the Linux VMs"
  value       = [for k, vm in azurerm_linux_virtual_machine.lnx : vm.computer_name]
}

output "fqdns" {
  description = "Fully qualified domain names of the Linux VMs"
  value       = [for k, pip in azurerm_public_ip.pip : pip.fqdn]
}

output "private_ips" {
  description = "Private IP addresses of the Linux VMs"
  value       = [for k, nic in azurerm_network_interface.nic : nic.private_ip_address]
}

output "public_ips" {
  description = "Public IP addresses of the Linux VMs"
  value       = [for k, pip in azurerm_public_ip.pip : pip.ip_address]
}

# Keys come from local.linux_vms (known now); values are filled in after apply
output "nic_ids" {
  description = "Network interface IDs keyed by VM name, used by the load balancer"
  value       = { for k, v in local.linux_vms : k => azurerm_network_interface.nic[k].id }
}

# Keys come from local.linux_vms (known now); values are filled in after apply
output "disk_targets" {
  description = "VM IDs and zones keyed by VM name, used to attach data disks"
  value       = { for k, v in local.linux_vms : k => { id = azurerm_linux_virtual_machine.lnx[k].id, zone = v.zone } }
}
