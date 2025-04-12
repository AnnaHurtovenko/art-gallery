# ECR - Frontend
resource "aws_ecr_repository" "frontend" {
  name                 = "frontend"
  image_tag_mutability = "MUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name        = "frontend"
    Environment = "production"
  }
}

# ECR - Backend RDS
resource "aws_ecr_repository" "backend_rds" {
  name                 = "backend-rds"
  image_tag_mutability = "MUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name        = "backend-rds"
    Environment = "production"
  }
}

# ECR - Backend Redis
resource "aws_ecr_repository" "backend_redis" {
  name                 = "backend-redis"
  image_tag_mutability = "MUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name        = "backend-redis"
    Environment = "production"
  }
}
