variable "rg_name" {
  description = "Resource group the network goes into, passed from the root"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Tags applied to the network resources"
  type        = map(string)
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "nsg_name" {
  description = "Name of the network security group"
  type        = string
}

variable "my_ip" {
  description = "Your public IP with /32 on the end, used as the only allowed source"
  type        = string
}
