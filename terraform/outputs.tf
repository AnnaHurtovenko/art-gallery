#VPC
output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}

output "public_subnets" {
  value       = module.vpc.public_subnets
  description = "List of public subnet IDs"
}

output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "List of private subnet IDs"
}

output "nat_public_ips" {
  value       = module.vpc.nat_public_ips
  description = "List of NAT public IPs"
}

#ECR
output "ecr_frontend_url" {
  value = module.ecr.frontend_url
}

output "ecr_backend_rds_url" {
  value = module.ecr.backend_rds_url
}

output "ecr_backend_redis_url" {
  value = module.ecr.backend_redis_url
}


#IAM
output "ecs_execution_role_arn" {
  value       = module.iam.ecs_execution_role_arn
  description = "ECS Task Execution Role ARN"
}

output "ecs_task_role_arn" {
  value       = module.iam.ecs_task_role_arn
  description = "ECS Task Role ARN (optional)"
}


#ECS
output "ecs_cluster_id" {
  value       = module.ecs.ecs_cluster_id
  description = "ID of the ECS cluster"
}

output "cloud_map_frontend_arn" {
  value       = module.ecs.cloud_map_frontend_arn
}

output "cloud_map_backend_rds_arn" {
  value       = module.ecs.cloud_map_backend_rds_arn
}

output "cloud_map_backend_redis_arn" {
  value       = module.ecs.cloud_map_backend_redis_arn
}


#ALB
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

