# Security Group for Load Balancer
resource "aws_security_group" "complex_lb_sg" {
  name        = var.lb_sg_name
  description = "Allow Inbound HTTP and HTTPS Traffic"
  vpc_id      = var.vpc_id # VPC ID to associate this security group with

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks # Allowed CIDR blocks for ingress
  }

  ingress {
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks # Allowed CIDR blocks for egress
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_cidr_blocks
  }

  tags = {
    Name = "lb-sg-${var.environment}"
    Environment = var.environment
  }
}

# Security Group for Backend ECS Services
resource "aws_security_group" "complex_backend_ecs_sg" {
  name        = var.backend_sg_name
  description = "Allow Inbound HTTP from Load Balancer"
  vpc_id      = var.vpc_id # VPC ID to associate this security group with

  ingress {
    from_port       = var.http_port
    to_port         = var.http_port
    protocol        = "tcp"
    security_groups = [aws_security_group.complex_lb_sg.id] # Source is the Load Balancer's SG
  }

  ingress {
    from_port       = var.https_port
    to_port         = var.https_port
    protocol        = "tcp"
    security_groups = [aws_security_group.complex_lb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_cidr_blocks
  }

  tags = {
    Name = "backend-sg-${var.environment}"
    Environment = var.environment
  }
}

# Security Group for RDS Database
resource "aws_security_group" "complex_rds_sg" {
  name        = var.rds_sg_name
  description = "Allow MySQL Port Inbound Traffic from Backend App Security Group"
  vpc_id      = var.vpc_id # VPC ID to associate this security group with

  # Ingress rule to allow traffic on MySQL port (3306) from the Backend ECS security group
  ingress {
    from_port       = var.mysql_port
    to_port         = var.mysql_port
    protocol        = "tcp"
    security_groups = [aws_security_group.complex_backend_ecs_sg.id] # Source is the ECS's SG
  }

  # Egress rule to allow all outbound traffic (unrestricted)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_cidr_blocks
  }

  tags = {
    Name = "rds-sg-${var.environment}"
    Environment = var.environment
  }
}