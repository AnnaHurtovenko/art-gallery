resource "aws_elasticache_subnet_group" "redis" {
  name       = "redis-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = "redis-subnet-group"
    Environment = var.environment
    Project     = var.project_tag
  }
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = var.redis_cluster_id
  engine               = "redis"
  engine_version       = var.redis_engine_version
  node_type            = var.redis_node_type
  num_cache_nodes      = 1
  parameter_group_name = var.redis_parameter_group
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis.name
  security_group_ids   = [var.redis_sg_id]

  snapshot_retention_limit = 0
  maintenance_window       = var.maintenance_window
  availability_zone        = var.availability_zone

  tags = {
    Name        = "redis-cluster"
    Environment = var.environment
    Project     = var.project_tag
  }
}
