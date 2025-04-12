# Основні змінні середовища
variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
  default     = "production"
}

variable "project_tag" {
  description = "Project tag for all ECS resources"
  type        = string
  default     = "art-gallery"
}

variable "region" {
  description = "AWS Region"
  type        = string
}

# ECS кластер
variable "ecs_cluster_id" {
  description = "ID of the ECS cluster"
  type        = string
}

# Підмережі та безпека
variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
}

variable "ecs_sg_id" {
  description = "Security Group ID used by ECS tasks"
  type        = string
}

# Роль для виконання ECS тасків
variable "execution_role_arn" {
  description = "ARN of the IAM execution role for ECS tasks"
  type        = string
}

# Cloud Map
variable "cloud_map_frontend_arn" {
  description = "Cloud Map ARN for frontend"
  type        = string
}

variable "cloud_map_backend_rds_arn" {
  description = "Cloud Map ARN for backend-rds"
  type        = string
}

variable "cloud_map_backend_redis_arn" {
  description = "Cloud Map ARN for backend-redis"
  type        = string
}

# Target Group ARN (ALB для frontend)
variable "frontend_tg_arn" {
  description = "Target group ARN for frontend container"
  type        = string
}

# Контейнерні образи
variable "frontend_image" {
  description = "Docker image for the frontend container"
  type        = string
}

variable "backend_rds_image" {
  description = "Docker image for the backend-rds container"
  type        = string
}

variable "backend_redis_image" {
  description = "Docker image for the backend-redis container"
  type        = string
}

# ENV-перемінні для контейнерів
variable "frontend_env_vars" {
  description = "Environment variables for the frontend container"
  type        = list(object({ name = string, value = string }))
  default     = []
}

variable "backend_rds_env_vars" {
  description = "Environment variables for the backend-rds container"
  type        = list(object({ name = string, value = string }))
  default     = []
}

variable "backend_redis_env_vars" {
  description = "Environment variables for the backend-redis container"
  type        = list(object({ name = string, value = string }))
  default     = []
}
