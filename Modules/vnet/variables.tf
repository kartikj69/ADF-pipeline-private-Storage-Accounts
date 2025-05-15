variable "name" {
  description = "Name of the virtual network"
  type        = string
  default     = "vnet-default"
}

variable "location" {
  description = "Azure region where the virtual network will be created"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-default"
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  description = "Subnets to create within the virtual network"
  type = list(object({
    name           = string
    address_prefix = string
  }))
  default = [
    {
      name           = "default-subnet"
      address_prefix = "10.0.1.0/24"
    },
    {
      name           = "pe-subnet"
      address_prefix = "10.0.2.0/24"
    }
  ]
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
