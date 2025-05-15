output "role_assignment_ids" {
  description = "IDs of the created role assignments"
  value       = { for k, v in azurerm_role_assignment.role_assignment : k => v.id }
}

output "role_assignments" {
  description = "Map of created role assignments"
  value       = azurerm_role_assignment.role_assignment
}
