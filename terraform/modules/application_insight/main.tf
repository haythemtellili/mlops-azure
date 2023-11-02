# Application Insights for Azure Machine Learning
resource "azurerm_log_analytics_workspace" "aml_log_analytics" {
  name                = "${var.prefix}-loganalytics-${var.postfix}"
  location                 = var.location
  resource_group_name      = var.resource_group_name
}

resource "azurerm_application_insights" "aml_ai" {
  name                = "${var.prefix}-ai-${var.postfix}"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  application_type    = "web"
  workspace_id = azurerm_log_analytics_workspace.aml_log_analytics.id
}