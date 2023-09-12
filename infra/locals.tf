/* ---------------------------------------------------------
    FILE: locals.tf @ root module

    This file makes it easier to define local values that
    can be used inside any other Terraform code in any other
    Terraform file.
--------------------------------------------------------- */

locals {
  # Tags to be put in any Terraform resource
  project_tags = {
    "project" : "nbaflow-tools",
    "mail" : "panini.development@gmail.com"
  }

  # A tag prefix to name resources
  tag_prefix = "nbaflow"
}
