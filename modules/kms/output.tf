output "kms_key_arn" {
  description = "ARN of the KMS Service"
  value = aws_kms_key.kms_key.arn
}