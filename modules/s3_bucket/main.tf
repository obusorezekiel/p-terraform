# S3 bucket for terraform state
resource "aws_s3_bucket" "tf_state" {
  bucket = var.bucket_name

  tags = {
      Name = "Terraform State Bucket-${var.environment}"
      Environment = var.environment
    }
}

# Enable versioning on the S3 bucket
resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable KMS encryption on the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_encryption" {
  bucket = aws_s3_bucket.tf_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = var.kms_key_id
    }
  }
}

# Block public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "tf_state_public_access_block" {
  bucket = aws_s3_bucket.tf_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}