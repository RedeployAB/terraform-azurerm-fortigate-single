locals {
  license_path     = coalesce(var.license_path, "${path.root}/license.lic")
  config_path      = coalesce(var.config_path, "${path.module}/bootstrap.conf")
  license_contents = fileexists(local.license_path) ? file(local.license_path) : null
}
