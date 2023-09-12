/* ---------------------------------------------------------
    FILE: data.tf @ root module

    This file handles all data sources collected from
    Terraform available data sources in order to make it
    easier to define variables and local values within
    information about the target AWS account.
--------------------------------------------------------- */

# Getting caller identity and region
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
