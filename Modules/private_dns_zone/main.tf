resource "azurerm_private_dns_zone" "dns_zone" {
  name                = var.dns_zone_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_links" {
  for_each = { for idx, vnet_id in var.vnet_ids : idx => vnet_id }
  
  name                  = "link-${var.dns_zone_name}-to-vnet-${each.key}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone.name
  virtual_network_id    = each.value
  registration_enabled  = var.registration_enabled
  tags                  = var.tags
}
