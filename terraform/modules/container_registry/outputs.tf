output "aml_acr_id" {
  description = "ID of the container registry"
  value       = azurerm_container_registry.aml_acr.id
}
