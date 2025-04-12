# backend-redis
resource "aws_ecs_task_definition" "backend_redis" {
  family                   = "backend-redis-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "backend-redis"
      image     = var.backend_redis_image
      portMappings = [
        {
          containerPort = 8001
          protocol       = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/art-gallery"
          awslogs-region        = var.region
          awslogs-stream-prefix = "backend-redis"
        }
      }
      environment = var.backend_redis_env_vars
    }
  ])
}

resource "aws_ecs_service" "backend_redis" {
  name            = "backend-redis-service"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.backend_redis.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.private_subnets
    security_groups = [var.ecs_sg_id]
    assign_public_ip = false
  }

  service_registries {
    registry_arn = var.cloud_map_backend_redis_arn
  }

  depends_on = [aws_ecs_task_definition.backend_redis]
}
dynamic "service_registries" {
  for_each = var.cloud_map_frontend_arn != null ? [1] : []
  content {
    registry_arn = var.cloud_map_frontend_arn
  }
}