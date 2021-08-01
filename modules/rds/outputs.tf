output "output_security_group_id" {
    description = "Security group ID, useful for the Lambda VPC config"
    value = module.security_group.security_group_id
}
