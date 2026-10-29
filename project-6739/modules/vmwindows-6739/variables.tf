variable "rg_name" {
  description = "Resource group for the VM"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Tags applied to the VM and its resources"
  type        = map(string)
}

variable "vnet_name" {
  description = "Existing virtual network name"
  type        = string
}

variable "subnet_name" {
  description = "Existing subnet name"
  type        = string
}

variable "boot_diag_uri" {
  description = "Blob endpoint for boot diagnostics"
  type        = string
}

variable "admin_password" {
  description = "Windows admin password, supplied through an environment variable"
  type        = string
  sensitive   = true
}

variable "vm_size" {
  description = "VM size for the Windows VM"
  type        = string
  default     = "Standard_D2s_v7"
}

variable "subnet_id" {
  description = "ID of the subnet the VM joins, passed from the network module"
  type        = string
}
