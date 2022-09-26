################################################################################
# Local Variables
################################################################################
locals {
  env_to_folder = {
    "plat" = "plat"
    "slvr" = "slvr"
    "gld"  = "gld"
    "prd"  = "network"
    "np"   = "network"
    "sbx"  = "sbx"
  }
  env_to_project = {
    "plat" = "platinum"
    "slvr" = "silver"
    "gld"  = "gold"
    "prd"  = "production"
    "np"   = "non-production"
    "sbx"  = "sbx"
  }
  folder_environment = local.env_to_folder[var.environment]
  project_environment = local.env_to_project[var.environment]
  l1_affix = var.environment == "sbx" ? "sbx" : var.business_division
  l2_affix = var.environment == "sbx" ? var.business_division : (
    var.business_division == "entshr"
    ? "plat"
    : local.folder_environment
  )
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
  l2_folder = "${local.l1_affix}-${local.l2_affix}"
}

data "google_active_folder" "l2_folder" {
  display_name = local.l2_folder
  parent       = data.google_active_folder.l1_folder.name
}

################################################################################
# Find Anthem Project
################################################################################
locals {
  parent_id = split("/", data.google_active_folder.l2_folder.name)[1]
  filter = format(
    "%s %s %s %s %s",
    "parent.id:${local.parent_id}",
    "labels.business-division:${var.business_division}",
    "labels.application-name:${var.application_name}",
    "labels.environment:${local.project_environment}",
    "lifecycleState:ACTIVE",
  )
}

data "google_projects" "anthem_project" {
  filter = local.filter
}
