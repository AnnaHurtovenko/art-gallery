# backend-rds
resource "aws_ecs_task_definition" "backend_rds" {
  family                   = "backend-rds-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "backend-rds"
      image     = var.backend_rds_image
      portMappings = [
        {
          containerPort = 8000
          protocol       = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/art-gallery"
          awslogs-region        = var.region
          awslogs-stream-prefix = "backend-rds"
        }
      }
      environment = var.backend_rds_env_vars
    }
  ])
}

resource "aws_ecs_service" "backend_rds" {
  name            = "backend-rds-service"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.backend_rds.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.private_subnets
    security_groups = [var.ecs_sg_id]
    assign_public_ip = false
  }

  service_registries {
    registry_arn = var.cloud_map_backend_rds_arn
  }

  depends_on = [aws_ecs_task_definition.backend_rds]
}

