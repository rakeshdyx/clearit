# Find Anthem Project Module

This module finds the Anthem project.

## Usage

``` terraform
locals {
  project_id = module.anthem_project.project_id
}

module "anthem_project" {
  source = "../find-anthem-project"

  org_domain        = "anthem-dev.com"
  business_division = "entshr"
  env_code          = "prd"
  application_name  = "shared"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >=0.13, <0.14 |
| google | ~> 3.58 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 3.58 |

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application\_name | The application name of the project. | `string` | n/a | yes |
| business\_division | Business division of the network host project. Can be entshr. | `string` | n/a | yes |
| env\_code | The environment code of the project. | `string` | n/a | yes |
| org\_domain | Domain of the organization for which service accounts are managed. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| project | The business division's network host project for the requested network environment. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
