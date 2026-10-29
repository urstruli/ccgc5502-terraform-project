# PostgreSQL Flexible Server, using the smallest burstable size to keep costs low
resource "azurerm_postgresql_flexible_server" "psql" {
  name                   = var.server_name
  resource_group_name    = var.rg_name
  location               = var.location
  version                = "16"
  administrator_login    = "psqladmin"
  administrator_password = var.admin_password
  sku_name               = "B_Standard_B2s"
  storage_mb             = 32768
  backup_retention_days  = 7
  tags                   = var.tags

  # Azure assigns the zone itself after creation, so Terraform should not try to change it
  lifecycle {
    ignore_changes = [zone]
  }
}

# Allow only your IP to connect to the database
resource "azurerm_postgresql_flexible_server_firewall_rule" "my_ip" {
  name             = "allow-my-ip"
  server_id        = azurerm_postgresql_flexible_server.psql.id
  start_ip_address = var.allowed_ip
  end_ip_address   = var.allowed_ip
}
