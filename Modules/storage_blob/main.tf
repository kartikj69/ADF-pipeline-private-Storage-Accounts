resource "azurerm_storage_blob" "blob" {
  name                   = var.name
  storage_account_name   = var.storage_account_name
  storage_container_name = var.container_name
  type                   = var.type
  source                 = var.source_path
  source_content         = var.source_content
  content_type           = var.content_type
  metadata               = var.metadata
}
