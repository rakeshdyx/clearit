# Service Account with Access Module

This module creates a service account and manages its IAM membership in
different projects and organizations.

## Usage

```terraform
module "service_account_with_access" {
  source = "../../modules/service-account-with-access"

  account_name = "service_account"
  account_id = "service_account"
  description = "Service account with access"
  project_id = "PROJECT_ID"

  access = [
    {
      access_level = "org"
      resource_id = "ORG_ID"
      roles = [
        "roles/compute.viewer",
        "roles/monitoring.viewer",
        "roles/cloudasset.viewer",
      ]
    },
    {
      access_level = "project"
      resource_id = "PROJECT_ID"
      roles = [
        "roles/compute.viewer",
        "roles/monitoring.viewer",
        "roles/cloudasset.viewer",
      ]
    },
  ]
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access | Objects describing access to be given at different levels | <pre>list(object({<br>    access_level = string<br>    resource_id  = string<br>    roles        = list(string)<br>  }))</pre> | `[]` | no |
| account\_id | The account id for the service account | `string` | `""` | no |
| account\_name | The display name for the service account | `string` | n/a | yes |
| description | A description for the service account | `string` | `""` | no |
| project\_id | The project id of the project to host the service account | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| iam\_access | The IAM access given to the service account |
| service\_account | Created service account resource |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
