/* ---------------------------------------------------------
    FILE: variables.tf @ root module

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
  default = {
    "project" : "nbaflow-tools",
    "mail" : "panini.development@gmail.com"
  }
}

variable "tag_prefix" {
  description = "A tag prefix to be put in any resource tags that demands at least a name for the resource in order to provide a better resource identification"
  type        = string
  default     = "nbaflow"
}


/* ---------------------------------------------------------
    VARIABLES: network
    Defining all variables used in the network module
--------------------------------------------------------- */

variable "flag_create_network_resources" {
  description = "A boolean flag that can turn on and off the creation of all network resources within this Terraform submodule"
  type        = bool
  default     = true
}

variable "vpc_cidr_block" {
  description = "A valid CIDR block to be placed on the VPC resource"
  type        = string
  default     = "172.100.0.0/16"
}

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


/* ---------------------------------------------------------
    VARIABLES: storage
    Defining all variables used in the storage module
--------------------------------------------------------- */

variable "buckets_to_create" {
  description = "A list of bucket names that will be created within this module. The names put in the list will be concatened with the account id and the region name of the target AWS deployment account in order to make names unique"
  type        = list(string)
  default = [
    "lambda-layers"
  ]
}
