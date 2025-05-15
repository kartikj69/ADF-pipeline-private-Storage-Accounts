variable "role_assignments" {
  description = "List of role assignments to create"
  type = list(object({
    scope                = string
    role_definition_name = string
    principal_id         = string
    description          = optional(string)
  }))
  default = []
}
