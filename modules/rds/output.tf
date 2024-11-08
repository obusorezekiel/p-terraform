# outputs.tf
output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.mysql.endpoint
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.mysql.arn
}

output "db_secret_arn" {
  description = "The ARN of the secret storing the database credentials"
  value       = aws_secretsmanager_secret.db_password.arn
}

