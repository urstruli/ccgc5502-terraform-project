variable "rg_name" {
  description = "Resource group for the database"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Tags applied to the database"
  type        = map(string)
}

variable "server_name" {
  description = "Name of the PostgreSQL Flexible Server (lowercase)"
  type        = string
}

variable "admin_password" {
  description = "Database admin password, supplied through an environment variable"
  type        = string
  sensitive   = true
}

variable "allowed_ip" {
  description = "Your public IP address (no /32), allowed through the database firewall"
  type        = string
}
