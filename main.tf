# Keep the existing data source
data "aws_availability_zones" "available" {
  state = "available"
}

# Fetch the Route 53 DNS zone information for "mytoolings.xyz"
data "aws_route53_zone" "main" {
  name         = "mytoolings.xyz"
  private_zone = false
}

module "s3" {
  source      = "./modules/s3_bucket"
  bucket_name = "ezekiel-terraform-2024-bucket"
  kms_key_id  = module.kms.kms_key_arn
  environment = var.environment
}

module "dynamodb" {
  source     = "./modules/dynamodb_table"
  table_name = "terraform-locks"
}

# Module to create a VPC with the specified CIDR and subnet configuration
# Random integer resource remains unchanged
resource "random_integer" "random" {
    min = 1
    max = 10
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.vpc_name
  cidr = local.vpc_cidr

  azs             = local.azs
  public_subnets  = local.public_subnet_cidrs
  private_subnets = local.private_subnet_cidrs
  database_subnets = local.database_subnet_cidrs

  create_database_subnet_group = var.db_subnet_group
  database_subnet_group_name  = var.db_subnet_group ? local.db_subnet_group_name : null

  # NAT Gateway configuration
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  # DNS settings
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Public subnet configuration
  map_public_ip_on_launch = true

  # Tags
  tags = local.common_tags

  public_subnet_tags = merge(
    local.common_tags,
    {
      Name = local.public_subnet_name
      Tier = "Public"
    }
  )

  private_subnet_tags = merge(
    local.common_tags,
    {
      Name = local.private_subnet_name
      Tier = "Private"
    }
  )

  database_subnet_tags = merge(
    local.common_tags,
    {
      Name = local.database_subnet_name
      Tier = "Database"
    }
  )

  vpc_tags = merge(
    local.common_tags,
    {
      Name = local.vpc_name
    }
  )
}

# Module to create security groups for load balancer, backend ECS, and RDS
module "sg" {
  source              = "./modules/sg"
  vpc_id              = module.vpc.vpc_id
  lb_sg_name          = var.lb_sg_name
  backend_sg_name     = var.backend_sg_name
  rds_sg_name         = var.rds_sg_name
  environment         = local.environment
  http_port           = var.http_port
  https_port          = var.https_port
  mysql_port          = var.db_port
  ingress_cidr_blocks = var.ingress_cidr_blocks
  egress_cidr_blocks  = var.egress_cidr_blocks
}

# Module to create an SSL/TLS certificate using ACM
module "certificate" {
  source      = "./modules/certificate"
  environment = local.environment
  domain_name = var.domain_name
  zone_id     = data.aws_route53_zone.main.zone_id
}

# Module to create a CloudFront distribution with the ALB as the origin
module "cloudfront" {
  source          = "./modules/cloudfront"
  environment     = local.environment
  alb_dns_name    = module.alb.load_balancer_dns_name
  certificate_arn = module.certificate.certificate_arn
  domain_name     = var.domain_name

  depends_on = [module.certificate]
}

# Module to create an Application Load Balancer (ALB)
module "alb" {
  source                  = "./modules/alb"
  lb_sg                   = module.sg.lb_security_group_id
  environment             = local.environment
  public_subnets          = module.vpc.public_subnets
  vpc_id                  = module.vpc.vpc_id
  tg_http_port            = var.tg_http_port
  tg_http_protocol        = var.tg_http_protocol
  tg_https_port           = var.tg_https_port
  tg_https_protocol       = var.tg_https_protocol
  listener_http_port      = var.listener_http_port
  listener_http_protocol  = var.listener_http_protocol
  listener_https_port     = var.listener_https_port
  listener_https_protocol = var.listener_https_protocol
  certificate_arn         = module.certificate.certificate_arn

  depends_on = [module.certificate]
}

# Module to create ECS services and tasks within the VPC
module "ecs" {
  source          = "./modules/ecs"
  ecs_cluster     = var.ecs_cluster
  environment     = local.environment
  task_family     = var.task_family
  app_name        = var.app_name
  container_image = var.container_image
  container_port  = var.container_port
  tg_http_arn     = module.alb.http_target_group_arn
  tg_https_arn    = module.alb.https_target_group_arn
  private_subnets = module.vpc.private_subnets
  ecs_sg          = module.sg.backend_security_group_id
}

# Module to create a KMS key for encryption
module "kms" {
  source = "./modules/kms"
}

# Module to create an RDS database instance within the VPC
module "rds" {
  source                    = "./modules/rds"
  environment               = local.environment
  identifier                = var.identifier
  engine_version            = var.engine_version
  instance_class            = var.instance_class
  port                      = var.db_port
  allocated_storage         = var.allocated_storage
  database_name             = var.database_name
  db_username               = var.db_username
  db_subnet_group           = module.vpc.database_subnet_group_name
  security_group            = module.sg.rds_security_group_id
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier
  deletion_protection       = var.deletion_protection
  multi_az                  = var.multi_az
  publicly_accessible       = var.publicly_accessible
  backup_retention_period   = var.backup_retention_period
  backup_window             = var.backup_window
  maintenance_window        = var.maintenance_window
  storage_encrypted         = var.storage_encrypted
  kms_key_id                = module.kms.kms_key_arn
}


