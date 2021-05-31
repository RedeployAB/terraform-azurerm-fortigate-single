locals {
  location            = coalesce(var.location, data.azurerm_resource_group.appliance.location)
  resource_group_tags = var.inherit_resource_group_tags ? data.azurerm_resource_group.appliance.tags : {}
  resource_tags       = merge(local.resource_group_tags, var.tags)
}
