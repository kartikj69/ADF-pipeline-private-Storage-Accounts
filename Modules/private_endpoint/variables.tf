variable "name" {
  description = "Name of the private endpoint"
  type        = string
  default     = "pe-default"
}

variable "location" {
  description = "Azure region where the private endpoint will be created"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-default"
}

variable "subnet_id" {
  description = "ID of the subnet for the private endpoint"
  type        = string
  default     = null
}

variable "target_resource_id" {
  description = "ID of the resource to connect to"
  type        = string
  default     = null
}

variable "is_manual_connection" {
  description = "Whether the connection is manual or not"
  type        = bool
  default     = false
}

variable "subresource_names" {
  description = "List of subresource names to connect to"
  type        = list(string)
  default     = []
}

variable "private_dns_zone_ids" {
  description = "List of private DNS zone IDs to link to the private endpoint"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
