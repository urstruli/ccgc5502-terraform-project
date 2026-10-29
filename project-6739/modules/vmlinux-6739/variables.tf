variable "rg_name" {
  description = "Resource group for the VMs"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Tags applied to the VMs and their resources"
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

variable "vm_size" {
  description = "VM size for the Linux VMs"
  type        = string
  default     = "Standard_D2s_v7"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key from Lab 01"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_private_key_path" {
  description = "Path to the matching SSH private key"
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "subnet_id" {
  description = "ID of the subnet the VMs join, passed from the network module"
  type        = string
}
