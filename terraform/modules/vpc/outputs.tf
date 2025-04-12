output "vpc_id" {
  description = "ID of the VPC"
  value       = module.this.vpc_id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.this.public_subnets
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.this.private_subnets
}

output "nat_public_ips" {
  description = "List of public IPs of NAT Gateways"
  value       = module.this.nat_public_ips
}
