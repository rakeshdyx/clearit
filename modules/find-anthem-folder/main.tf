################################################################################
# Local Variables
################################################################################
locals {
  bd_specified = var.business_division == null ? 0 : 1
  env_specified = var.environment == null ? 0 : 1
  layer = local.bd_specified + local.env_specified

  l1_affix = var.environment == "sbx" ? "sbx" : var.business_division
  l2_affix = local.layer == 2 ? (var.environment == "sbx" ? var.business_division : (
    var.business_division == "entshr"
    ? "plat"
    : var.environment
  )) : null
}

################################################################################
# Find Parent Organization
################################################################################
data "google_organization" "anthem_org" {
  domain = var.org_domain
}

################################################################################
# Find Parent Layer 1 Folder
################################################################################
locals {
  l1_folder = local.l1_affix
}

data "google_active_folder" "l1_folder" {
  display_name = local.l1_folder
  parent       = data.google_organization.anthem_org.name
}

################################################################################
# Find Parent Layer 2 Folder
################################################################################
locals {
  l2_folder = local.layer == 2 ? "${local.l1_affix}-${local.l2_affix}" : null
}

data "google_active_folder" "l2_folder" {
  count = local.layer == 2 ? 1 : 0

  display_name = local.l2_folder
  parent       = data.google_active_folder.l1_folder.name
}
