variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"
}

variable "project_tag" {
  description = "Project tag"
  type        = string
  default     = "art-gallery"
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "cloudwatch_log_group_name" {
  description = "CloudWatch Log Group name for ECS Exec"
  type        = string
}
