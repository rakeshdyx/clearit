variable "org_domain" {
  description = "Domain of the organization for which service accounts are managed."
  type        = string
}

variable "business_division" {
  description = "Business division of the anthem folder. Can be entshr, csbd, corp, hun, irx, dig, gbd, OR dbg."
  type        = string
  default     = null
}

variable "environment" {
  description = "The folder environment of the anthem folder. Can be plat, gld, slvr, network, or sbx"
  type        = string
  default     = null
}
