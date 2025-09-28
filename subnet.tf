resource "azurerm_subnet" "test-subnet" {
  depends_on = [ azurerm_virtual_network.vnet ]
  name                 = "shwetank-subnet"
  resource_group_name  = azurerm_resource_group.test-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/25"]
}
resource "azurerm_subnet" "durgesh-subnet" {
  depends_on = [ azurerm_virtual_network.vnet ]
  name                 = "shwetank-subnet"
  resource_group_name  = azurerm_resource_group.test-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/32"]
}