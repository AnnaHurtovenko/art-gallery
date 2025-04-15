output "ecs_execution_role_arn" {
  description = "ARN ECS Execution Role"
  value       = aws_iam_role.ecs_execution_role.arn
}

output "ecs_task_role_arn" {
  description = "ARN ECS Task Role"
  value       = length(aws_iam_role.ecs_task_role) > 0 ? aws_iam_role.ecs_task_role[0].arn : null
}
