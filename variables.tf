variable "name" {
  type        = string
  description = "Name for the firewall appliance."

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{1,60}$", var.name))
    error_message = "Value must be between 1 to 60 characters long, consisting of alphanumeric characters and hyphens."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Name of an existing resource group where the resources should be deployed to."

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{3,63}$", var.resource_group_name))
    error_message = "Value must be between 3 to 63 characters long, consisting of alphanumeric characters and hyphens."
  }
}

variable "location" {
  type        = string
  description = "Location used for the deployed resources. Must be the same as the location used for network resources (virtual network, subnet), which will be used by default."
  default     = null
}

variable "size" {
  type        = string
  description = "VM size for the appliance. Default is the smallest size that supports accelerated networking."
  default     = "Standard_DS2_v2"
}

variable "os_version" {
  type        = string
  description = "Specifies the version number of the FortiOS release to deploy."
  default     = "6.4.5"

  validation {
    condition     = contains(["6.4.5"], var.os_version)
    error_message = "OS version is not supported by this module."
  }
}

variable "license_type" {
  type        = string
  description = "Specifies the license type for the deployed appliances."
  default     = "payg"

  validation {
    condition     = contains(["payg", "byol"], lower(var.license_type))
    error_message = "Currently only PAYG deployments are supported."
  }
}

variable "license_path" {
  type        = string
  description = "Path to a license file used for BYOL deployments. Defaults to license.lic in the root module directory."
  default     = "license.lic"
}

variable "config_path" {
  type        = string
  description = "Path to a custom configuration file used while deploying the firewall. Defaults to the config file provided with the module."
  default     = null
}

variable "os_disk_name" {
  type        = string
  description = "Name of the OS disk resource. Will be generated if omitted."
  default     = null
}

variable "log_disk_name" {
  type        = string
  description = "Name of the log disk resource. Will be generated if omitted."
  default     = null
}

variable "log_disk_size_gb" {
  type        = number
  description = "Size (in GB) of the disk used for appliance logs."
  default     = 30
}

variable "admin_username" {
  type        = string
  description = "Username for the default admin account."
  default     = "fgtadmin"
}

variable "admin_password" {
  type        = string
  description = "Password for the default admin account."
  sensitive   = true
}

variable "disk_encryption_set_id" {
  type        = string
  description = "Resource ID of an disk encryption set the appliance should use. Will be skipped if omitted. Note that the managed identity must have access to the encryption key for this to work."
  default     = null
}

variable "availability_set_id" {
  type        = string
  description = "Resource ID of an availability set the appliance should be part of. Will be skipped if omitted."
  default     = null
}

variable "public_interface_name" {
  type        = string
  description = "Name of the public NIC resource. Will be generated if omitted."
  default     = null
}

variable "public_interface_ip_address" {
  type        = string
  description = "IP-address of the public interface."
  default     = null
}

variable "public_subnet_id" {
  type        = string
  description = "Resource ID of the subnet where the public NIC will be residing."
}

variable "private_subnet_id" {
  type        = string
  description = "Resource ID of the subnet where the private NIC will be residing."
}

variable "private_interface_name" {
  type        = string
  description = "Name of the private NIC resource. Will be generated if omitted."
  default     = null
}

variable "private_interface_ip_address" {
  type        = string
  description = "IP-address of the public interface."
}

variable "public_ip_name" {
  type        = string
  description = "Name of the public IP resource. Will be generated if omitted."
  default     = null
}

variable "attach_public_ip" {
  type        = bool
  description = "Used for skipping attachment of the public IP to the firewall for HA deployments."
  default     = true
}


variable "tags" {
  type        = map(string)
  description = "Tags that should be added to the deployed resources."
  default     = {}
}

variable "inherit_resource_group_tags" {
  type        = bool
  description = "Decides whether to inherit the tags from the resource group or not, and appends them to the resource tags."
  default     = false
}

variable "user_assigned_identity_id" {
  type        = string
  description = "Resource ID of the managed identity which the appliance will use for the SDN connector and disk encryption."
}
