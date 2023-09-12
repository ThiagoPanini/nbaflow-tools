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

  # Assuming some default tags
  project_tags = var.project_tags
  tag_prefix   = var.tag_prefix
}
