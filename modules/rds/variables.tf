# Identifier for the database instance, typically a unique name or prefix for the DB instance.
variable "identifier" {
  description = "Identifier for the database instance"
  type        = string
}

# PostgreSQL engine version, specifying which version of PostgreSQL to run on the instance.
variable "engine_version" {
  description = "PostgreSQL engine version"
  type        = string
}

# The port used for connecting to the database. Commonly, 5432 is used for PostgreSQL.
variable "port" {
  description = "Database Port"
  type = number
}

# The instance class defines the type of EC2 instance for the RDS database, such as `db.t3.medium`.
variable "instance_class" {
  description = "The instance type for the database"
  type        = string
}

# The allocated storage specifies how much storage the database will be provisioned with in gigabytes.
variable "allocated_storage" {
  description = "Allocated storage in gigabytes"
  type        = number
}

# The name of the database to create when the RDS instance is launched.
variable "database_name" {
  description = "The name of the database to create"
  type        = string
}

# The username for accessing the database, required for DB creation and login.
variable "db_username" {
  description = "Username for the database"
  type        = string
}

# DB subnet group name, used for defining which subnets the RDS instance should be placed in.
variable "db_subnet_group" {
  description = "DB subnet group name"
  type        = string
}

# A list of VPC security group IDs that should be associated with the database instance.
variable "security_group" {
  description = "List of VPC security group IDs to associate with the DB instance"
  type        = list(string)
}

# A flag indicating whether to skip taking a final snapshot when the DB instance is deleted.
variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot on deletion"
  type        = bool
}

# The environment for the resources, used to differentiate between environments like dev, prod, etc.
variable "environment" {
  description = "The environment for the resources"
  type        = string
}

# The identifier used for the final snapshot when the database is deleted.
variable "final_snapshot_identifier" {
  description = "final_snapshot_identifier"
  type = string
}

# A flag to enable or disable deletion protection on the DB instance to prevent accidental deletion.
variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
}

# Whether to create a Multi-AZ deployment for high availability.
variable "multi_az" {
  description = "Create a multi-AZ deployment"
  type        = bool
}

# A flag indicating whether the DB instance should be publicly accessible.
variable "publicly_accessible" {
  description = "Whether the DB instance is publicly accessible"
  type        = bool
}

# The number of days to retain backups of the RDS instance.
variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
}

# The time window in UTC during which backups are performed, for example, '00:00-00:30'.
variable "backup_window" {
  description = "Backup window in UTC (e.g., '00:00-00:30')"
  type        = string
}

# The maintenance window for the DB instance, when patches or updates are applied.
variable "maintenance_window" {
  description = "Maintenance window in UTC (e.g., 'sun:23:00-sun:23:30')"
  type        = string
}

# A flag indicating whether the storage of the RDS instance should be encrypted.
variable "storage_encrypted" {
  description = "Enable encryption for the RDS instance"
  type        = bool
}

# The KMS key ID used for encryption of the RDS instance storage.
variable "kms_key_id" {
    description = "Key for KMS cluster"
    type = string
}

