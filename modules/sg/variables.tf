# VPC ID
variable "vpc_id" {
  description = "The ID of the VPC where the resources will be created"
  type        = string
}

# Environment
variable "environment" {
  description = "The environment for the resources"
  type        = string
}

# Security Group Names
variable "lb_sg_name" {
  description = "The name of the Load Balancer security group"
  type        = string
}

variable "backend_sg_name" {
  description = "The name of the backend application security group"
  type        = string
}

variable "rds_sg_name" {
  description = "The name of the RDS security group"
  type        = string
}

# Port Configuration
variable "http_port" {
  description = "The HTTP port"
  type        = number
}

variable "https_port" {
  description = "The HTTPS port"
  type        = number
}

variable "mysql_port" {
  description = "The PostgreSQL port for the RDS instance"
  type        = number
}

# CIDR Blocks for Ingress and Egress
variable "ingress_cidr_blocks" {
  description = "Allowed CIDR blocks for ingress traffic"
  type        = list(string)
}

variable "egress_cidr_blocks" {
  description = "Allowed CIDR blocks for egress traffic"
  type        = list(string)
}