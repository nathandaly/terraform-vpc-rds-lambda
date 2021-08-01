# VPC Output Values
# VPC ID
output "output_vpc_id" {
  description = "The ID of the VPC"
  value       = module.main_vpc.vpc_id
}

# VPC CIDR blocks
output "output_vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.main_vpc.vpc_cidr_block
}

# VPC Private Subnets
output "output_private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.main_vpc.private_subnets
}

# VPC Public Subnets
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.main_vpc.public_subnets
}

output "output_database_subnets" {
  description = "List of IDs of database subnets/"
  value = module.main_vpc.database_subnets
}

# VPC NAT gateway Public IP
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.main_vpc.nat_public_ips
}

# VPC AZs
output "azs" {
  description = "A list of availability zones spefified as argument to this module"
  value       = module.main_vpc.azs
}
