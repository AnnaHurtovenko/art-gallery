resource "aws_db_subnet_group" "private" {
  name       = "private-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = "private-db-subnet-group"
    Environment = "production"
  }
}

resource "aws_db_instance" "postgresql" {
  identifier              = var.postgresql_identifier
  engine                  = "postgres"
  engine_version          = var.postgresql_engine_version
  instance_class          = var.postgresql_instance_class
  allocated_storage       = var.postgresql_allocated_storage
  db_name                 = var.postgresql_db_name
  username                = var.postgresql_username
  password                = var.postgresql_password
  db_port                 = var.postgresql_db_port
  multi_az                = var.postgresql_multi_az
  storage_type            = var.postgresql_storage_type
  skip_final_snapshot     = var.postgresql_skip_final_snapshot
  backup_retention_period = var.postgresql_backup_retention_period

  db_subnet_group_name    = aws_db_subnet_group.private.name
  vpc_security_group_ids  = [var.rds_security_group_id]

  tags = {
    Name        = "postgresql-instance"
    Environment = "production"
  }
}
