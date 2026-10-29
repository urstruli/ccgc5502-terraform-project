output "server_name" {
  description = "Name of the database server, passed to the root module"
  value       = azurerm_postgresql_flexible_server.psql.name
}

output "server_fqdn" {
  description = "Fully qualified domain name of the database server"
  value       = azurerm_postgresql_flexible_server.psql.fqdn
}
