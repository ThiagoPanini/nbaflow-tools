/* ---------------------------------------------------------
    FILE: locals.tf @ root module

    This file makes it easier to define local values that
    can be used inside any other Terraform code in any other
    Terraform file.
--------------------------------------------------------- */

locals {
  # Getting account_id and region_name information
  account_id  = data.aws_caller_identity.current.account_id
  region_name = data.aws_region.current.name


  /* ---------------------------------------------------------
    LOCAL VALUES: S3 buckets
    Retrieving S3 bucket names for further usage
  --------------------------------------------------------- */

  # A bucket name to store Lambda layers
  s3_bucket_assets = "datadelivery-assets-${local.account_id}-${local.region_name}"

}
