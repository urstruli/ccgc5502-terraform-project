output "lb_name" {
  description = "Name of the load balancer, passed to the root module"
  value       = azurerm_lb.lb.name
}
