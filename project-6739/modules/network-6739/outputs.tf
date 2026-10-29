output "vnet_name" {
  description = "Name of the virtual network, passed to the root module"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_name" {
  description = "Name of the subnet, passed to the root module"
  value       = azurerm_subnet.subnet.name
}

output "subnet_id" {
  description = "ID of the subnet, passed to the VM modules"
  value       = azurerm_subnet.subnet.id
}
