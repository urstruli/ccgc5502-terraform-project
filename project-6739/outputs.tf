output "resource_group" {
  value = module.rgroup.rg_name
}

output "vnet_name" {
  value = module.network.vnet_name
}

output "subnet_name" {
  value = module.network.subnet_name
}

output "log_analytics_workspace" {
  value = module.common.law_name
}

output "recovery_services_vault" {
  value = module.common.rsv_name
}

output "boot_diag_storage" {
  value = module.common.storage_name
}

output "linux_hostnames" {
  value = module.vmlinux.hostnames
}

output "linux_fqdns" {
  value = module.vmlinux.fqdns
}

output "linux_private_ips" {
  value = module.vmlinux.private_ips
}

output "linux_public_ips" {
  value = module.vmlinux.public_ips
}

output "windows_hostname" {
  value = module.vmwindows.hostname
}

output "windows_domain_name" {
  value = module.vmwindows.domain_name
}

output "windows_private_ip" {
  value = module.vmwindows.private_ip
}

output "windows_public_ip" {
  value = module.vmwindows.public_ip
}

output "load_balancer" {
  value = module.loadbalancer.lb_name
}

output "database_server" {
  value = module.database.server_name
}

output "database_fqdn" {
  value = module.database.server_fqdn
}
