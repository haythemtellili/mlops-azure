# Key Vault for Azure Machine Learning

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "aml_kv" {
  name                     = "${var.prefix}-kv-${var.postfix}"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
}