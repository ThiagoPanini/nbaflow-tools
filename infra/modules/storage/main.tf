/* ---------------------------------------------------------
    FILE: main.tf @ storage module

    The main file from this submodule created to define
    all resources and its rules.

    GOAL:
        To deploy S3 buckets and additional S3 configuration
        needed to provision a way to store assets for this
        Terraform project

    RESOURCES:
        - S3 buckets
--------------------------------------------------------- */

# Creating s3 buckets
resource "aws_s3_bucket" "lambda_layers" {
  for_each      = toset(var.buckets_to_create)
  bucket        = "${each.value}-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
  force_destroy = var.flag_enable_force_destroy
}
