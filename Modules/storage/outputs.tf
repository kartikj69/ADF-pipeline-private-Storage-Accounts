output "id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.storage.id
}

output "name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.storage.name
}

output "primary_connection_string" {
  description = "Primary connection string of the storage account"
  value       = azurerm_storage_account.storage.primary_connection_string
  sensitive   = true
}

output "primary_access_key" {
  description = "Primary access key of the storage account"
  value       = azurerm_storage_account.storage.primary_access_key
  sensitive   = true
}

output "container_id" {
  description = "ID of the storage container"
  value       = azurerm_storage_container.container.id
}

output "container_name" {
  description = "Name of the storage container"
  value       = azurerm_storage_container.container.name
}
