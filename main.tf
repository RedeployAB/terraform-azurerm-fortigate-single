terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.61.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">=3.1.0"
    }

    template = {
      source  = "hashicorp/template"
      version = ">=2.2.0"
    }
  }

  required_version = ">= 0.15.0"
}

provider "azurerm" {
  features {}
}
