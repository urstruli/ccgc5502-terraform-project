output "vm_id" {
  description = "ID of the Windows VM, used to attach the data disk"
  value       = azurerm_windows_virtual_machine.win[0].id
}

output "hostname" {
  description = "Hostname of the Windows VM"
  value       = azurerm_windows_virtual_machine.win[0].computer_name
}

output "domain_name" {
  description = "Domain name (FQDN) of the Windows VM"
  value       = azurerm_public_ip.pip[0].fqdn
}

output "private_ip" {
  description = "Private IP address of the Windows VM"
  value       = azurerm_network_interface.nic[0].private_ip_address
}

output "public_ip" {
  description = "Public IP address of the Windows VM"
  value       = azurerm_public_ip.pip[0].ip_address
}
