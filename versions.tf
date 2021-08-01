# Terraform Block
terraform {
  required_version = "~> 1.0.3"
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3.51.0"
        }
    }

    backend "s3" {
        bucket         = "igetbucket21"
        key            = "global/eu_west_2/plotpilot.tfstate" # Can be different for each set of resources you wish to group together
        region         = "eu-west-2"
        encrypt        = false
        profile        = "default"
    }
}
