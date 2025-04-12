resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/art-gallery"
  retention_in_days = 14

  tags = {
    Environment = var.environment
    Project     = var.project_tag
    Service     = "ECS"
  }
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "HighCPUUsage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This alarm monitors high CPU usage in ECS tasks"
  dimensions = {
    ClusterName = var.ecs_cluster_name
  }
  alarm_actions = var.alarm_actions
  ok_actions    = var.alarm_actions

  tags = {
    Environment = var.environment
    Project     = var.project_tag
  }
}
