variable "rg_name" {
  description = "Resource group for the disks"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Tags applied to the disks"
  type        = map(string)
}

variable "vms" {
  description = "VMs to attach a disk to, keyed by VM name. zone is null for VMs without a zone."
  type = map(object({
    id   = string
    zone = optional(string)
  }))
}

variable "disk_size_gb" {
  description = "Size of each data disk in GB"
  type        = number
  default     = 10
}
