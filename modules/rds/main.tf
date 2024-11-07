resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Create a KMS key for RDS encryption
resource "aws_kms_key" "rds_key" {
  description = "KMS key for encrypting RDS database"
}

# Store password in Secrets Manager
resource "aws_secretsmanager_secret" "db_password" {
  name = "${var.identifier}-db-password"

  tags = {
    Name        = "${var.identifier}-db-password-${var.environment}"
    Environment = var.environment
  }
}

# Store initial password version
resource "aws_secretsmanager_secret_version" "initial_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = random_password.db_password.result
}

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
  kms_key_id               = aws_kms_key.rds_key.arn

  tags = {
    Name        = "${var.identifier}-mysql-${var.environment}"
    Environment = var.environment
  }
}

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
