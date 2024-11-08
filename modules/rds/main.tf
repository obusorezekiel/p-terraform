# Generate a random password for the database with a length of 16 characters
# including special characters for enhanced security.
resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}


# Create a Secrets Manager secret to store the generated database password
# The secret name is based on the identifier and the environment to distinguish between different instances.
resource "aws_secretsmanager_secret" "db_password" {
  name = "${var.identifier}-db"

  tags = {
    Name        = "${var.identifier}-db-password-${var.environment}"
    Environment = var.environment
  }
}

# Store the generated password as a version in Secrets Manager
# This is the initial version of the database password.
resource "aws_secretsmanager_secret_version" "initial_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = random_password.db_password.result
}

# Create an AWS RDS MySQL instance with configurations specified in the variables
# The instance is provisioned with a generated password from the Secrets Manager.
resource "aws_db_instance" "mysql" {
  identifier              = var.identifier
  engine                  = "mysql"
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage        = var.allocated_storage

  db_name                 = var.database_name
  username                = var.db_username
  password                = random_password.db_password.result

  db_subnet_group_name    = var.db_subnet_group
  vpc_security_group_ids   = var.security_group

  skip_final_snapshot     = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier
  deletion_protection     = var.deletion_protection
  multi_az                = var.multi_az
  publicly_accessible      = var.publicly_accessible

  backup_retention_period  = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window
  storage_encrypted        = var.storage_encrypted
  kms_key_id               = var.kms_key_id

  tags = {
    Name        = "${var.identifier}-mysql-${var.environment}"
    Environment = var.environment
  }
}

# Store the database connection details in Secrets Manager
# The secret contains the username, password, engine, host, port, and database name for easy access.
resource "aws_secretsmanager_secret_version" "db_password_details" {
  secret_id = aws_secretsmanager_secret.db_password.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db_password.result
    engine   = "mysql"
    host     = aws_db_instance.mysql.endpoint
    port     = var.port
    dbname   = var.database_name
  })

  depends_on = [aws_db_instance.mysql]
}
