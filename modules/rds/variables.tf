variable "identifier" {
  description = "Identifier for the database instance"
  type        = string
}

variable "engine_version" {
  description = "PostgreSQL engine version"
  type        = string
}

variable "port" {
  description = "Database Port"
  type = number
}

variable "instance_class" {
  description = "The instance type for the database"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage in gigabytes"
  type        = number
}

variable "database_name" {
  description = "The name of the database to create"
  type        = string
}

variable "db_username" {
  description = "Username for the database"
  type        = string
}

variable "db_subnet_group" {
  description = "DB subnet group name"
  type        = string
}

variable "security_group" {
  description = "List of VPC security group IDs to associate with the DB instance"
  type        = list(string)
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot on deletion"
  type        = bool
}

variable "environment" {
  description = "The environment for the resources"
  type        = string
}

variable "final_snapshot_identifier" {
  description = "final_snapshot_identifier"
  type = string
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
}

variable "multi_az" {
  description = "Create a multi-AZ deployment"
  type        = bool
}

variable "publicly_accessible" {
  description = "Whether the DB instance is publicly accessible"
  type        = bool
}

variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
}

variable "backup_window" {
  description = "Backup window in UTC (e.g., '00:00-00:30')"
  type        = string
}

variable "maintenance_window" {
  description = "Maintenance window in UTC (e.g., 'sun:23:00-sun:23:30')"
  type        = string
}

variable "storage_encrypted" {
  description = "Enable encryption for the RDS instance"
  type        = bool
}