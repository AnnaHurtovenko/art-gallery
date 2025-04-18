resource "aws_ecs_cluster" "main" {
  name = "art-gallery"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  configuration {
    execute_command_configuration {
      logging = "OVERRIDE"

      log_configuration {
        cloud_watch_log_group_name     = var.cloudwatch_log_group_name
        cloud_watch_encryption_enabled = false
      }
    }
  }

  tags = {
    Environment = var.environment
    Project     = var.project_tag
  }
}
