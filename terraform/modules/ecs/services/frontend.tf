resource "aws_ecs_task_definition" "frontend" {
  family                   = "frontend-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "frontend"
      image     = var.frontend_image
      portMappings = [
        {
          containerPort = 8002
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/art-gallery"
          awslogs-region        = var.region
          awslogs-stream-prefix = "frontend"
        }
      }
      environment = var.frontend_env_vars
    }
  ])
}

resource "aws_ecs_service" "frontend" {
  name            = "frontend-service"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.frontend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.private_subnets
    security_groups = [var.ecs_sg_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.frontend_tg_arn
    container_name   = "frontend"
    container_port   = 8002
  }

  service_registries {
    registry_arn = var.cloud_map_frontend_arn
  }

  depends_on = [
    aws_ecs_task_definition.frontend,
    aws_lb.frontend,
    aws_lb_target_group.frontend,
    aws_lb_listener.frontend_http
  ]
}



