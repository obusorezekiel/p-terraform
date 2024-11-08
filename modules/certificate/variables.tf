# The Main Domain Name - The primary domain for the SSL certificate

variable "domain_name" {
    description = "The main domain name"
    type = string
}

# The Route 53 Zone ID - The ID of the hosted zone in Route 53 where the DNS records will be created
variable "zone_id" {
    description = "The Route53 zone ID"
    type = string
}

# Environment Specification - Specifies the environment (e.g., dev, prod) for the resources
variable "environment" {
  description = "The environment for the resources"
  type        = string
}