output "law_name" {
  description = "Name of the Log Analytics workspace, passed to the root module"
  value       = azurerm_log_analytics_workspace.law.name
}

output "rsv_name" {
  description = "Name of the Recovery Services vault, passed to the root module"
  value       = azurerm_recovery_services_vault.rsv.name
}

output "storage_name" {
  description = "Name of the boot diagnostics storage account, passed to the root module"
  value       = azurerm_storage_account.diag.name
}

output "storage_uri" {
  description = "Blob endpoint of the boot diagnostics storage account"
  value       = azurerm_storage_account.diag.primary_blob_endpoint
}
