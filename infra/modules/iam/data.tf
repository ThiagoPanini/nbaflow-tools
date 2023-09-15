/* ---------------------------------------------------------
    FILE: data.tf @ iam module

    This file handles all data sources collected from
    Terraform available data sources in order to make it
    easier to define variables and local values within
    information about the target AWS account.

    By the way, this data.tf file in the iam module also has
    a special goal to define template_file data sources to
    get JSON policy files in order to replace dynamic values
    such as region name and account id defined within the
    JSON file to provide very specific permissions to AWS
    resources.
--------------------------------------------------------- */

# Getting caller identity and region
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# Defining a policy template file for policy: nbaflow_s3_basic_operation
data "template_file" "nbaflow_s3_basic_operation_policy" {
  template = file("${path.module}/policy/nbaflow_s3_basic_operation.json")

  vars = {
    project_tag_identifier = var.project_tags["project"]
  }
}

# Defining a policy template file for policy: nbaflow_cloudwatch_logging
data "template_file" "nbaflow_cloudwatch_logging" {
  template = file("${path.module}/policy/nbaflow_cloudwatch_logging.json")

  vars = {
    account_id  = data.aws_caller_identity.current.account_id
    region_name = data.aws_region.current.name
  }
}
