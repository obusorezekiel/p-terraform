variable "vpc_cidr" {
    type = string
}

variable "environment" {
  description = "The environment for the resources"
  type        = string
}

variable "public_sn_count" {
    type = number
}

variable "private_sn_count" {
  type = number
}

variable "db_subnet_group" {
  type = bool
}