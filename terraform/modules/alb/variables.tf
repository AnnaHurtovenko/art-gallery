variable "lb_name" {
  description = "The name of the load balancer"
  type        = string
}

variable "security_groups" {
  description = "The security groups for the load balancer"
  type        = list(string)
}

variable "subnets" {
  description = "The subnets for the load balancer"
  type        = list(string)
}

variable "deletion_protection" {
  description = "Enable deletion protection for the load balancer"
  type        = bool
  default     = false
}

variable "idle_timeout" {
  description = "The idle timeout for the load balancer"
  type        = number
  default     = 60
}

variable "target_group_name" {
  description = "The name of the target group"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the target group will be created"
  type        = string
}

variable "health_check_path" {
  description = "The health check path for the target group"
  type        = string
  default     = "/"
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
}


