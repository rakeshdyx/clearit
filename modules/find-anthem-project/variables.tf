variable "org_domain" {
  description = "Domain of the organization for which service accounts are managed."
  type        = string
}

variable "business_division" {
  description = "Business division of the anthem project. Can be entshr, csbd, corp, hun, irx, dig, gbd, OR dbg."
  type        = string
}

variable "environment" {
  description = "The environment of the project. Can be platinum, gold, silver, production, non-production, or sandbox"
  type        = string
}

variable "application_name" {
  description = "The application name of the project."
  type        = string
}
