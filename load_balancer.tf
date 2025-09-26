resource "azurerm_lb" "naya-lb" {
    depends_on = [ azurerm_linux_virtual_machine.test-vm, azurerm_linux_virtual_machine.test-vm1 ]
  name                = "test-lb"
  location            = azurerm_resource_group.test-rg.location
  resource_group_name = azurerm_resource_group.test-rg.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = data.azurerm_public_ip.pip1.id
  }
}
resource "azurerm_lb_backend_address_pool" "bap" {
    depends_on = [ azurerm_lb.naya-lb ]
  loadbalancer_id = azurerm_lb.naya-lb.id
  name            = "test-pool"
}
resource "azurerm_lb_probe" "prob" {
    depends_on = [ azurerm_lb.naya-lb ]
  loadbalancer_id = azurerm_lb.naya-lb.id
  name            = "test-probe"
  port            = 80
}
resource "azurerm_lb_rule" "lbrule" {
    depends_on = [ azurerm_lb.naya-lb]
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.naya-lb.id
  frontend_ip_configuration_name = "PublicIPAddress"
  protocol                       = "Tcp"
  frontend_port                  = 22
  backend_port                   = 22
  backend_address_pool_ids = azurerm_lb_backend_address_pool.bap.inbound_nat_rules
  probe_id                       = azurerm_lb_probe.prob.id
}
resource "azurerm_network_interface_backend_address_pool_association" "ppol-associate1" {
  network_interface_id    = azurerm_network_interface.test-nic1.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bap.id
}

resource "azurerm_network_interface_backend_address_pool_association" "ppol-associate2" {
  network_interface_id    = azurerm_network_interface.test-nic2.id
  ip_configuration_name   = "ipconfig2"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bap.id
}
