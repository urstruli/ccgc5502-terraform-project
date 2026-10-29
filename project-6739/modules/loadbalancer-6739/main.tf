# Public IP for the load balancer's front end
resource "azurerm_public_ip" "lb_pip" {
  name                = var.pip_name
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# Public-facing load balancer (Standard SKU; Basic is retired)
resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"
  tags                = var.tags

  frontend_ip_configuration {
    name                 = "frontend"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

# Group of backend VMs the load balancer sends traffic to
resource "azurerm_lb_backend_address_pool" "pool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "backend-pool"
}

# Health check: only send traffic to VMs answering on port 80
resource "azurerm_lb_probe" "probe" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "http-probe"
  protocol        = "Tcp"
  port            = 80
}

# Forwards port 80 traffic from the front end to the backend VMs
resource "azurerm_lb_rule" "http" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "http-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.pool.id]
  probe_id                       = azurerm_lb_probe.probe.id
}

# Add each Linux VM's network interface to the backend pool
resource "azurerm_network_interface_backend_address_pool_association" "assoc" {
  for_each                = var.nic_ids
  network_interface_id    = each.value
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.pool.id
}
