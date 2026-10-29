# Passwords are supplied through environment variables, never written in files
variable "win_admin_password" {
  description = "Windows VM admin password (set with TF_VAR_win_admin_password)"
  type        = string
  sensitive   = true
}

variable "psql_admin_password" {
  description = "PostgreSQL admin password (set with TF_VAR_psql_admin_password)"
  type        = string
  sensitive   = true
}

locals {
  common_tags = {
    Project        = "CCGC 5502 Terraform Project"
    Name           = "David.Beharry"
    ExpirationDate = "2027-12-31"
    Environment    = "Learning"
  }
}

module "rgroup" {
  source   = "./modules/rgroup-6739"
  rg_name  = "6739RG"
  location = "eastus2"
  tags     = local.common_tags
}

module "network" {
  source      = "./modules/network-6739"
  rg_name     = module.rgroup.rg_name
  location    = "eastus2"
  tags        = local.common_tags
  vnet_name   = "6739-VNET"
  subnet_name = "6739-SUBNET"
  nsg_name    = "6739-NSG"
  my_ip       = "208.111.75.14/32"
}

module "common" {
  source       = "./modules/common-6739"
  rg_name      = module.rgroup.rg_name
  location     = "eastus2"
  tags         = local.common_tags
  law_name     = "6739-LAW"
  rsv_name     = "A6739-RSV"
  storage_name = "6739stcommon"
}

module "vmlinux" {
  source        = "./modules/vmlinux-6739"
  rg_name       = module.rgroup.rg_name
  location      = "eastus2"
  tags          = local.common_tags
  vnet_name     = module.network.vnet_name
  subnet_name   = module.network.subnet_name
  subnet_id = module.network.subnet_id
  boot_diag_uri = module.common.storage_uri
}

module "vmwindows" {
  source         = "./modules/vmwindows-6739"
  rg_name        = module.rgroup.rg_name
  location       = "eastus2"
  tags           = local.common_tags
  vnet_name      = module.network.vnet_name
  subnet_name    = module.network.subnet_name
  subnet_id = module.network.subnet_id
  boot_diag_uri  = module.common.storage_uri
  admin_password = var.win_admin_password
}

module "datadisk" {
  source   = "./modules/datadisk-6739"
  rg_name  = module.rgroup.rg_name
  location = "eastus2"
  tags     = local.common_tags
  # Three Linux VMs (zoned) plus the Windows VM (no zone)
  vms = merge(
    module.vmlinux.disk_targets,
    { "6739-WIN" = { id = module.vmwindows.vm_id, zone = null } }
  )
}

module "loadbalancer" {
  source   = "./modules/loadbalancer-6739"
  rg_name  = module.rgroup.rg_name
  location = "eastus2"
  tags     = local.common_tags
  lb_name  = "6739-LB"
  pip_name = "6739-LB-PIP"
  nic_ids  = module.vmlinux.nic_ids
}

module "database" {
  source         = "./modules/database-6739"
  rg_name        = module.rgroup.rg_name
  location       = "canadacentral"
  tags           = local.common_tags
  server_name    = "6739-psql2"
  admin_password = var.psql_admin_password
  allowed_ip     = "208.111.75.14"
}
