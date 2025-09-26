# resource "azurerm_public_ip" "test-pip" {
#     depends_on = [ azurerm_resource_group.test-rg ]
#   name                = "shwetank-pip"
#   resource_group_name = azurerm_resource_group.test-rg.name
#   location            = azurerm_resource_group.test-rg.location
#   allocation_method   = "Static"
# }