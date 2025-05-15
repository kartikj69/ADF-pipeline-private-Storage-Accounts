output "id" {
  description = "ID of the blob"
  value       = azurerm_storage_blob.blob.id
}

output "url" {
  description = "URL of the blob"
  value       = azurerm_storage_blob.blob.url
}

output "name" {
  description = "Name of the blob"
  value       = azurerm_storage_blob.blob.name
}
