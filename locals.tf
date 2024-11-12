locals {
  environment = var.environment

  instance_type = "t2.small"
  location      = "us-east-1"

  # VPC CIDR and subnet calculations
  vpc_cidr = "10.0.0.0/16"
  
  # Calculate subnet CIDRs
  public_subnet_cidrs = [
    for i in range(var.public_sn_count) : 
    "10.0.${i + 1}.0/24"
  ]

  private_subnet_cidrs = [
    for i in range(var.private_sn_count) : 
    "10.0.${i + 3}.0/24"
  ]

  database_subnet_cidrs = var.db_subnet_group ? [
    for i in range(var.private_sn_count) : 
    "10.0.${i + 5}.0/24"
  ] : []

  # Availability Zones
  azs = slice(data.aws_availability_zones.available.names, 0, max(var.public_sn_count, var.private_sn_count))

  # Common tags
  common_tags = {
    Environment = local.environment
    ManagedBy   = "terraform"
  }

  # Resource naming
  vpc_name               = "vpc-${local.environment}"
  public_subnet_name     = "public_subnet-${local.environment}"
  private_subnet_name    = "complex-private-${local.environment}"
  database_subnet_name   = "complex_db-${local.environment}"
  db_subnet_group_name   = "complex_rds_subnetgroup"
}