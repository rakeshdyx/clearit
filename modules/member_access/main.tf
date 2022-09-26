################################################################################
# Configure Organization IAM
################################################################################
locals {
  org_access = [for access in var.access :
    {
      org_id = access.resource_id
      roles  = access.roles
    } if access.access_level == "org"
  ]
  org_roles = merge([for org_access in local.org_access :
    { for role in org_access.roles :
      "${org_access.org_id}/${role}" => {
        org_id = org_access.org_id
        role   = role
      }
    }
  ]...)
}

resource "google_organization_iam_member" "org_roles" {
  for_each = local.org_roles == null ? {} : local.org_roles

  org_id = each.value.org_id
  role   = each.value.role
  member = var.member
}

################################################################################
# Configure Folder IAM
################################################################################
locals {
  folder_access = [for access in var.access :
    {
      folder = access.resource_id
      roles  = access.roles
    } if access.access_level == "folder"
  ]
  folder_roles = merge([for folder_access in local.folder_access :
    { for role in folder_access.roles :
      "${folder_access.folder}/${role}" => {
        folder = folder_access.folder
        role   = role
      }
    }
  ]...)
}

resource "google_folder_iam_member" "folder_roles" {
  for_each = local.folder_roles == null ? {} : local.folder_roles

  folder = each.value.folder
  role   = each.value.role
  member = var.member
}

################################################################################
# Configure Project IAM
################################################################################
locals {
  project_access = [for access in var.access :
    {
      project_id = access.resource_id
      roles      = access.roles
    } if access.access_level == "project"
  ]
  project_roles = merge([for project_access in local.project_access :
    { for role in project_access.roles :
      "${project_access.project_id}/${role}" => {
        project_id = project_access.project_id
        role       = role
      }
    }
  ]...)
}

resource "google_project_iam_member" "project_roles" {
  for_each = local.project_roles == null ? {} : local.project_roles

  project = each.value.project_id
  role    = each.value.role
  member  = var.member
}
