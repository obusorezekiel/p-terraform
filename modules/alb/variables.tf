# Security Group for the Load Balancer
variable "lb_sg" {
  description = "Security group for the load balancer"
  type        = string
}

# List of Public Subnets for the Load Balancer
variable "public_subnets" {
  description = "List of public subnets for the load balancer"
  type        = list(string)
}

# Environment Specification
variable "environment" {
  description = "The environment for the resources"
  type        = string
}

# VPC ID for Load Balancer and Target Groups
variable "vpc_id" {
  description = "VPC ID where the load balancer and target groups will be created"
  type        = string
}

# Port for the HTTP Target Group 
variable "tg_http_port" {
  description = "Port for the target group (HTTP)"
  type        = number
}

# Protocol for the HTTP Target Group
variable "tg_http_protocol" {
  description = "Protocol for the target group (HTTP)"
  type        = string
}

# Port for the HTTPS Target Group
variable "tg_https_port" {
  description = "Port for the target group (HTTP)"
  type        = number
}

# Protocol for the HTTPS Target Group
variable "tg_https_protocol" {
  description = "Protocol for the target group (HTTP)"
  type        = string
}


# HTTP Listener Port for the Load Balancer
variable "listener_http_port" {
  description = "Port for the load balancer listener"
  type        = number
  default     = 80
}

# HTTP Listener Protocol for the Load Balancer
variable "listener_http_protocol" {
  description = "Protocol for the load balancer listener"
  type        = string
  default     = "HTTP"
}

# HTTPS Listener Port for the Load Balancer
variable "listener_https_port" {
  description = "Port for the load balancer listener"
  type        = number
  default     = 80
}

# HTTPS Listener Protocol for the Load Balancer
variable "listener_https_protocol" {
  description = "Protocol for the load balancer listener"
  type        = string
  default     = "HTTP"
}

# ARN of the ACM SSL Certificate for HTTPS
variable "certificate_arn" {
  description = "ARN of the ACM SSL certificate for HTTPS"
  type        = string
}
