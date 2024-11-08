variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket for Terraform state"
}

variable "kms_key_id" {
  type        = string
  description = "The KMS key ID for bucket encryption"
}