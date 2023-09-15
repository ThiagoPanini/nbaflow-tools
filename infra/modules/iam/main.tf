/* ---------------------------------------------------------
    FILE: main.tf @ iam module

    GOAL:
        Provide an unique space for creating IAM policies and
        roles for all applications within this Terraform
        project

    RESOURCES:
        - IAM policies
        - IAM roles
--------------------------------------------------------- */

/* ---------------------------------------------------------
    RESOURCE: IAM policies
    Creating all policies that will be used in IAM roles
--------------------------------------------------------- */

# IAM policy: nbaflow_s3_basic_operation_policy
resource "aws_iam_policy" "nbaflow_s3_basic_operation_policy" {
  name        = "nbaflow_s3_basic_operation_policy"
  path        = "/"
  description = "IAM policy that gives S3 simple read and write access"

  # Providing the policy document from template
  policy = data.template_file.nbaflow_s3_basic_operation_policy.rendered

  # Setting tags
  tags = var.project_tags
}

# IAM policy: nbaflow_cloudwatch_logging
resource "aws_iam_policy" "nbaflow_cloudwatch_logging" {
  name        = "nbaflow_cloudwatch_logging"
  path        = "/"
  description = "IAM policy that gives permissions to write logs into CloudWatch"

  # Providing the policy document from template
  policy = data.template_file.nbaflow_cloudwatch_logging.rendered

  # Setting tags
  tags = var.project_tags
}

# IAM policy: nbaflow_lambda_vpc_connection
resource "aws_iam_policy" "nbaflow_lambda_vpc_connection" {
  name        = "nbaflow_lambda_vpc_connection"
  path        = "/"
  description = "IAM policy normally used by Lambda functions to be executed inside a VPC"

  # Providing the policy document from template
  policy = file("${path.module}/policy/nbaflow_lambda_vpc_connection.json")

  # Setting tags
  tags = var.project_tags
}


/* ---------------------------------------------------------
    RESOURCE: IAM roles
    Creating all roles that will be used in applications
--------------------------------------------------------- */

# IAM role: lambda-s3-operation
resource "aws_iam_role" "lambda_s3_operation_role" {
  name = "nbaflow_lambda_s3_operation_role"
  path = "/"

  # Defining trust policy for the role
  assume_role_policy = file("${path.module}/trust/trust-lambda.json")

  # Defining managed policy ARNs for the role
  managed_policy_arns = [
    aws_iam_policy.nbaflow_s3_basic_operation_policy.arn,
    aws_iam_policy.nbaflow_cloudwatch_logging.arn,
    aws_iam_policy.nbaflow_lambda_vpc_connection.arn
  ]

  # Setting explicit dependencies
  depends_on = [
    aws_iam_policy.nbaflow_s3_basic_operation_policy,
    aws_iam_policy.nbaflow_cloudwatch_logging,
    aws_iam_policy.nbaflow_lambda_vpc_connection
  ]

  # Setting tags
  tags = var.project_tags
}
