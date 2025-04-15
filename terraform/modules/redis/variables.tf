variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "redis_cluster_id" {
  description = "The name of the Redis cluster"
  type        = string
  default     = "artgallery-redis"
}

variable "redis_engine_version" {
  description = "Redis engine version"
  type        = string
  default     = "7.2"
}

variable "redis_node_type" {
  description = "Node type (instance class)"
  type        = string
  default     = "cache.t4g.micro"
}

variable "redis_parameter_group" {
  description = "Redis parameter group name"
  type        = string
  default     = "default.redis7"
}

variable "redis_sg_id" {
  description = "Security Group ID for Redis"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "project_tag" {
  description = "Project tag"
  type        = string
}

variable "maintenance_window" {
  description = "Maintenance window for Redis"
  type        = string
  default     = "sun:05:00-sun:09:00"
}

variable "availability_zone" {
  description = "AZ for Redis"
  type        = string
  default     = "us-east-1a"
}
