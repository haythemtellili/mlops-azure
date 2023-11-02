# Copyright (c) 2021 Microsoft
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

# Azure Machine Learning Workspace
resource "azurerm_machine_learning_workspace" "aml_ws" {
  name                    = "${var.prefix}-ws-${random_string.postfix.result}"
  friendly_name           = var.workspace_display_name
  location                = azurerm_resource_group.aml_rg.location
  resource_group_name     = azurerm_resource_group.aml_rg.name
  application_insights_id = azurerm_application_insights.aml_ai.id
  key_vault_id            = azurerm_key_vault.aml_kv.id
  storage_account_id      = azurerm_storage_account.aml_sa.id
  container_registry_id   = azurerm_container_registry.aml_acr.id
  public_network_access_enabled = true


  identity {
    type = "SystemAssigned"
  }
}

# Create Compute Resources in AML
resource "null_resource" "compute_resouces" {
  triggers = {
    # Generate a unique timestamp to trigger updates
    timestamp = "${timestamp()}"
  }

  provisioner "local-exec" {
    command="az ml compute create --name cpu-cluster --size Standard_F4s_v2 --min-instances 0 --max-instances 1 --type AmlCompute --resource-group ${azurerm_machine_learning_workspace.aml_ws.resource_group_name} --workspace-name ${azurerm_machine_learning_workspace.aml_ws.name}"
  }
   provisioner "local-exec" {
    command="az ml compute create --name haythemt --size Standard_F4s_v2 --type ComputeInstance --resource-group ${azurerm_machine_learning_workspace.aml_ws.resource_group_name} --workspace-name ${azurerm_machine_learning_workspace.aml_ws.name}"
  }

  depends_on = [azurerm_machine_learning_workspace.aml_ws]
}