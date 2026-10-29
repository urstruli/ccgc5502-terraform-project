variable "rg_name" {
  description = "Resource group the common services go into"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Tags applied to the common resources"
  type        = map(string)
}

variable "law_name" {
  description = "Name of the Log Analytics workspace"
  type        = string
}

variable "rsv_name" {
  description = "Name of the Recovery Services vault"
  type        = string
}

variable "storage_name" {
  description = "Name of the boot diagnostics storage account"
  type        = string
}
