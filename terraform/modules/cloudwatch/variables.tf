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

variable "ecs_cluster_name" {
  description = "ECS Cluster name for metrics"
  type        = string
}

variable "alarm_actions" {
  description = "List of actions to trigger when alarm state is ALARM or OK"
  type        = list(string)
  default     = []
}




