module "storage_account" {
  source = "../../modules/storage_account"
  location           = var.location
  resource_group_name = var.resource_group
  name = "stmlw${var.workloadIdentifier}${var.environmentIdentifier}"
}

module "application_insight" {
  source = "../../modules/application_insight"
  location           = var.location
  resource_group_name = var.resource_group
  name_log_analytics_workspace = "lawmlw${var.workloadIdentifier}${var.environmentIdentifier}"
  name_application_insight     = "appimlw${var.workloadIdentifier}${var.environmentIdentifier}"
}

module "container_registry" {
  source = "../../modules/container_registry"
  location           = var.location
  resource_group_name = var.resource_group
  name = "crmlw${var.workloadIdentifier}${var.environmentIdentifier}"
}

module "key_vault" {
  source = "../../modules/key_vault"
  location           = var.location
  resource_group_name = var.resource_group
  name = "kvmlw${var.workloadIdentifier}${var.environmentIdentifier}"
}

# Azure Machine Learning Workspace
resource "azurerm_machine_learning_workspace" "aml_ws" {
  name                    = "mlw${var.workloadIdentifier}${var.environmentIdentifier}"
  friendly_name           = var.workspace_display_name
  location                = var.location
  resource_group_name     = var.resource_group
  application_insights_id = module.application_insight.aml_ai_id
  key_vault_id            = module.key_vault.aml_kv_id
  storage_account_id      = module.storage_account.aml_sa_id
  container_registry_id   = module.container_registry.aml_acr_id
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
    command="az ml compute create --name ${var.cluster_name} --size Standard_F4s_v2 --min-instances 0 --max-instances 1 --type AmlCompute --resource-group ${azurerm_machine_learning_workspace.aml_ws.resource_group_name} --workspace-name ${azurerm_machine_learning_workspace.aml_ws.name}"
  }

  depends_on = [azurerm_machine_learning_workspace.aml_ws]
}