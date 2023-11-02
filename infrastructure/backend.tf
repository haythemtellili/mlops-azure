terraform {
    backend "azurerm" {
        resource_group_name  = "tfstate"
        storage_account_name = "tfstate17657"
        container_name       = "tfstate1"
        key                  = "terraform.tfstate"
    }
}