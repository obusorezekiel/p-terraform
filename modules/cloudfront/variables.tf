variable "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  type        = string
}

variable "environment" {
  description = "The environment for the resources"
  type        = string
}

variable "certificate_arn" {
  description = "ARN of the ACM certificate for CloudFront"
  type        = string
}

variable "domain_name" {
  description = "Domain name for the CloudFront distribution"
  type        = string
}