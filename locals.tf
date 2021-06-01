locals {
  config_path = coalesce(var.config_path, "${path.module}/bootstrap.conf")
}
