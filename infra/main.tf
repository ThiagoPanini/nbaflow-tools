/* ---------------------------------------------------------
    FILE: main.tf @ root module

    The main file with all submodule calls in order to
    deploy all infrastructure resources declared.
--------------------------------------------------------- */


/* ---------------------------------------------------------
    MODULES: network
    Calling all submodules within network module
--------------------------------------------------------- */

module "network_vpc_infrastructure" {
  # Checking if user want to create network resources
  count  = var.flag_create_network_resources ? 1 : 0
  source = "./modules/network/vpc-infrastructure"

  # Configuring the VPC
  vpc_cidr_block           = var.vpc_cidr_block
  vpc_enable_dns_support   = var.vpc_enable_dns_support
  vpc_enable_dns_hostnames = var.vpc_enable_dns_hostnames

  # Passing some default tags
  project_tags = var.project_tags
  tag_prefix   = var.tag_prefix
}


/* ---------------------------------------------------------
    MODULES: iam
    Calling all submodules within iam module
--------------------------------------------------------- */

# Creating all IAM policies and roles used by resources in this project
module "iam" {
  source = "./modules/iam"

  # Passing some default tags
  project_tags = var.project_tags
}


/* ---------------------------------------------------------
    MODULES: iam
    Calling all submodules within iam module
--------------------------------------------------------- */

# Creating all IAM policies and roles used by resources in this project
module "storage" {
  source = "./modules/storage"

  # Setting a list of buckets to be created
  buckets_to_create = var.buckets_to_create

  # Passing some default tags
  project_tags = var.project_tags
}



/* ---------------------------------------------------------
    MODULES: lambda
    Calling all submodules within network module
--------------------------------------------------------- */

# Creating Lambda layers do Lambda functions
module "lambda_layers" {
  source = "./modules/lambda/layers"

  # Defining configs to upload zip files to a bucket
  layers_path           = "../app/lambda/layers"
  s3_layers_bucket_name = "lambda-layers-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"

  # Setting explicit dependencies
  depends_on = [
    module.storage
  ]
}
