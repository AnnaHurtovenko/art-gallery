resource "aws_lb" "frontend" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups  # Прив'язка секюріті групи до ALB
  subnets            = var.subnets  # Публічні сaбнети для ALB

  enable_deletion_protection = var.deletion_protection
  idle_timeout = var.idle_timeout


  tags = var.tags
}

resource "aws_lb_listener" "frontend_http" {
  load_balancer_arn = aws_lb.frontend.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
}


resource "aws_lb_target_group" "frontend" {
  name        = var.target_group_name
  port        = 8002
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id  # VPC for connection

  health_check {
    interval            = 30
    path                = var.health_check_path
    port                = 8002
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = var.tags
}


