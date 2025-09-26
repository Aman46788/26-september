resource "azurerm_virtual_network" "vnet" {
  depends_on = [ azurerm_resource_group.test-rg ]
  name                = "shwetank-vnet"
  location            = azurerm_resource_group.test-rg.location
  resource_group_name = azurerm_resource_group.test-rg.name
  address_space       = ["10.0.0.0/16"]
}