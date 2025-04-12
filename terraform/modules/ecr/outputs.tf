output "frontend_url" {
  value = aws_ecr_repository.frontend.repository_url
}

output "backend_rds_url" {
  value = aws_ecr_repository.backend_rds.repository_url
}

output "backend_redis_url" {
  value = aws_ecr_repository.backend_redis.repository_url
}
