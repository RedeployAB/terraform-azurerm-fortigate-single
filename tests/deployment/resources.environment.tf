resource "azurerm_virtual_network" "test_appliance" {
  name                = "vnet-test-fgtvm"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["10.100.10.0/27"]

  tags = var.tags
}

resource "azurerm_subnet" "public_subnet" {
  name                 = "sn-test-public"
  resource_group_name  = azurerm_virtual_network.test_appliance.resource_group_name
  virtual_network_name = azurerm_virtual_network.test_appliance.name
  address_prefixes     = ["10.100.10.0/28"]
}

resource "azurerm_subnet" "private_subnet" {
  name                 = "sn-test-private"
  resource_group_name  = azurerm_virtual_network.test_appliance.resource_group_name
  virtual_network_name = azurerm_virtual_network.test_appliance.name
  address_prefixes     = ["10.100.10.16/28"]
}

resource "azurerm_user_assigned_identity" "test_appliance" {
  name                = "mi-test-fgtvm"
  resource_group_name = azurerm_virtual_network.test_appliance.resource_group_name
  location            = azurerm_virtual_network.test_appliance.location

  tags = var.tags
}
