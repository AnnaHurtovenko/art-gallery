resource "aws_ecs_cluster" "main" {
  name = "art-gallery"

  tags = {
    Environment = var.environment
    Project     = var.project_tag
  }
}

