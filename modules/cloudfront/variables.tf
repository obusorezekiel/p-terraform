# The DNS Name of the Application Load Balancer (ALB) - Used for CloudFront origin configuration
variable "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  type        = string
}

# The Environment Variable - Specifies the environment (e.g., dev, prod) for the resources
variable "environment" {
  description = "The environment for the resources"
  type        = string
}

# ACM Certificate ARN - The ARN of the ACM certificate used for SSL with CloudFront
variable "certificate_arn" {
  description = "ARN of the ACM certificate for CloudFront"
  type        = string
}

# Domain Name for CloudFront Distribution - The domain name associated with CloudFront (e.g., example.com)
variable "domain_name" {
  description = "Domain name for the CloudFront distribution"
  type        = string
}