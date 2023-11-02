output "aml_kv_id" {
  description = "ID of the key vault"
  value       = azurerm_key_vault.aml_kv.id
}
