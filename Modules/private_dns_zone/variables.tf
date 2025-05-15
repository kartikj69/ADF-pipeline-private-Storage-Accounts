variable "dns_zone_name" {
  description = "Name of the private DNS zone"
  type        = string
  default     = "privatelink.example.com"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-default"
}

variable "vnet_ids" {
  description = "List of virtual network IDs to link to the private DNS zone"
  type        = list(string)
  default     = []
}

variable "registration_enabled" {
  description = "Whether auto-registration of virtual machine records in the virtual network in the Private DNS zone is enabled"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
