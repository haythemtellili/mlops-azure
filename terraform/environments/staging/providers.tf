# Azure provide configuration
provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

terraform {
    backend "azurerm" {
        resource_group_name  = "tfstate"
        storage_account_name = "tfstate17657"
        container_name       = "tfstateprod"
        key                  = "terraform.tfstate"
    }
}