# Create a KMS key for RDS encryption
resource "aws_kms_key" "kms_key" {
  description = "KMS key for encrypting RDS database and S3"
}
