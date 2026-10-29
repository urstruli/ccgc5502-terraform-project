variable "rg_name" {
  description = "Resource group for the load balancer"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Tags applied to the load balancer"
  type        = map(string)
}

variable "lb_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "pip_name" {
  description = "Name of the load balancer's public IP"
  type        = string
}

variable "nic_ids" {
  description = "Linux VM network interface IDs keyed by VM name"
  type        = map(string)
}
