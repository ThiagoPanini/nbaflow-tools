/* ---------------------------------------------------------
    FILE: variables.tf @ storage module

    This file has all variables definitions for all
    submodules defined in this IaC project. For each one,
    a different section splitted by super comments will be
    provided in order to improve code organization.
--------------------------------------------------------- */

/* ---------------------------------------------------------
    VARIABLES: required
    Required variables from the module perspective
--------------------------------------------------------- */

variable "buckets_to_create" {
  description = "A list of bucket names that will be created within this module. The names put in the list will be concatened with the account id and the region name of the target AWS deployment account in order to make names unique"
  type        = list(string)
}


/* ---------------------------------------------------------
    VARIABLES: tags
    Parameters that helps to organize and establish tags
--------------------------------------------------------- */

variable "project_tags" {
  description = "A map with all project mandatory tags that will be put in all resources created"
  type        = map(string)
}


/* ---------------------------------------------------------
    VARIABLES: optional
    Optional variables from the module perspective
--------------------------------------------------------- */

variable "flag_enable_force_destroy" {
  description = "Flag that enables the force destroy on the buckets"
  type        = bool
  default     = true
}

variable "flag_block_public_access" {
  description = "Flag that blocks all public access for buckets using the aws_s3_bucket_public_access_block Terraform resource"
  type        = bool
  default     = true
}
