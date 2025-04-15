# modules/ecs/outputs.tf

output "cloud_map_frontend_arn" {
  value       = aws_service_discovery_service.frontend.arn
  description = "ARN of the Cloud Map frontend service"
}

output "cloud_map_backend_rds_arn" {
  value       = aws_service_discovery_service.backend_rds.arn
  description = "ARN of the Cloud Map backend-rds service"
}

output "cloud_map_backend_redis_arn" {
  value       = aws_service_discovery_service.backend_redis.arn
  description = "ARN of the Cloud Map backend-redis service"
}

output "cloud_map_namespace_id" {
  description = "ID of the Cloud Map DNS namespace"
  value       = aws_service_discovery_private_dns_namespace.main.id
}

output "ecs_cluster_id" {
  description = "ID of the ECS Cluster"
  value       = aws_ecs_cluster.main.id
}

