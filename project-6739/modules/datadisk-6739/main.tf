# One 10 GB data disk per VM. Zonal disks must match their VM's zone.
resource "azurerm_managed_disk" "disk" {
  for_each             = var.vms
  name                 = "${each.key}-DISK1"
  location             = var.location
  resource_group_name  = var.rg_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb
  zone                 = each.value.zone
  tags                 = var.tags
}

# Attach each disk to its VM
resource "azurerm_virtual_machine_data_disk_attachment" "attach" {
  for_each           = var.vms
  managed_disk_id    = azurerm_managed_disk.disk[each.key].id
  virtual_machine_id = each.value.id
  lun                = 0
  caching            = "ReadWrite"
}
