terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.61"
    }

    random = {
      source  = "hashicorp/random"
      version = "~>3.1"
    }
  }

  required_version = "~> 0.15.0"
}

provider "azurerm" {
  features {}
}
