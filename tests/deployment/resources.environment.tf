data "azurerm_resource_group" "test_environment" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "test_environment" {
  name                = "vnet-test-fgtvm"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["10.100.10.0/27"]

  tags = data.azurerm_resource_group.test_environment.tags
}

resource "azurerm_subnet" "test_environment" {
  #ts:skip=accurics.azure.NS.161 NSG association is not detected
  for_each = local.subnets

  name                 = each.value.name
  resource_group_name  = azurerm_virtual_network.test_environment.resource_group_name
  virtual_network_name = azurerm_virtual_network.test_environment.name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_network_security_group" "test_environment" {
  for_each = local.subnets

  name                = "nsg-${each.value.name}"
  resource_group_name = azurerm_virtual_network.test_environment.resource_group_name
  location            = azurerm_virtual_network.test_environment.location

  tags = data.azurerm_resource_group.test_environment.tags
}

resource "azurerm_subnet_network_security_group_association" "test_environment" {
  for_each = local.subnets

  subnet_id                 = azurerm_subnet.test_environment[each.key].id
  network_security_group_id = azurerm_network_security_group.test_environment[each.key].id
}

resource "azurerm_user_assigned_identity" "test_environment" {
  name                = "mi-test-fgtvm"
  resource_group_name = azurerm_virtual_network.test_environment.resource_group_name
  location            = azurerm_virtual_network.test_environment.location

  tags = data.azurerm_resource_group.test_environment.tags
}
