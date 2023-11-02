resource "azurerm_storage_account" "aml_sa" {
  name                     = "${var.prefix}sa${var.postfix}"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}