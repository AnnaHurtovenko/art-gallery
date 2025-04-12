module "this" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = var.vpc_name
  cidr = var.cidr_block
  azs  = var.azs

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_vpn_gateway   = false

  tags = merge(var.tags, {
    Project = "art-gallery"
  })

  public_subnet_tags = {
    Network = "public"
  }

  private_subnet_tags = {
    Network = "private"
  }
}

  