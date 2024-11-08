data "aws_route53_zone" "main" {
  name         = "mytoolings.xyz"
  private_zone = false
}

locals {
  instance_type = "t2.small"
  location      = "us-east-1"
  environment   = var.environment
  vpc_cidr      = "10.0.0.0/16"
}

module "s3_bucket" {
  source      = "./modules/s3_bucket"
  bucket_name = "my-terraform-state-bucket"
  kms_key_id = module.kms.kms_key_arn
}

module "dynamodb_table" {
  source     = "./modules/dynamodb_table"
  table_name = "terraform-lock-table"
}

module "vpc" {
  source           = "./modules/vpc"
  environment      = local.environment
  vpc_cidr         = local.vpc_cidr
  public_sn_count  = var.public_sn_count
  private_sn_count = var.private_sn_count
  db_subnet_group  = var.db_subnet_group
}

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


module "certificate" {
  source      = "./modules/certificate"
  environment = local.environment
  domain_name = var.domain_name
  zone_id     = data.aws_route53_zone.main.zone_id
}

module "cloudfront" {
  source          = "./modules/cloudfront"
  environment     = local.environment
  alb_dns_name    = module.alb.load_balancer_dns_name
  certificate_arn = module.certificate.certificate_arn
  domain_name     = var.domain_name

  depends_on = [module.certificate]
}


module "alb" {
  source                  = "./modules/alb"
  lb_sg                   = module.sg.lb_security_group_id
  environment             = local.environment
  public_subnets          = module.vpc.public_subnet_ids
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
  private_subnets = module.vpc.private_subnet_ids
  ecs_sg          = module.sg.backend_security_group_id
}

module "kms" {
  source = "./modules/kms"
}

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
  db_subnet_group           = module.vpc.db_subnet_group_name
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


