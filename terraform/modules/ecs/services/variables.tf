# === Загальні для всіх сервісів ===
variable "execution_role_arn" {
  description = "IAM execution role ARN for ECS task"
  type        = string
}

variable "ecs_cluster_id" {
  description = "ECS Cluster ID"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "ecs_sg_id" {
  description = "Security Group ID for ECS tasks"
  type        = string
}

# === FRONTEND ===
variable "frontend_image" {
  description = "Docker image for frontend"
  type        = string
  default     = "615299759149.dkr.ecr.us-east-1.amazonaws.com/frontend:placeholder"
}

variable "frontend_env_vars" {
  description = "Environment variables for frontend"
  type        = list(object({ name = string, value = string }))
  default     = []
}

variable "cloud_map_frontend_arn" {
  description = "Cloud Map ARN for frontend"
  type        = string
  default     = null
}

variable "frontend_tg_arn" {
  description = "Target Group ARN for frontend"
  type        = string
  default     = null
}

# === BACKEND RDS ===
variable "backend_rds_image" {
  description = "Docker image for backend-rds"
  type        = string
  default     = "615299759149.dkr.ecr.us-east-1.amazonaws.com/backend-rds:placeholder"
}

variable "backend_rds_env_vars" {
  description = "Environment variables for backend-rds"
  type        = list(object({ name = string, value = string }))
  default     = []
}

variable "cloud_map_backend_rds_arn" {
  description = "Cloud Map ARN for backend-rds"
  type        = string
  default     = null
}

# === BACKEND REDIS ===
variable "backend_redis_image" {
  description = "Docker image for backend-redis"
  type        = string
  default     = "615299759149.dkr.ecr.us-east-1.amazonaws.com/backend-redis:placeholder"
}

variable "backend_redis_env_vars" {
  description = "Environment variables for backend-redis"
  type        = list(object({ name = string, value = string }))
  default     = []
}

variable "cloud_map_backend_redis_arn" {
  description = "Cloud Map ARN for backend-redis"
  type        = string
  default     = null
}
