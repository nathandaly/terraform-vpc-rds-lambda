locals {
  name   = var.business_divsion
  region = var.aws_region
  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}
