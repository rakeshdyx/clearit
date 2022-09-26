################################################################################
# Required Anthem Dev Organization
################################################################################
data "google_organization" "anthem_org" {
  domain = var.org_domain
}

################################################################################
# Required Anthem Dev Folders
################################################################################
locals {
  folders = merge([for member in var.members :
    {for access in member.access :
      "${lookup(access, "business_division", "null")}/${lookup(access, "environment", "null")}" => {
        org_domain        = var.org_domain
        business_division = lookup(access, "business_division", null)
        environment       = lookup(access, "environment", null)
      } if access.access_level == "folder"
    }
  ]...)
}

module "folders" {
  source = "../../modules/find-anthem-folder"
  for_each = local.folders

  org_domain        = each.value.org_domain
  business_division = each.value.business_division
  environment       = each.value.environment
}

################################################################################
# Required Anthem Projects
################################################################################
locals {
  projects = merge([for member in var.members :
    {for access in member.access :
      "${access.business_division}/${access.environment}/${access.application_name}" =>
      {
        org_domain        = var.org_domain
        business_division = access.business_division
        environment       = access.environment
        application_name  = access.application_name
      } if access.access_level == "project"
    }
  ]...)
}

module "projects" {
  source = "../../modules/find-anthem-project"
  for_each = local.projects

  org_domain        = each.value.org_domain
  business_division = each.value.business_division
  environment       = each.value.environment
  application_name  = each.value.application_name
}

################################################################################
# Member Access
################################################################################
locals {
  types = {
    "user" = "user"
    "group" = "group"
    "service_account" = "serviceAccount"
    "domain" = "domain"
  }
  members = {for member in var.members :
    "${local.types[member.type]}:${member.member}" => {
      member = "${local.types[member.type]}:${member.member}"
      access = [for access in member.access : {
        access_level = access.access_level
        resource_id = (
          access.access_level == "org"
          ? data.google_organization.anthem_org.org_id
          : (
            access.access_level == "folder"
            ? module.folders["${lookup(access, "business_division", "null")}/${lookup(access, "environment", "null")}"].folder.name
            : (
              access.access_level == "project"
              ? module.projects["${access.business_division}/${access.environment}/${access.application_name}"].project.project_id
              : ""
            )
          )
        )
        roles = distinct(flatten([
          [for baseline_role in access.baseline_roles:
            var.baseline_roles[baseline_role]
          ],
          access.additional_roles
        ]))
      }]
    }
  }
}

module "members_access" {
  source = "../../modules/member_access"
  for_each = local.members

  member = each.value.member
  access = each.value.access
}


######################################################################
## Custom Role Creation
######################################################################

resource "random_id" "rand_custom_id" {
  byte_length = 2
}

module "Org_custom_Role" {
  source = "../../modules/iam-custom-role"
  target_level         = "org"
  role_id              = var.iam_role_id_org
  base_roles           = var.org_base_roles
  permissions          = var.permissions
  title = "Iam Organization Level Role Testing"
  excluded_permissions = [""]
  description          = "Organization Level custom Role"
  members              = ["group:cgc-1052416665079-PlatformEngineering@wellpoint.com"]
  org_id = var.org_domain_id
}

/******************************************
  Module Project custom_role call
 *****************************************/
module "Project_custom_Role" {
  source = "../../modules/iam-custom-role"

  target_level         = "project"
  project_id            = var.project_id
  org_id = var.org_domain_id
  role_id              =  var.iam_role_id_org
  title = "Iam Project Level Role Testing"
  base_roles           = ["roles/iam.serviceAccountViewer"]
  permissions          = var.permissions//["iam.serviceAccountKeys.get","iam.serviceAccountKeys.list","iam.serviceAccounts.get","iam.serviceAccounts.getIamPolicy","iam.serviceAccounts.list"]
  excluded_permissions = ["resourcemanager.projects.get", "resourcemanager.projects.list"]
  description          = "Project Level Custom Role"
  members              = ["serviceAccount:custom-role-account-01@${var.project_id}.iam.gserviceaccount.com"]
}

/******************************************
  Create service accounts to use as members
 *****************************************/
resource "google_service_account" "custom_role_account_01" {
  account_id = "custom-role-account-01"
  project    = var.project_id
}

//resource "google_service_account" "custom_role_account_02" {
//  account_id = "custom-role-account-02"
//  project    = var.project_id
//}
