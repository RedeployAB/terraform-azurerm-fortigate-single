resource "random_string" "appliance_admin" {
  length  = 8
  upper   = false
  special = false
}

resource "random_password" "appliance_admin" {
  length           = 32
  special          = true
  override_special = "!@$-_"
}

resource "random_id" "deployment" {
  byte_length = 2
}

module "test_appliance" {
  source = "../../."

  name                = "test-fgtvm-${random_id.deployment.hex}"
  resource_group_name = azurerm_virtual_network.test_appliance.resource_group_name
  location            = azurerm_virtual_network.test_appliance.location
  size                = var.size
  os_version          = var.os_version

  admin_username = random_string.appliance_admin.result
  admin_password = random_password.appliance_admin.result

  public_subnet_id             = azurerm_subnet.public_subnet.id
  public_interface_ip_address  = cidrhost(azurerm_subnet.public_subnet.address_prefixes[0], 4)
  private_subnet_id            = azurerm_subnet.private_subnet.id
  private_interface_ip_address = cidrhost(azurerm_subnet.private_subnet.address_prefixes[0], 4)

  user_assigned_identity_id = azurerm_user_assigned_identity.test_appliance.id

  tags = var.tags
}
