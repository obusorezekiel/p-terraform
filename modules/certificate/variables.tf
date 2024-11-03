variable "domain_name" {
    description = "The main domain name"
    type = string
}

variable "zone_id" {
    description = "The Route53 zone ID"
    type = string
}

variable "environment" {
  description = "The environment for the resources"
  type        = string
}