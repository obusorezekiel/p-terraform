variable "domain_name" {
  description = "The domain name for the application (e.g., example.com)"
  type        = string
  default     = "mytoolings.xyz"
}

variable "environment" {
  description = "The Code Env"
  type        = string
}

variable "public_sn_count" {
  description = "The Public Subnet Count"
  type        = number
}

variable "private_sn_count" {
  description = "The Private Subnet Count"
  type        = number
}

variable "db_subnet_group" {
  description = "The db subnet group creation"
  type        = bool
}

variable "lb_sg_name" {
  description = "lb_sg_name"
  type        = string
}

variable "backend_sg_name" {
  description = "complex_backend_ecs_sg"
  type        = string
}

variable "rds_sg_name" {
  description = "complex_rds_sg"
  type        = string
}

variable "http_port" {
  description = "http_port"
  type        = number
}

variable "https_port" {
  description = "https_port"
  type        = number
}

variable "postgres_port" {
  description = "postgres_port"
  type        = number
}

variable "ingress_cidr_blocks" {
  description = "List of CIDR blocks allowed for ingress traffic"
  type        = list(string)
}

variable "egress_cidr_blocks" {
  description = "List of CIDR blocks allowed for egress traffic"
  type        = list(string)
}

variable "tg_http_port" {
  description = "HTTP port"
  type        = number
}

variable "tg_http_protocol" {
  description = "HTTP port"
  type        = string
}

variable "tg_https_port" {
  description = "HTTP port"
  type        = number
}

variable "tg_https_protocol" {
  description = "HTTPS port"
  type        = string
}

variable "listener_http_port" {
  description = "HTTP listener"
  type        = number
}

variable "listener_http_protocol" {
  description = "HTTP listener"
  type        = string
}

variable "listener_https_port" {
  description = "HTTP listener"
  type        = number
}

variable "listener_https_protocol" {
  description = "HTTP listener"
  type        = string
}

variable "ecs_cluster" {
  description = "DB idenitfier"
  type        = string
}

variable "task_family" {
  description = "my_task_family"
  type        = string
}

variable "app_name" {
  description = "app_name"
  type        = string
}

variable "container_image" {
  description = "app_name"
  type        = string
}

variable "container_port" {
  description = "app_name"
  type        = number
}

variable "identifier" {
  description = "identifier"
  type        = string
}

variable "engine_version" {
  description = "engine_version"
  type        = string
}

variable "instance_class" {
  description = "instance_class"
  type        = string
}

variable "db_port" {
  description = "port"
  type        = number
}

variable "allocated_storage" {
  description = "The amount of storage (in GB) allocated for the database instance"
  type        = number
}

variable "database_name" {
  description = "The name of the initial database to create in the instance"
  type        = string
}

variable "db_username" {
  description = "The master username for the database instance"
  type        = string
}


variable "skip_final_snapshot" {
  description = "Indicates whether to skip the final snapshot before deleting the database"
  type        = bool
}

variable "final_snapshot_identifier" {
  description = "The name of the final snapshot when the database is deleted"
  type        = string
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection for the database"
  type        = bool
}

variable "multi_az" {
  description = "Specifies if the database instance should be deployed across multiple availability zones"
  type        = bool
}

variable "publicly_accessible" {
  description = "Specifies if the database instance should be publicly accessible"
  type        = bool
}

variable "backup_retention_period" {
  description = "The number of days to retain backups for the database instance"
  type        = number
}

variable "backup_window" {
  description = "The daily time range during which automated backups are created"
  type        = string
}

variable "maintenance_window" {
  description = "The weekly time range (in UTC) during which system maintenance can occur"
  type        = string
}

variable "storage_encrypted" {
  description = "Enable encryption for the RDS instance"
  type        = bool
}