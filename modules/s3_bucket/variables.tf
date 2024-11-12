# variables.tf
variable "bucket_name" {
  description = "Name of the S3 bucket for terraform state"
  type        = string
}

variable "kms_key_id" {
  description = "KMS key ID for bucket encryption"
  type        = string
}

variable "environment" {
  description = "The environment for the resources"
  type        = string
}

