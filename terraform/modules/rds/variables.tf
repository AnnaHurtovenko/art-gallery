variable "postgresql_identifier" {
  description = "The identifier for the PostgreSQL database instance"
  type        = string
  default     = "artgallery-db"
}

variable "postgresql_engine_version" {
  description = "PostgreSQL engine version"
  type        = string
  default     = "13.3"
}

variable "postgresql_instance_class" {
  description = "Instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "postgresql_allocated_storage" {
  description = "Storage in GB"
  type        = number
  default     = 20
}

variable "postgresql_db_name" {
  description = "Name of the database"
  type        = string
  default     = "artgallery"
}

variable "postgresql_username" {
  description = "Master username"
  type        = string
  default     = "postgres"
}

variable "postgresql_password" {
  description = "Master password"
  type        = string
  sensitive   = true
}

variable "postgresql_db_port" {
  description = "Port"
  type        = number
  default     = 5432
}

variable "postgresql_multi_az" {
  description = "Enable multi-AZ deployment"
  type        = bool
  default     = false
}

variable "postgresql_storage_type" {
  description = "Storage type"
  type        = string
  default     = "gp2"
}

variable "postgresql_skip_final_snapshot" {
  description = "Skip final snapshot"
  type        = bool
  default     = true
}

variable "postgresql_backup_retention_period" {
  description = "Backup retention (in days)"
  type        = number
  default     = 0
}

# From VPC module
variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

# From security groups module
variable "rds_security_group_id" {
  description = "Security group ID for the RDS instance"
  type        = string
}
