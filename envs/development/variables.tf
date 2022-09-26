variable "org_domain" {
  description = "Domain of the organization for which service accounts are managed"
  type        = string
}

variable "org_domain_id" {
  type = string
  description = "Variable for Organization ID"
}

variable "project_id" {
  type = string
  description = "Project Id for custom role"

}
variable "baseline_roles" {
  description = "Map of baseline roles to contained predefined roles."
  type        = map(list(string))
}

variable "members" {
  description = "List of objects describing service accounts and their access"
  type        = any
  default     = []
}

variable "terraform_service_account" {
  type        = string
  description = "Service account email of the account to impersonate to run Terraform."
}

###############################################
## Custom Role Variables
###############################################

variable "permissions" {
  type = any
  description = "List of permissions we want to add custom roles"
  default = []
}

variable "excluded_permissions" {
  type        = list(string)
  description = "List of permissions to exclude from custom role."
  default     = []
}

variable "iam_role_id_org" {
  description = "Variable for Iam Role Id"
  type = string
}

variable "org_members" {
  type = any
  default = []
}

variable "org_base_roles" {
  type = list(string)
  default = []
}

variable "project_permissions" {
  type = any
  default = []
  description = "List of permissions we want to add custom roles for project level"
}

variable "iam_role_id_proj" {
  type = string
  description = "Project Id for the custom role"
}

variable "project_base_roles" {
  type = list(string)
  default = []
}

variable "project_excluded_permissions" {
  type = list(string)
  default = []
}

variable "project_members" {
  type = any
}
