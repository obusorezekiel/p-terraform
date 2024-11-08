# Output the ID of the VPC created or referenced in the configuration
output "vpc_id" {
  description = "The ID of the VPC created or referenced."
  value       = aws_vpc.complex_vpc.id
}

# Output the IDs of the public subnets created
output "public_subnet_ids" {
  value = aws_subnet.complex_public_subnets.*.id
}

# Output the IDs of the private subnets created
output "private_subnet_ids" {
  value = aws_subnet.complex_private_subnets.*.id
}

# Output the ID of the Internet Gateway created
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway created."
  value       = aws_internet_gateway.complex_igw.id
}

# Output the ID of the NAT Gateway created
output "nat_gateway_id" {
  description = "The ID of the NAT Gateway created."
  value       = aws_nat_gateway.complex_ngw.id
}

# Output the name of the DB Subnet Group created for RDS
output "db_subnet_group_name" {
  value = aws_db_subnet_group.complex_rds_subnetgroup[0].name
}

# Output the ID of the DB Subnet Group created for RDS
output "db_subnet_group_id" {
  value = aws_db_subnet_group.complex_rds_subnetgroup[0].id
}

# Output the IDs of the database subnets
output "private_subnets_db" {
  value = aws_subnet.complex_db_subnets.*.id
}