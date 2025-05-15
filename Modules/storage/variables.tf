variable "name" {
  description = "Name of the storage account"
  type        = string
  default     = "stgdefault"
}

variable "location" {
  description = "Azure region where the storage account will be created"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-default"
}

variable "account_tier" {
  description = "Tier of the storage account"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Replication type for the storage account"
  type        = string
  default     = "LRS"
}

variable "is_hns_enabled" {
  description = "Enable hierarchical namespace (required for Data Lake Gen2)"
  type        = bool
  default     = true
}

variable "container_name" {
  description = "Name of the container to create"
  type        = string
  default     = "data"
}

variable "allowed_ip_ranges" {
  description = "List of IP ranges that are allowed to access the storage account"
  type        = list(string)
  default     = []
}

variable "allowed_subnet_ids" {
  description = "List of subnet IDs that are allowed to access the storage account"
  type        = list(string)
  default     = []
}


variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
