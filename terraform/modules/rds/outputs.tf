output "rds_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = aws_db_instance.postgresql.endpoint
}

output "rds_port" {
  description = "RDS PostgreSQL port"
  value       = aws_db_instance.postgresql.port
}

output "rds_db_name" {
  description = "RDS PostgreSQL DB name"
  value       = aws_db_instance.postgresql.db_name
}
