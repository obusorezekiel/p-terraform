# Output the endpoint of the RDS MySQL instance, which can be used to connect to the database.
# This is useful for applications that need to interact with the database.
output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.mysql.endpoint
}

# Output the ARN (Amazon Resource Name) of the RDS MySQL instance.
# The ARN uniquely identifies the database instance and is useful for logging, monitoring, or further resource management.
output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.mysql.arn
}

# Output the ARN of the Secrets Manager secret that stores the database credentials.
# This allows for easy access to the database credentials from other services or tools.
output "db_secret_arn" {
  description = "The ARN of the secret storing the database credentials"
  value       = aws_secretsmanager_secret.db_password.arn
}

