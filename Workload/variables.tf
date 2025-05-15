variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}
variable "subscription_id" {
  description = "value of subscription id"
  type        = string
}
variable "adf_name" {
  description = "Name of the Azure Data Factory"
  type        = string
}

variable "vnets" {
  description = "Configuration for virtual networks"
  type = list(object({
    name          = string
    address_space = list(string)
    subnets = list(object({
      name           = string
      address_prefix = string
    }))
  }))
}

variable "storage_accounts" {
  description = "Configuration for storage accounts"
  type = list(object({
    name                     = string
    vnet_index               = number
    subnet_name              = string
    account_tier             = string
    account_replication_type = string
    container_name           = string
    is_hns_enabled           = bool
  }))
}

variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
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
