/* ---------------------------------------------------------
    FILE: variables.tf @ iam module

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
