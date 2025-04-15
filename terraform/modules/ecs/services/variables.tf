# === Загальні змінні для ECS сервісу ===

variable "service_name" {
  description = "Name of the ECS service and container"
  type        = string
}

variable "container_image" {
  description = "Docker image for the service"
  type        = string
}

variable "container_env_vars" {
  description = "Environment variables for the container"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
}

variable "execution_role_arn" {
  description = "IAM execution role ARN for ECS task"
  type        = string
}

variable "ecs_cluster_id" {
  description = "ID of the ECS cluster"
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

variable "cloud_map_service_arn" {
  description = "ARN of Cloud Map service for ECS service discovery"
  type        = string
}

variable "target_group_arn" {
  description = "ALB Target Group ARN if load balancer is used"
  type        = string
  default     = null
}

variable "task_role_arn" {
  description = "IAM Task Role ARN used by the container"
  type        = string
}

variable "cloudwatch_log_group_name" {
  description = "CloudWatch Log Group name for ECS Exec"
  type        = string
}
