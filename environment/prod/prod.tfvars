domain_name                = "mytoolings.xyz"
environment                = "dev"
public_sn_count            = 2
private_sn_count           = 2
db_subnet_group            = true
lb_sg_name                 = "lb_sg_name"
backend_sg_name            = "complex_backend_ecs_sg"
rds_sg_name             = "complex_rds_sg"
http_port                  = 80
https_port                 = 443
postgres_port              = 3306
ingress_cidr_blocks        = ["0.0.0.0/0"]
egress_cidr_blocks         = ["0.0.0.0/0"]
tg_http_port               = 80
tg_http_protocol           = "HTTP"
tg_https_port              = 443
tg_https_protocol          = "HTTPS"
listener_http_port         = 80
listener_http_protocol     = "HTTP"
listener_https_port        = 443
listener_https_protocol    = "HTTPS"
ecs_cluster                = "complex_ecs_cluster"
task_family                = "my_task_family"
app_name                   = "nginx"
container_image            = "nginx"
container_port             = 80
identifier                 = "my-rds-identifier"
engine_version             = "8.0.34"
instance_class             = "db.t3.medium"
db_port                    = 3306
allocated_storage          = 20
database_name              = "complex_db"
db_username                = "my_user_admin"
skip_final_snapshot        = false
final_snapshot_identifier  = "complex-db-snapshot"
deletion_protection        = false
multi_az                   = true
publicly_accessible        = false
backup_retention_period    = 7
backup_window              = "00:00-00:30"
maintenance_window         = "sun:23:00-sun:23:30"
storage_encrypted          = true