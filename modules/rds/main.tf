module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4"

  name        = local.name
  description = "Plotpilot MySQL security group"
  vpc_id      = var.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = var.vpc_cidr_block
    },
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "Public MySQL access"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = {
      Name = "Allow RDS Access"
  }
}

################################################################################
# RDS Module
################################################################################

module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${local.name}-staging"

  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine               = "mysql"
  engine_version       = "8.0.20"
  family               = "mysql8.0" # DB parameter group
  major_engine_version = "8.0"      # DB option group
  instance_class       = var.instance

  allocated_storage     = 20
  max_allocated_storage = 100
  storage_encrypted     = false

  name     = "plotpilot"
  username = "pilot"
  password = "Wv*i^FR72NyxpNYb"
  port     = 3306

  publicly_accessible = true

  multi_az               = true
  subnet_ids             = var.database_subnets
  vpc_security_group_ids = [module.security_group.security_group_id]

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["general"]

  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false

  performance_insights_enabled          = false
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  tags = local.tags
  db_instance_tags = {
    "Sensitive" = "high"
  }
  db_option_group_tags = {
    "Sensitive" = "low"
  }
  db_parameter_group_tags = {
    "Sensitive" = "low"
  }
  db_subnet_group_tags = {
    "Sensitive" = "high"
  }
}

# module "db_default" {
#   source = "terraform-aws-modules/rds/aws"

#   identifier = "${local.name}-default"

#   create_db_option_group    = false
#   create_db_parameter_group = false

#   # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
#   engine               = "mysql"
#   engine_version       = "8.0.20"
#   family               = "mysql8.0" # DB parameter group
#   major_engine_version = "8.0"      # DB option group
#   instance_class       = var.instance

#   allocated_storage = 20

#   name                   = "PlotpilotDefault"
#   username               = "plotpilot"
#   create_random_password = true
#   random_password_length = 12
#   port                   = 3306

#   subnet_ids             = var.database_subnets
#   vpc_security_group_ids = [module.security_group.security_group_id]

#   maintenance_window = "Mon:00:00-Mon:03:00"
#   backup_window      = "03:00-06:00"

#   backup_retention_period = 0

#   tags = local.tags
# }

# module "db_disabled" {
#   source = "terraform-aws-modules/rds/aws"

#   identifier = "${local.name}-disabled"

#   create_db_instance        = false
#   create_db_subnet_group    = false
#   create_db_parameter_group = false
#   create_db_option_group    = false
# }
