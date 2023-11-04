resource "azurerm_container_registry" "aml_acr" {
  name                     = var.name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  sku                      = "Standard"
  admin_enabled            = true
}