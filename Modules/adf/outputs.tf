output "id" {
  description = "ID of the Azure Data Factory"
  value       = azurerm_data_factory.adf.id
}

output "name" {
  description = "Name of the Azure Data Factory"
  value       = azurerm_data_factory.adf.name
}

output "identity_principal_id" {
  description = "Principal ID of the Data Factory's managed identity"
  value       = azurerm_data_factory.adf.identity[0].principal_id
}

output "pipeline_id" {
  description = "ID of the copy pipeline"
  value       = azurerm_data_factory_pipeline.copy_pipeline.id
}

output "pipeline_name" {
  description = "Name of the copy pipeline"
  value       = azurerm_data_factory_pipeline.copy_pipeline.name
}
