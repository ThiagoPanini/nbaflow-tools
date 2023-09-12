/* ---------------------------------------------------------
    FILE: variables.tf @ lambda-nba-players module

    This file has all variables definitions for all
    submodules defined in this IaC project. For each one,
    a different section splitted by super comments will be
    provided in order to improve code organization.
--------------------------------------------------------- */


/* ---------------------------------------------------------
    VARIABLES: tags
    Parameters that helps to organize and establish tags
--------------------------------------------------------- */

variable "project_tags" {
  description = "A map with all project mandatory tags that will be put in all resources created"
  type        = map(string)
}

variable "tag_prefix" {
  description = "A tag prefix to be put in any resource tags that demands at least a name for the resource in order to provide a better resource identification"
  type        = string
}


/* ---------------------------------------------------------
    VARIABLES: required
    Required variables from the module perspective
--------------------------------------------------------- */

variable "vpc_cidr_block" {
  description = "A valid CIDR block to be placed on the VPC resource"
  type        = string
}


/* ---------------------------------------------------------
    VARIABLES: VPC
    Variables to configure the VPC created
--------------------------------------------------------- */

variable "vpc_enable_dns_support" {
  description = "Enables the DNS support for the VPC"
  type        = bool
  default     = true
}

variable "vpc_enable_dns_hostnames" {
  description = "Enables the DNS host names for the VPC"
  type        = bool
  default     = true
}
