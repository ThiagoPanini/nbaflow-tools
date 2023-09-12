/* ---------------------------------------------------------
    FILE: main.tf @ network/vpc-infrastructure module

    GOAL:
        Provide an optional network infrastructure to users
        that want to create an alternative VPC and its
        components before deploying any other project
        resource.

    RESOURCES:
        - VPC
        - Subnets
        - Internet Gateway
        - Route Table
        - Route Table Associations
--------------------------------------------------------- */


/* ---------------------------------------------------------
    RESOURCE: VPC
    Creating and configuring a VPC
--------------------------------------------------------- */

resource "aws_vpc" "nbaflow" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  enable_dns_support   = var.vpc_enable_dns_support

  # Setting tags
  tags = merge(
    {
      "Name" : "${var.tag_prefix}-vpc"
    },
    var.project_tags
  )
}


/* ---------------------------------------------------------
    RESOURCE: Subnets
    Creating three subnets in each available AZ
--------------------------------------------------------- */

resource "aws_subnet" "nbaflow_public" {
  for_each = zipmap(
    slice(data.aws_availability_zones.available.names, 0, 3),
    cidrsubnets(var.vpc_cidr_block, 8, 8, 8)
  )

  # Configuring the VPC ID and info about AZ and CIDR blocks
  vpc_id            = aws_vpc.nbaflow.id
  availability_zone = each.key
  cidr_block        = each.value

  # Setting tags 
  tags = merge(
    {
      "Name" : "${var.tag_prefix}-subnet-${substr(each.key, -2, -1)}"
    },
    var.project_tags
  )

  # Setting dependencies
  depends_on = [
    aws_vpc.nbaflow
  ]
}


/* ---------------------------------------------------------
    RESOURCE: Internet Gateway
    Creating an IGW for internet access
--------------------------------------------------------- */

resource "aws_internet_gateway" "nbaflow" {
  vpc_id = aws_vpc.nbaflow.id

  # Setting tags 
  tags = merge(
    {
      "Name" : "${var.tag_prefix}-igw"
    },
    var.project_tags
  )

  # Setting dependencies
  depends_on = [
    aws_vpc.nbaflow
  ]
}


/* ---------------------------------------------------------
    RESOURCE: Route table
    Creating a custom route table inside the new VPC
--------------------------------------------------------- */

resource "aws_route_table" "nbaflow" {
  vpc_id = aws_vpc.nbaflow.id

  # Setting tags 
  tags = merge(
    {
      "Name" : "${var.tag_prefix}-rtb"
    },
    var.project_tags
  )

  # Setting dependencies
  depends_on = [
    aws_vpc.nbaflow
  ]
}


/* ---------------------------------------------------------
    RESOURCE: Route table associations
    Setting up route associations for subnets and IGW
--------------------------------------------------------- */

resource "aws_route_table_association" "public_subnets" {
  for_each       = aws_subnet.nbaflow_public
  route_table_id = aws_route_table.nbaflow.id
  subnet_id      = each.value.id
}

resource "aws_route_table_association" "igw" {
  route_table_id = aws_route_table.nbaflow.id
  gateway_id     = aws_internet_gateway.nbaflow.id
}
