# VPC Input Variables

# VPC Name
variable "instance" {
  description = "Size of the instance"
  type = string
  default = "db.t2.micro"
}

variable "vpc_id" {

}

variable "vpc_cidr_block" {

}

variable "database_subnets" {

}
