variable "environment" {
  type        = string
  description = "Name of the environment "
  default     = "production"
}

variable "project_tag" {
  type        = string
  description = "Проєкт для Tagging"
  default     = "art-gallery"
}

# ECS Task Execution Role
variable "ecs_execution_role_name" {
  type        = string
  description = "Ім'я ECS Execution Role"
  default     = "ecsTaskExecutionRole"
}


variable "attach_cloudwatch_logs_for_execution" {
  type        = bool
  description = "CloudWatchLogsFullAccess for ECS Execution Role"
  default     = true
}

# ECS Task Role (App Role)
variable "create_ecs_task_role" {
  type        = bool
  description = "Create ECS Task Role"
  default     = true
}

variable "ecs_task_role_name" {
  type        = string
  description = "Ім'я ECS Task Role"
  default     = "ecsTaskAppRole"
}




