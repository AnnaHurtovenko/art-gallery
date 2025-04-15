resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/art-gallery"
  retention_in_days = 14

  tags = {
    Environment = var.environment
    Project     = var.project_tag
    Service     = "ECS"
  }
}