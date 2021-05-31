locals {
  # A selection of supported accelerated networking sizes that
  # most likely covers +90% of the deployment scenarios.
  enable_accelerated_networking = contains(local.supported_accelerated_networking_sizes, var.size)
  supported_accelerated_networking_sizes = [
    "Standard_F4s_v2",
    "Standard_F8s_v2",
    "Standard_F16s_v2",
    "Standard_D4s_v4",
    "Standard_D8s_v4",
    "Standard_D16s_v4",
    "Standard_DS2_v2",
    "Standard_DS3_v2",
    "Standard_DS4_v2",
    "Standard_DS5_v2",
    "Standard_D4s_v3",
    "Standard_D8s_v3",
    "Standard_D16s_v3"
  ]

  plan = {
    publisher = "fortinet"
    offer     = "fortinet_fortigate-vm_v5"
    sku = {
      byol = "fortinet_fg-vm"
      payg = "fortinet_fg-vm_payg_20190624"
    }
  }

  # Default resource names
  os_disk_name   = coalesce(var.os_disk_name, "os-${var.name}")
  log_disk_name  = coalesce(var.log_disk_name, "data-${var.name}")
  public_ip_name = coalesce(var.public_ip_name, "pip-${var.name}")
  network_interfaces = {
    public = {
      name               = coalesce(var.public_interface_name, "nic-${var.name}-01")
      private_ip_address = var.public_interface_ip_address
      subnet_id          = var.public_subnet_id
    }
    private = {
      name               = coalesce(var.private_interface_name, "nic-${var.name}-02")
      private_ip_address = var.private_interface_ip_address
      subnet_id          = var.private_subnet_id
    }
  }
}
