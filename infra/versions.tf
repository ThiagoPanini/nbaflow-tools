/* ---------------------------------------------------------
    FILE: versions.tf @ root module

    This file handles versions of Terraform itself and its
    providers.
--------------------------------------------------------- */

terraform {
  required_version = ">=1.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.61"
    }
  }
}
