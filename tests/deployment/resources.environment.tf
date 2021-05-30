resource "azurerm_virtual_network" "test_appliance" {
  name                = "vnet-test-fgtvm"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["10.100.10.0/27"]

  tags = var.tags
}

resource "azurerm_subnet" "test_appliance" {
  for_each = local.subnets

  name                 = each.value.name
  resource_group_name  = azurerm_virtual_network.test_appliance.resource_group_name
  virtual_network_name = azurerm_virtual_network.test_appliance.name
  address_prefixes     = each.value.address_prefixes
}

# resource "azurerm_subnet" "public_subnet" {
#   name                 = "sn-test-public"
#   resource_group_name  = azurerm_virtual_network.test_appliance.resource_group_name
#   virtual_network_name = azurerm_virtual_network.test_appliance.name
#   address_prefixes     = ["10.100.10.0/28"]
# }

# resource "azurerm_subnet" "private_subnet" {
#   name                 = "sn-test-private"
#   resource_group_name  = azurerm_virtual_network.test_appliance.resource_group_name
#   virtual_network_name = azurerm_virtual_network.test_appliance.name
#   address_prefixes     = ["10.100.10.16/28"]
# }

resource "azurerm_network_security_group" "test_appliance" {
  for_each = local.subnets

  name                = "nsg-${each.value-name}"
  resource_group_name = azurerm_virtual_network.test_appliance.resource_group_name
  location            = azurerm_virtual_network.test_appliance.location

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "test_appliance" {
  for_each = local.subnets

  subnet_id                 = azurerm_subnet.test_appliance[each.key].id
  network_security_group_id = azurerm_network_security_group.test_appliance[each.key].id
}

resource "azurerm_user_assigned_identity" "test_appliance" {
  name                = "mi-test-fgtvm"
  resource_group_name = azurerm_virtual_network.test_appliance.resource_group_name
  location            = azurerm_virtual_network.test_appliance.location

  tags = var.tags
}
