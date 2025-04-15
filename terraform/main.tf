provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  vpc_name           = var.vpc_name
  cidr_block         = var.cidr_block
  azs                = var.azs
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
  tags               = var.tags
}

locals {
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source = "./modules/alb"

  lb_name             = "frontend-alb"
  security_groups     = [aws_security_group.alb_sg.id]
  subnets             = module.vpc.public_subnets
  deletion_protection = false
  idle_timeout        = 60

  target_group_name = "frontend-target-group"
  vpc_id            = module.vpc.vpc_id
  health_check_path = "/"
  tags              = var.tags
}

module "ecr" {
  source = "./modules/ecr"
}

module "iam" {
  source = "./modules/iam"

  environment                          = var.environment
  project_tag                          = var.project_tag
  ecs_execution_role_name              = "ecsTaskExecutionRole"
  attach_cloudwatch_logs_for_execution = true
  create_ecs_task_role                 = true
  ecs_task_role_name                   = "ecsTaskAppRole"
}

module "ecs" {
  source      = "./modules/ecs"
  environment = var.environment
  project_tag = var.project_tag
  vpc_id      = module.vpc.vpc_id
  region      = var.region
}

module "ecs_frontend" {
  source                = "./modules/ecs/services"
  service_name          = "frontend"
  container_image       = module.ecr.frontend_url
  container_port        = 8002
  execution_role_arn    = module.iam.ecs_execution_role_arn
  task_role_arn         = module.iam.ecs_task_role_arn
  ecs_cluster_id        = module.ecs.ecs_cluster_id
  region                = var.region
  private_subnets       = module.vpc.private_subnets
  ecs_sg_id             = aws_security_group.ecs_sg.id
  cloud_map_service_arn = module.ecs.cloud_map_frontend_arn
  target_group_arn      = module.alb.target_group_arn

  container_env_vars = [
    {
      name  = "BACKEND_RDS_URL"
      value = "http://backend-rds.art-gallery.local:8000/test_connection/"
    },
    {
      name  = "BACKEND_REDIS_URL"
      value = "http://backend-redis.art-gallery.local:8001/test_connection/"
    }
  ]
}

module "ecs_backend_rds" {
  source                = "./modules/ecs/services"
  service_name          = "backend-rds"
  container_image       = module.ecr.backend_rds_url
  container_port        = 8000
  execution_role_arn    = module.iam.ecs_execution_role_arn
  task_role_arn         = module.iam.ecs_task_role_arn
  ecs_cluster_id        = module.ecs.ecs_cluster_id
  region                = var.region
  private_subnets       = module.vpc.private_subnets
  ecs_sg_id             = aws_security_group.ecs_sg.id
  cloud_map_service_arn = module.ecs.cloud_map_backend_rds_arn

  container_env_vars = [
    {
      name  = "DB_NAME"
      value = "artgallery"
    },
    {
      name  = "DB_USER"
      value = "postgres"
    },
    {
      name  = "DB_PASSWORD"
      value = var.rds_password
    },
    {
      name  = "DB_HOST"
      value = module.rds.rds_endpoint
    },
    {
      name  = "DB_PORT"
      value = "5432"
    },
    {
      name  = "CORS_ALLOWED_ORIGINS"
      value = "http://frontend-alb-2106881837.us-east-1.elb.amazonaws.com/"
    }
  ]
}



module "ecs_backend_redis" {
  source                = "./modules/ecs/services"
  service_name          = "backend-redis"
  container_image       = module.ecr.backend_redis_url
  container_port        = 8001
  execution_role_arn    = module.iam.ecs_execution_role_arn
  task_role_arn         = module.iam.ecs_task_role_arn
  ecs_cluster_id        = module.ecs.ecs_cluster_id
  region                = var.region
  private_subnets       = module.vpc.private_subnets
  ecs_sg_id             = aws_security_group.ecs_sg.id
  cloud_map_service_arn = module.ecs.cloud_map_backend_redis_arn

  container_env_vars = [
    {
      name  = "REDIS_HOST"
      value = "backend-redis.art-gallery.local"
    },
    {
      name  = "REDIS_PORT"
      value = "6379"
    },
    {
      name  = "REDIS_DB"
      value = "0"
    },
    {
      name  = "CORS_ALLOWED_ORIGINS"
      value = "http://frontend-alb-2106881837.us-east-1.elb.amazonaws.com/"
    }
  ]
}



module "rds" {
  source                             = "./modules/rds"
  postgresql_password                = var.rds_password
  private_subnet_ids                 = module.vpc.private_subnets
  rds_security_group_id              = aws_security_group.rds_sg.id
  postgresql_identifier              = "artgallery-db"
  postgresql_db_name                 = "artgallery"
  postgresql_allocated_storage       = 20
  postgresql_instance_class          = "db.t3.micro"
  postgresql_engine_version          = "17.2"
  postgresql_multi_az                = false
  postgresql_skip_final_snapshot     = true
  postgresql_backup_retention_period = 0
}

module "cloudwatch" {
  source           = "./modules/cloudwatch"
  environment      = var.environment
  project_tag      = var.project_tag
  ecs_cluster_name = "art-gallery-cluster"
  alarm_actions    = []
}
