variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = null
}

# TODO: Add validation to only accept SSD sizes
variable "size" {
  type    = string
  default = "Standard_DS2_v2"
}

variable "os_version" {
  type    = string
  default = "6.4.5"
}

variable "license_type" {
  type    = string
  default = "payg"
}

variable "license_path" {
  type    = string
  default = "./license.lic"
}

variable "config_path" {
  type    = string
  default = "./bootstrap.conf"
}

variable "os_disk_name" {
  type    = string
  default = null
}

variable "log_disk_name" {
  type    = string
  default = null
}

variable "log_disk_size_gb" {
  type    = number
  default = 30
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "disk_encryption_set_id" {
  type    = string
  default = null
}

variable "availability_set_id" {
  type    = string
  default = null
}

variable "public_interface_name" {
  type    = string
  default = null
}

variable "public_interface_ip_address" {
  type    = string
  default = null
}

variable "public_subnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "private_interface_name" {
  type    = string
  default = null
}

variable "private_interface_ip_address" {
  type = string
}

# variable "network_interfaces" {
#   type = object({
#     public = object({
#       name               = string
#       private_ip_address = string
#       gateway_ip_address = string
#       subnet_mask        = string
#     })
#     private = object({
#       name               = string
#       private_ip_address = string
#       gateway_ip_address = string
#       subnet_mask        = string
#     })
#   })
# }

variable "attach_public_ip" {
  type    = bool
  default = true
}

variable "public_ip_name" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "inherit_resource_group_tags" {
  type    = bool
  default = false
}

variable "user_assigned_identity_id" {
  type = string
}
