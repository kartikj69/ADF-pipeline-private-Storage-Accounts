output "id" {
  description = "ID of the private DNS zone"
  value       = azurerm_private_dns_zone.dns_zone.id
}

output "name" {
  description = "Name of the private DNS zone"
  value       = azurerm_private_dns_zone.dns_zone.name
}

output "vnet_links" {
  description = "Map of virtual network links"
  value       = { for k, v in azurerm_private_dns_zone_virtual_network_link.vnet_links : k => v.id }
}
