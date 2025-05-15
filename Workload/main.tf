data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# Create Virtual Networks
module "vnets" {
  source   = "../Modules/vnet"
  count    = length(var.vnets)

  name                = var.vnets[count.index].name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.vnets[count.index].address_space
  subnets             = var.vnets[count.index].subnets
  tags                = local.common_tags

}

# Private DNS Zones removed as requested

# Create Storage Accounts
module "storage_accounts" {
  source   = "../Modules/storage"
  count    = length(var.storage_accounts)

  name                     = var.storage_accounts[count.index].name
  location                 = data.azurerm_resource_group.rg.location
  resource_group_name      = data.azurerm_resource_group.rg.name
  account_tier             = var.storage_accounts[count.index].account_tier
  account_replication_type = var.storage_accounts[count.index].account_replication_type
  is_hns_enabled           = var.storage_accounts[count.index].is_hns_enabled
  container_name           = var.storage_accounts[count.index].container_name

  # Network rules simplified - no private endpoints

  tags                     = local.common_tags
}

# Private Endpoints removed as requested

# Create sample file in source storage account
module "sample_file" {
  source               = "../Modules/storage_blob"

  name                 = local.source_file_name
  storage_account_name = module.storage_accounts[0].name
  container_name       = var.storage_accounts[0].container_name
  type                 = "Block"
  source_content       = local.source_file_content
  depends_on = [module.storage_accounts]
}

# Create Azure Data Factory
module "adf" {
  source              = "../Modules/adf"
  name                = var.adf_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  tenant_id           = var.tenant_id
  use_msi             = var.use_msi

  # Storage account details for linked services
  source_storage_account = {
    name              = module.storage_accounts[0].name
    id                = module.storage_accounts[0].id
    container_name    = var.storage_accounts[0].container_name
    connection_string = module.storage_accounts[0].primary_connection_string
  }

  destination_storage_account = {
    name              = module.storage_accounts[1].name
    id                = module.storage_accounts[1].id
    container_name    = var.storage_accounts[1].container_name
    connection_string = module.storage_accounts[1].primary_connection_string
  }

  # File details
  source_file_name = local.source_file_name
  source_path      = local.source_path
  destination_path = local.destination_path

  tags = local.common_tags
  depends_on = [
    module.storage_accounts,
    module.sample_file
  ]
}

# Assign RBAC roles to ADF managed identity
module "rbac_assignments" {
  source = "../Modules/rbac"

  role_assignments = [
    # Storage Blob Data Contributor role for source storage account
    {
      scope                = module.storage_accounts[0].id
      role_definition_name = "Storage Blob Data Contributor"
      principal_id         = module.adf.identity_principal_id
      description          = "Allow ADF to read and write data in source storage account"
    },
    # Storage Blob Data Contributor role for destination storage account
    {
      scope                = module.storage_accounts[1].id
      role_definition_name = "Storage Blob Data Contributor"
      principal_id         = module.adf.identity_principal_id
      description          = "Allow ADF to read and write data in destination storage account"
    }
  ]

  depends_on = [
    module.adf,
    module.storage_accounts
  ]
}
