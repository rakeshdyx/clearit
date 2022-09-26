
variable "role_id" {
  type        = string
  description = "ID of the Custom Role."
}

variable "title" {
  type        = string
  description = "Human-readable title of the Custom Role, defaults to role_id."
  default     = ""
}

variable "base_roles" {
  type        = list(string)
  description = "List of base predefined roles to use to compose custom role."
  default     = []
}

variable "permissions" {
  type        = list(string)
  description = "IAM permissions assigned to Custom Role."
}

variable "excluded_permissions" {
  type        = list(string)
  description = "List of permissions to exclude from custom role."
  default     = []
}

variable "description" {
  type        = string
  description = "Description of Custom role."
  default     = ""
}

variable "stage" {
  type        = string
  description = "The current launch stage of the role. Defaults to GA."
  default     = "GA"
}

variable "org_id" {
  type        = string
  description = "Variable for project or organization ID."
}

//variable "org_domain_id" {
//  type = string
//  description = "Variable for Organization ID"
//}

variable "target_level" {
  type        = string
  description = "String variable to denote if custom role being created is at project or organization level."
//  default     = "project"
}

variable "members" {
  description = "List of members to be added to custom role."
  type        = list(string)
}

variable "iam_role_id_org" {
  description = "Variable for Iam Role Id"
  type = string
  default = ""
}

variable "project_id" {
  type = string
  default = ""
}

//variable "org_members" {
//  type = list(string)
//}
////
//variable "project_members" {
//  type = list(string)
//}
//
//variable "iam_role_id_proj" {
//  type = string
//}