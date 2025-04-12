# VPC
variable "cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "gallery"
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnets" {
  description = "CIDRs for public subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "private_subnets" {
  description = "CIDRs for private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "enable_nat_gateway" {
  description = "Enable NAT gateway"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Use one NAT gateway for all private subnets"
  type        = bool
  default     = true
}

# Region
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# Tags
variable "tags" {
  description = "Global tags for resources"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "production"
  }
}

# ACM Certificate
variable "ssl_certificate_arn" {
  description = "ARN of the ACM SSL certificate"
  type        = string
}

# IAM, ECS, RDS
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "project_tag" {
  description = "Project name for tagging"
  type        = string
  default     = "art-gallery"
}

variable "rds_password" {
  description = "Password for RDS"
  type        = string
  sensitive   = true
}

# CloudWatch
variable "alarm_actions" {
  description = "SNS topic ARNs for CloudWatch alarms"
  type        = list(string)
  default     = []
}
