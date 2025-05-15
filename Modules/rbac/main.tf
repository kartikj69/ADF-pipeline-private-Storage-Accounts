# Use a local to create a unique ID for each role assignment
locals {
  role_assignments = { for i, ra in var.role_assignments :
    "${i}-${ra.role_definition_name}-${ra.principal_id}" => {
      scope                = ra.scope
      role_definition_name = ra.role_definition_name
      principal_id         = ra.principal_id
      description          = lookup(ra, "description", null)
    }
  }
}

# Use for_each instead of count to avoid dependency issues
resource "azurerm_role_assignment" "role_assignment" {
  for_each             = local.role_assignments

  scope                = each.value.scope
  role_definition_name = each.value.role_definition_name
  principal_id         = each.value.principal_id

  # Add a small delay between role assignments to avoid conflicts
  timeouts {
    create = "5m"
    delete = "5m"
  }
}
