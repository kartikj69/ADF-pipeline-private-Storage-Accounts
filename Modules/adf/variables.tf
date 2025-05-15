variable "name" {
  description = "Name of the Azure Data Factory"
  type        = string
  default     = "adf-default"
}

variable "location" {
  description = "Azure region where the Data Factory will be created"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-default"
}

variable "source_storage_account" {
  description = "Details of the source storage account"
  type = object({
    name              = string
    id                = string
    container_name    = string
    connection_string = string
  })
  default = {
    name              = "stgsourcedefault"
    id                = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-default/providers/Microsoft.Storage/storageAccounts/stgsourcedefault"
    container_name    = "source"
    connection_string = "DefaultEndpointsProtocol=https;AccountName=stgsourcedefault;AccountKey=dummykey;EndpointSuffix=core.windows.net"
  }
}

variable "destination_storage_account" {
  description = "Details of the destination storage account"
  type = object({
    name              = string
    id                = string
    container_name    = string
    connection_string = string
  })
  default = {
    name              = "stgdestdefault"
    id                = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-default/providers/Microsoft.Storage/storageAccounts/stgdestdefault"
    container_name    = "destination"
    connection_string = "DefaultEndpointsProtocol=https;AccountName=stgdestdefault;AccountKey=dummykey;EndpointSuffix=core.windows.net"
  }
}

variable "source_file_name" {
  description = "Name of the source file to copy"
  type        = string
  # default     = "sample.txt"
}

variable "source_path" {
  description = "Path to the source file"
  type        = string
  # default     = ""
}

variable "destination_path" {
  description = "Path to the destination file"
  type        = string
  # default     = ""
}

variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
  default     = null
}

variable "use_msi" {
  description = "Whether to use Managed Service Identity for storage access"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
