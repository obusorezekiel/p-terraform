# VPC CIDR Block (e.g., "10.0.0.0/16") for the VPC
variable "vpc_cidr" {
    type = string
}

# Environment name (e.g., "dev", "staging", "prod") used to tag resources for environment identification
variable "environment" {
  description = "The environment for the resources"
  type        = string
}

# Number of public subnets to create in the VPC (usually reflects the availability zones)
variable "public_sn_count" {
    type = number
}

# Number of private subnets to create in the VPC
variable "private_sn_count" {
  type = number
}

# Flag to decide whether to create a DB subnet group for RDS instances
variable "db_subnet_group" {
  type = bool
}