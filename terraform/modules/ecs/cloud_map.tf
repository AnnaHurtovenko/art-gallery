# Приватний DNS namespace
resource "aws_service_discovery_private_dns_namespace" "main" {
  name        = "art-gallery.local"
  vpc         = var.vpc_id
  description = "Private DNS namespace for ECS services"

  tags = {
    Environment = var.environment
    Project     = var.project_tag
  }
}

# Cloud Map для frontend
resource "aws_service_discovery_service" "frontend" {
  name = "frontend"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.main.id
    dns_records {
      ttl  = 10
      type = "A"
    }
    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }

  tags = {
    Environment = var.environment
    Project     = var.project_tag
  }
}

# Cloud Map для backend-rds
resource "aws_service_discovery_service" "backend_rds" {
  name = "backend-rds"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.main.id
    dns_records {
      ttl  = 10
      type = "A"
    }
    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }

  tags = {
    Environment = var.environment
    Project     = var.project_tag
  }
}

# Cloud Map для backend-redis
resource "aws_service_discovery_service" "backend_redis" {
  name = "backend-redis"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.main.id
    dns_records {
      ttl  = 10
      type = "A"
    }
    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }

  tags = {
    Environment = var.environment
    Project     = var.project_tag
  }
}
