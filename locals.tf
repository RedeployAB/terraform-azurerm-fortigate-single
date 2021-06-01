locals {
  license_path = coalesce(var.license_path, "${path.root}/license.lic")
  config_path  = coalesce(var.config_path, "${path.module}/bootstrap.conf")
}
