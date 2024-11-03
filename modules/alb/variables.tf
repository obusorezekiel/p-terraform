variable "lb_sg" {
  description = "Security group for the load balancer"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets for the load balancer"
  type        = list(string)
}

variable "environment" {
  description = "The environment for the resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the load balancer and target groups will be created"
  type        = string
}


variable "tg_http_port" {
  description = "Port for the target group (HTTP)"
  type        = number
}

variable "tg_http_protocol" {
  description = "Protocol for the target group (HTTP)"
  type        = string
}

variable "tg_https_port" {
  description = "Port for the target group (HTTP)"
  type        = number
}

variable "tg_https_protocol" {
  description = "Protocol for the target group (HTTP)"
  type        = string
}


variable "listener_http_port" {
  description = "Port for the load balancer listener"
  type        = number
  default     = 80
}


variable "listener_http_protocol" {
  description = "Protocol for the load balancer listener"
  type        = string
  default     = "HTTP"
}

variable "listener_https_port" {
  description = "Port for the load balancer listener"
  type        = number
  default     = 80
}


variable "listener_https_protocol" {
  description = "Protocol for the load balancer listener"
  type        = string
  default     = "HTTP"
}

variable "certificate_arn" {
  description = "ARN of the ACM SSL certificate for HTTPS"
  type        = string
}
