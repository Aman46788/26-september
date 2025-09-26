resource "azurerm_network_interface" "test-nic1" {
  name                = "shwetank-nic1"
  location            = azurerm_resource_group.test-rg.location
  resource_group_name = azurerm_resource_group.test-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.test-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_linux_virtual_machine" "test-vm" {
  name                  = "vm-shwetank"
  location              = azurerm_resource_group.test-rg.location
  resource_group_name   = azurerm_resource_group.test-rg.name
  network_interface_ids = [azurerm_network_interface.test-nic1.id]
  size                  = "Standard_B1s"
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  admin_username                  = "shwetank35716"
  disable_password_authentication = false              # 🔹 Password auth enabled
  admin_password                  = "MySecurePass@123" # 🔹 Apna strong password yahan do
}
resource "azurerm_network_security_group" "test-nsg" {
  name                = "shwetank-nsg"
  location            = azurerm_resource_group.test-rg.location
  resource_group_name = azurerm_resource_group.test-rg.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*" 
    destination_address_prefix = "*"
  }
}
# Associate NSG with NIC
resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id      = azurerm_network_interface.test-nic1.id
  network_security_group_id = azurerm_network_security_group.test-nsg.id
}
resource "azurerm_network_interface" "test-nic2" {
  name                = "shwetank-nic2"
  location            = azurerm_resource_group.test-rg.location
  resource_group_name = azurerm_resource_group.test-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.test-subnet.id
    private_ip_address_allocation = "Dynamic"

  }
}
resource "azurerm_linux_virtual_machine" "test-vm1" {
  name                  = "vm-hari"
  location              = azurerm_resource_group.test-rg.location
  resource_group_name   = azurerm_resource_group.test-rg.name
  network_interface_ids = [azurerm_network_interface.test-nic2.id]
  size                  = "Standard_B1s"
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  admin_username                  = "shwetank35716"
  disable_password_authentication = false              # 🔹 Password auth enabled
  admin_password                  = "MySecurePass@123" # 🔹 Apna strong password yahan do
}
resource "azurerm_network_security_group" "test-nsg1" {
  name                = "shwetank-nsg1"
  location            = azurerm_resource_group.test-rg.location
  resource_group_name = azurerm_resource_group.test-rg.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*" 
    destination_address_prefix = "*"
  }
}
# Associate NSG with NIC
resource "azurerm_network_interface_security_group_association" "nic_nsg1" {
  network_interface_id      = azurerm_network_interface.test-nic2.id
  network_security_group_id = azurerm_network_security_group.test-nsg1.id
}