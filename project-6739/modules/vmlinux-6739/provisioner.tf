# Runs after each VM and its extensions are ready.
# The remote-exec provisioner logs into the VM over SSH and prints its hostname.
resource "null_resource" "show_hostname" {
  for_each = local.linux_vms

  depends_on = [
    azurerm_virtual_machine_extension.netwatch,
    azurerm_virtual_machine_extension.monitor,
  ]

  connection {
    type        = "ssh"
    user        = "azureuser"
    host        = azurerm_public_ip.pip[each.key].ip_address
    private_key = file(pathexpand(var.ssh_private_key_path))
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Provisioned VM hostname:' $(hostname)"
    ]
  }
}
