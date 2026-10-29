
# Availability set for the Windows VM (the spec's requirement for Windows)
resource "azurerm_availability_set" "avset" {
  name                         = "6739-AVSET"
  location                     = var.location
  resource_group_name          = var.rg_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed                      = true
  tags                         = var.tags
}

# Public IP for the Windows VM
resource "azurerm_public_ip" "pip" {
  count               = 1
  name                = "6739-WIN-PIP"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "win-6739"
  tags                = var.tags
}

resource "azurerm_network_interface" "nic" {
  count               = 1
  name                = "6739-WIN-NIC"
  location            = var.location
  resource_group_name = var.rg_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[0].id
  }
}

# The Windows Server 2022 VM, with a 128 GB OS disk
resource "azurerm_windows_virtual_machine" "win" {
  count                 = 1
  name                  = "6739-WIN"
  computer_name         = "6739-WIN"
  resource_group_name   = var.rg_name
  location              = var.location
  size                  = var.vm_size
  admin_username        = "azureadmin"
  admin_password        = var.admin_password
  availability_set_id   = azurerm_availability_set.avset.id
  network_interface_ids = [azurerm_network_interface.nic[0].id]
  tags                  = var.tags

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 128
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.boot_diag_uri
  }
}

# Antimalware extension, as the spec requires
resource "azurerm_virtual_machine_extension" "antimalware" {
  count                      = 1
  name                       = "IaaSAntimalware"
  virtual_machine_id         = azurerm_windows_virtual_machine.win[0].id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.8"
  auto_upgrade_minor_version = true
}
