output "alb_arn" {
  description = "The ARN of the ALB"
  value       = aws_lb.frontend.arn
}

output "http_listener_arn" {
  description = "The ARN of the HTTP listener"
  value       = aws_lb_listener.frontend_http.arn
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.frontend.arn
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.frontend.dns_name
}
