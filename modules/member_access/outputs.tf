locals {
  project_iams = { for key, member in google_project_iam_member.project_roles :
    member.project => member.role...
  }
  org_iams = { for key, member in google_organization_iam_member.org_roles :
    member.org_id => member.role...
  }
  folder_iams = { for key, member in google_folder_iam_member.folder_roles :
    member.folder => member.role...
  }
  iam_access = {
    orgs     = local.org_iams
    projects = local.project_iams
    folder   = local.folder_iams
  }
}

output "iam_access" {
  description = "The IAM access given to the member"
  value       = local.iam_access
}
