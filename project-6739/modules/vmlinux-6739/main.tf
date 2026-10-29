# Each key is a VM name. The zone is set per VM so the three VMs sit in separate zones.
locals {
  linux_vms = {
    "6739-LNX-01" = { zone = "1" }
    "6739-LNX-02" = { zone = "2" }
    "6739-LNX-03" = { zone = "3" }
  }
}

# Look up the existing subnet created by the network module

# Public IP per VM (Standard SKU is required for zones)
resource "azurerm_public_ip" "pip" {
  for_each            = local.linux_vms
  name                = "${each.key}-PIP"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = [each.value.zone]
  domain_name_label   = "lnx-${each.value.zone}-6739"
  tags                = var.tags
}

# Network interface per VM, connected to the subnet and its public IP
resource "azurerm_network_interface" "nic" {
  for_each            = local.linux_vms
  name                = "${each.key}-NIC"
  location            = var.location
  resource_group_name = var.rg_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[each.key].id
  }
}

# The Linux VMs (Ubuntu 22.04, 32 GB OS disk, SSH key login only)
resource "azurerm_linux_virtual_machine" "lnx" {
  for_each                        = local.linux_vms
  name                            = each.key
  computer_name                   = lower(each.key)
  resource_group_name             = var.rg_name
  location                        = var.location
  size                            = var.vm_size
  zone                            = each.value.zone
  admin_username                  = "azureuser"
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.nic[each.key].id]
  tags                            = var.tags

  admin_ssh_key {
    username   = "azureuser"
    public_key = file(pathexpand(var.ssh_public_key_path))
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 32
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.boot_diag_uri
  }
}

# Extension 1: Network Watcher
resource "azurerm_virtual_machine_extension" "netwatch" {
  for_each                   = local.linux_vms
  name                       = "NetworkWatcherAgentLinux"
  virtual_machine_id         = azurerm_linux_virtual_machine.lnx[each.key].id
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentLinux"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}

# Extension 2: Azure Monitor
resource "azurerm_virtual_machine_extension" "monitor" {
  for_each                   = local.linux_vms
  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = azurerm_linux_virtual_machine.lnx[each.key].id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}
