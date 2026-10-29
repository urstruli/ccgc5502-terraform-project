output "rg_name" {
  description = "Name of the resource group, passed to the root module"
  value       = azurerm_resource_group.rg.name
}