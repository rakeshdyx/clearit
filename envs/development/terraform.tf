terraform {
  // Terraform restricted to between 0.14 and 0.13
  required_version = ">=0.13, <0.14"

  // Specifies provider source and versions
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 3.76.0"
    }
  }

  // Specify backend GCS bucket in which pipeline Terraform state files are
  // stored
  backend "gcs" {
    bucket = "cft-tfstate-3ade"
    prefix = "terraform/iam/development"
  }
}
