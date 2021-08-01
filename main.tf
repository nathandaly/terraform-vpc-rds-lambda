module "vpc" {
  source = "./modules/vpc"
}
module "rds" {
  source = "./modules/rds"
  vpc_id = module.vpc.output_vpc_id
  vpc_cidr_block = module.vpc.output_vpc_cidr_block
  database_subnets = module.vpc.output_database_subnets
}

module "lambda" {
    source = "./modules/lambda"
    private_subnets = module.vpc.output_private_subnets
    security_group_id = module.rds.output_security_group_id
}
