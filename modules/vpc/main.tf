module "main_vpc" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "~> 2"

    name = "${local.name}-${var.vpc_name}"
    cidr = var.vpc_cidr_block # "10.99.0.0/18"

    azs              = var.vpc_availability_zones # ["${local.region}a", "${local.region}b", "${local.region}c"]
    public_subnets   = var.vpc_public_subnets # ["10.99.0.0/24", "10.99.1.0/24", "10.99.2.0/24"]
    private_subnets  = var.vpc_private_subnets # ["10.99.3.0/24", "10.99.4.0/24", "10.99.5.0/24"]

    # Database Subnets
    database_subnets = var.vpc_database_subnets # ["10.99.7.0/24", "10.99.8.0/24", "10.99.9.0/24"]
    create_database_subnet_group = var.vpc_create_database_subnet_group
    create_database_subnet_route_table = var.vpc_create_database_subnet_route_table
    create_database_internet_gateway_route = true
    # create_database_nat_gateway_route = true

    # NAT Gateways - Outbound Communication
    enable_nat_gateway = var.vpc_enable_nat_gateway
    single_nat_gateway = var.vpc_single_nat_gateway

    # VPC DNS Parameters
    enable_dns_hostnames = true
    enable_dns_support   = true

    tags = local.common_tags
    vpc_tags = local.common_tags

    # Additional Tags to Subnets
    public_subnet_tags = {
        Type = "Public Subnets"
    }
    private_subnet_tags = {
        Type = "Private Subnets"
    }
    database_subnet_tags = {
        Type = "Private Database Subnets"
    }
}

# module "security_group" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "~> 4"

#   name        = local.name
#   description = "Complete MySQL example security group"
#   vpc_id      = module.main_vpc.vpc_id

#   # ingress
#   ingress_with_cidr_blocks = [
#     {
#       from_port   = 3306
#       to_port     = 3306
#       protocol    = "tcp"
#       description = "MySQL access from within VPC"
#       cidr_blocks = module.main_vpc.vpc_cidr_block
#     },
#   ]

#   tags = local.tags
# }
