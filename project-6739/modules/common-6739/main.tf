resource "azurerm_log_analytics_workspace" "law" {
  name                = var.law_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

resource "azurerm_recovery_services_vault" "rsv" {
  name                = var.rsv_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"
  storage_mode_type   = "LocallyRedundant"
  tags                = var.tags
}

resource "azurerm_storage_account" "diag" {
  name                            = var.storage_name
  location                        = var.location
  resource_group_name             = var.rg_name
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  account_kind                    = "StorageV2"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  tags                            = var.tags
}
