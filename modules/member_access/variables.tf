variable "member" {
  description = "The GCP member to be given access. Can be a service account, user, group, or domain. Depending on the type must be in format serviceAccount:SERVICE_ACCOUNT_EMAIL or equivalent."
  type        = string
}

variable "access" {
  description = "Objects describing access to be given at different levels"
  type = list(object({
    access_level = string
    resource_id  = string
    roles        = list(string)
  }))
  default = []
}
