output "vpc_id" {
  description = "The ID of the VPC created or referenced."
  value       = aws_vpc.complex_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.complex_public_subnets.*.id
}

output "private_subnet_ids" {
  value = aws_subnet.complex_private_subnets.*.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway created."
  value       = aws_internet_gateway.complex_igw.id
}


output "nat_gateway_id" {
  description = "The ID of the NAT Gateway created."
  value       = aws_nat_gateway.complex_ngw.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.complex_rds_subnetgroup[0].name
}

output "db_subnet_group_id" {
  value = aws_db_subnet_group.complex_rds_subnetgroup[0].id
}

output "private_subnets_db" {
  value = aws_subnet.complex_db_subnets.*.id
}