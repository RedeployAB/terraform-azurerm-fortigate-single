# Azure FortiGate Terraform Module

This module deploys a single FortiGate appliance to a virtual network.

* Pre-configured with the Azure SDN connector (using managed identity).
* Supports customer-managed keys for disk encryption.
* Can be used with both PAYG and BYOL.

## Prerequisites

* A resource group where you have Contributor access.
* A virtual network with two subnets and [pre-configured routing][fortigate-azure-routing], which you have join access to.
* A managed identity, which can see the network objects you want to reference in the FortiGate.

## Example deployment

```terraform
# Start by creating the referenced resources

module "fortigate" {
  source = "github.com/RedeployAB/terraform-azurerm-fortigate-single?ref=v0.1.0"

  name                = "fgtvm"
  resource_group_name = azurerm_resource_group.fortigate.name
  location            = azurerm_resource_group.fortigate.location
  os_version          = "6.4.5"

  # Root credentials
  admin_username = random_string.appliance_admin.result
  admin_password = random_password.appliance_admin.result

  # Subnet details
  public_subnet_id             = azurerm_subnet.public_subnet.id
  public_interface_ip_address  = cidrhost(azurerm_subnet.public_subnet.address_prefixes[0], 4)
  private_subnet_id            = azurerm_subnet.private_subnet.id
  private_interface_ip_address = cidrhost(azurerm_subnet.private_subnet.address_prefixes[0], 4)

  # Azure SDN managed identity
  user_assigned_identity_id = azurerm_user_assigned_identity.fortigate.id
}

```

See [`variables.tf`](./variables.tf) for a complete list of the supported variables.

## License

This module is licensed under the [MIT License](./LICENSE).

<!-- References -->

[fortigate-azure-routing]: https://docs.fortinet.com/document/fortigate-public-cloud/6.4.0/azure-administration-guide/609353/azure-routing-and-network-interfaces
