resource "azurerm_data_factory" "adf" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  identity {
    type = "SystemAssigned"
  }
  tags = var.tags
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "source_storage" {
  name                  = "LS_${var.source_storage_account.name}"
  data_factory_id       = azurerm_data_factory.adf.id
  url                   = "https://${var.source_storage_account.name}.dfs.core.windows.net"

  # Use managed identity instead of storage account key
  use_managed_identity = true
  # tenant               = var.tenant_id

  # Only set one of storage_account_key or use_managed_identity
  storage_account_key   = var.use_msi ? null : var.source_storage_account.connection_string
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "destination_storage" {
  name                  = "LS_${var.destination_storage_account.name}"
  data_factory_id       = azurerm_data_factory.adf.id
  url                   = "https://${var.destination_storage_account.name}.dfs.core.windows.net"

  # Use managed identity instead of storage account key
  use_managed_identity = true
  # tenant               = var.tenant_id

  # Only set one of storage_account_key or use_managed_identity
  storage_account_key   = var.use_msi ? null : var.destination_storage_account.connection_string
}

resource "azurerm_data_factory_dataset_binary" "source_dataset" {
  name                = "DS_Source_File"
  data_factory_id     = azurerm_data_factory.adf.id
  linked_service_name = azurerm_data_factory_linked_service_data_lake_storage_gen2.source_storage.name

  azure_blob_storage_location {
    container = var.source_storage_account.container_name
    path      = var.source_path
    filename  = var.source_file_name
  }
}

# Create dataset for destination file
resource "azurerm_data_factory_dataset_binary" "destination_dataset" {
  name                = "DS_Destination_File"
  data_factory_id     = azurerm_data_factory.adf.id
  linked_service_name = azurerm_data_factory_linked_service_data_lake_storage_gen2.destination_storage.name

  azure_blob_storage_location {
    container = var.destination_storage_account.container_name
    path      = var.destination_path
    filename  = var.source_file_name
  }
}

# Create pipeline to copy data
resource "azurerm_data_factory_pipeline" "copy_pipeline" {
  name            = "PL_Copy_Data"
  data_factory_id = azurerm_data_factory.adf.id

  activities_json = <<JSON
[
  {
    "name": "CopyFromSourceToDestination",
    "type": "Copy",
    "dependsOn": [],
    "policy": {
      "timeout": "0.12:00:00",
      "retry": 0,
      "retryIntervalInSeconds": 30,
      "secureOutput": false,
      "secureInput": false
    },
    "userProperties": [],
    "typeProperties": {
      "source": {
        "type": "BinarySource",
        "storeSettings": {
          "type": "AzureBlobFSReadSettings",
          "recursive": false
        },
        "formatSettings": {
          "type": "BinaryReadSettings"
        }
      },
      "sink": {
        "type": "BinarySink",
        "storeSettings": {
          "type": "AzureBlobFSWriteSettings"
        }
      },
      "enableStaging": false
    },
    "inputs": [
      {
        "referenceName": "DS_Source_File",
        "type": "DatasetReference"
      }
    ],
    "outputs": [
      {
        "referenceName": "DS_Destination_File",
        "type": "DatasetReference"
      }
    ]
  }
]
JSON
}
