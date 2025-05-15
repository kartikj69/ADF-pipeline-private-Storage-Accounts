terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.75.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "azurerm" {
  subscription_id = "0c267d19-0a1d-449d-8f6d-88536cb2f4ca"
  skip_provider_registration = true
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
