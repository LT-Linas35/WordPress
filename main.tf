# Terraform configuration file for provisioning VPC, ALB, EC2, RDS, Redis, and security groups

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.70.0" # Ensure compatibility with AWS provider version 5.70.0
    }
  }
}

##########################################################################
# Modules for VPC and Networking
##########################################################################

# Main VPC module, responsible for creating VPC
module "vpc" {
  source                  = "./modules/vpc"
  aws_vpc_main_cidr_block = var.vpc.aws_vpc_main_cidr_block
  aws_vpc_main_name       = var.vpc.aws_vpc_main_name
  Environment             = var.Environment
  ManagedBy               = var.ManagedBy
}

# VPC subnet and configuration for Redis
module "vpc_redis" {
  source                                               = "./modules/vpc/redis"
  aws_vpc_main_id                                      = module.vpc.aws_vpc_main_id
  aws_subnet_redis_cidr_block                          = var.vpc.aws_subnet_redis_cidr_block
  aws_subnet_redis_name                                = var.vpc.aws_subnet_redis_name
  aws_elasticache_subnet_group_redis_subnet_group      = var.vpc.aws_elasticache_subnet_group_redis_subnet_group
  aws_elasticache_subnet_group_redis_subnet_group_name = var.vpc.aws_subnet_redis_name

  Environment = var.Environment
  ManagedBy   = var.ManagedBy
}

# VPC subnet and configuration for EC2 instances
module "vpc_ec2" {
  source                                            = "./modules/vpc/ec2"
  aws_vpc_main_id                                   = module.vpc.aws_vpc_main_id
  aws_route_table_wordpress_cidr_block              = var.vpc.aws_route_table_wordpress_cidr_block
  aws_subnet_wordpress_cidr_block                   = var.vpc.aws_subnet_wordpress_cidr_block
  aws_subnet_wordpress_map_public_ip_on_launch      = var.vpc.aws_subnet_wordpress_map_public_ip_on_launch
  aws_subnet_wordpress_name                         = var.vpc.aws_subnet_wordpress_name
  aws_subnet_wordpress_aws_internet_gateway_gw_name = var.vpc.aws_subnet_wordpress_aws_internet_gateway_gw_name
  aws_route_table_wordpress_name                    = var.vpc.aws_subnet_wordpress_name

  Environment = var.Environment
  ManagedBy   = var.ManagedBy
}

# VPC subnet and configuration for RDS
module "vpc_rds" {
  source          = "./modules/vpc/rds"
  aws_vpc_main_id = module.vpc.aws_vpc_main_id

  aws_subnet_rds1_availability_zone = var.vpc.aws_subnet_rds1_availability_zone
  aws_subnet_rds1_cidr_block        = var.vpc.aws_subnet_rds1_cidr_block
  aws_subnet_rds1_name              = var.vpc.aws_subnet_rds1_name

  aws_subnet_rds2_availability_zone = var.vpc.aws_subnet_rds2_availability_zone
  aws_subnet_rds2_cidr_block        = var.vpc.aws_subnet_rds2_cidr_block
  aws_subnet_rds2_name              = var.vpc.aws_subnet_rds2_name

  aws_db_subnet_group_db_subnet_group_description = var.vpc.aws_db_subnet_group_db_subnet_group_description
  aws_db_subnet_group_db_subnet_group_name        = var.vpc.aws_db_subnet_group_db_subnet_group_name

  Environment = var.Environment
  ManagedBy   = var.ManagedBy
}

# VPC subnet and configuration for ALB
module "vpc_alb" {
  source                       = "./modules/vpc/alb"
  aws_vpc_main_id              = module.vpc.aws_vpc_main_id
  aws_route_table_wordpress_id = module.vpc_ec2.wordpress_routingtable_id

  alb_subnet_az1_cidr_block              = var.vpc.alb_subnet_az1_cidr_block
  alb_subnet_az1_availability_zone       = var.vpc.alb_subnet_az1_availability_zone
  alb_subnet_az1_map_public_ip_on_launch = var.vpc.alb_subnet_az1_map_public_ip_on_launch
  alb_subnet_az1_name                    = var.vpc.alb_subnet_az1_name

  alb_subnet_az2_cidr_block              = var.vpc.alb_subnet_az2_cidr_block
  alb_subnet_az2_availability_zone       = var.vpc.alb_subnet_az2_availability_zone
  alb_subnet_az2_map_public_ip_on_launch = var.vpc.alb_subnet_az2_map_public_ip_on_launch
  alb_subnet_az2_name                    = var.vpc.alb_subnet_az2_name

  Environment = var.Environment
  ManagedBy   = var.ManagedBy
}

##########################################################################
# Modules for ALB, EC2, Redis, and RDS
##########################################################################

module "alb" {
  source                    = "./modules/alb"
  aws_vpc_main_id           = module.vpc.aws_vpc_main_id
  aws_instance_wordpress_id = module.ec2.aws_instance_wordpress_id

  alb_security_group = module.securitygroups_alb.alb_sg

  aws_subnet_alb_subnet_az1_id = module.vpc_alb.aws_subnet_alb_subnet_az1_id
  aws_subnet_alb_subnet_az2_id = module.vpc_alb.aws_subnet_alb_subnet_az2_id

  aws_lb_name               = var.alb.aws_lb_name
  aws_lb_internal           = var.alb.aws_lb_internal
  aws_lb_load_balancer_type = var.alb.aws_lb_load_balancer_type
  aws_lb_tag_name           = var.alb.aws_lb_tag_name

  aws_lb_target_group_http_to_wordpress_name                = var.alb.aws_lb_target_group_http_to_wordpress_name
  aws_lb_target_group_http_to_wordpress_port                = var.alb.aws_lb_target_group_http_to_wordpress_port
  aws_lb_target_group_http_to_wordpress_protocol            = var.alb.aws_lb_target_group_http_to_wordpress_protocol
  aws_lb_target_group_http_to_wordpress_path                = var.alb.aws_lb_target_group_http_to_wordpress_path
  aws_lb_target_group_http_to_wordpress_interval            = var.alb.aws_lb_target_group_http_to_wordpress_interval
  aws_lb_target_group_http_to_wordpress_timeout             = var.alb.aws_lb_target_group_http_to_wordpress_timeout
  aws_lb_target_group_http_to_wordpress_healthy_threshold   = var.alb.aws_lb_target_group_http_to_wordpress_healthy_threshold
  aws_lb_target_group_http_to_wordpress_unhealthy_threshold = var.alb.aws_lb_target_group_http_to_wordpress_unhealthy_threshold
  aws_lb_target_group_http_to_wordpress_matcher             = var.alb.aws_lb_target_group_http_to_wordpress_matcher
  aws_lb_target_group_http_to_wordpress_tag_name            = var.alb.aws_lb_target_group_http_to_wordpress_tag_name

  aws_lb_listener_http_listener_port     = var.alb.aws_lb_listener_http_listener_port
  aws_lb_listener_http_listener_protocol = var.alb.aws_lb_listener_http_listener_protocol
  aws_lb_listener_http_listener_type     = var.alb.aws_lb_listener_http_listener_type

  aws_lb_target_group_attachment_wordpress_attachment = var.alb.aws_lb_target_group_attachment_wordpress_attachment
  aws_lb_enable_deletion_protection                   = var.alb.aws_lb_enable_deletion_protection

  Environment = var.Environment
  ManagedBy   = var.ManagedBy
}

# EC2 instance module
module "ec2" {
  source       = "./modules/ec2"
  subnet_id    = module.vpc_ec2.subnet_id
  wordpress_sg = module.securitygroups_ec2.ec2_sg

  ami                         = var.wordpress_ec2.ami
  instance_name               = var.wordpress_ec2.instance_name
  instance_type               = var.wordpress_ec2.instance_type
  key_name                    = var.wordpress_ec2.key_name
  associate_public_ip_address = var.wordpress_ec2.associate_public_ip_address
  volume_type                 = var.wordpress_ec2.volume_type
  volume_size                 = var.wordpress_ec2.volume_size

  WP_DB_NAME         = var.wp_config.WP_DB_NAME
  WP_DB_CHARSET      = var.wp_config.WP_DB_CHARSET
  WP_DB_TABLE_PREFIX = var.wp_config.WP_DB_TABLE_PREFIX
  WP_DB_USERNAME     = var.user-config.rds_username
  WP_DB_PASSWORD     = var.user-config.rds_password
  WP_DB_ENDPOINT     = module.rds.rds_endpoint

  WP_REDIS_PREFIX       = var.wp_config.WP_REDIS_PREFIX
  WP_REDIS_DATABASE     = var.wp_config.WP_REDIS_DATABASE
  WP_REDIS_TIMEOUT      = var.wp_config.WP_REDIS_TIMEOUT
  WP_REDIS_READ_TIMEOUT = var.wp_config.WP_REDIS_READ_TIMEOUT
  WP_REDIS_ENDPOINT     = module.redis.redis_endpoint
  WP_REDIS_PORT         = module.redis.redis_port

  WP_DEBUG          = var.user-config.WP_DEBUG
  WP_TITLE          = var.user-config.WP_TITLE
  WP_ADMIN_USER     = var.user-config.WP_ADMIN_USER
  WP_ADMIN_PASSWORD = var.user-config.WP_ADMIN_PASSWORD
  WP_ADMIN_EMAIL    = var.user-config.WP_ADMIN_EMAIL

  SERVER_ADMIN_EMAIL = var.user-config.SERVER_ADMIN_EMAIL
  ALB_DNS_NAME       = module.alb.alb_adress

  Environment = var.Environment
  ManagedBy   = var.ManagedBy
}

# RDS instance module
module "rds" {
  source               = "./modules/rds"
  db_subnet_group_name = module.vpc_rds.db_subnet_group_name
  rds_sg               = module.securitygroups_rds.rds_sg.id

  allocated_storage              = var.rds.allocated_storage
  db_name                        = var.rds.db_name
  engine                         = var.rds.engine
  engine_version                 = var.rds.engine_version
  instance_class                 = var.rds.instance_class
  username                       = var.user-config.rds_username
  password                       = var.user-config.rds_password
  parameter_group_name           = var.rds.parameter_group_name
  skip_final_snapshot            = var.user-config.rds_skip_final_snapshot
  publicly_accessible            = var.rds.publicly_accessible
  aws_db_instance_wordpress_name = var.rds.db_name

  Environment = var.Environment
  ManagedBy   = var.ManagedBy
}

# Redis instance module (Elasticache)
module "redis" {
  source                                          = "./modules/redis"
  aws_elasticache_subnet_group_redis_subnet_group = module.vpc_redis.aws_elasticache_subnet_group_redis_subnet_group
  aws_security_group_redis_sg                     = module.securitygroups_redis.aws_security_group_redis_sg

  cluster_id                         = var.redis.cluster_id
  engine                             = var.redis.engine
  node_type                          = var.redis.node_type
  num_cache_nodes                    = var.redis.num_cache_nodes
  parameter_group_name               = var.redis.parameter_group_name
  port                               = var.redis.port
  aws_elasticache_cluster_redis_name = var.redis.aws_elasticache_cluster_redis_name

  Environment = var.Environment
  ManagedBy   = var.ManagedBy
}


##########################################################################
# Security Group Modules
##########################################################################

# Security groups for Redis
module "securitygroups_redis" {
  source          = "./modules/securitygroups/redis"
  aws_vpc_main_id = module.vpc.aws_vpc_main_id

  Environment = var.Environment
  ManagedBy   = var.ManagedBy
}

# Security groups for EC2
module "securitygroups_ec2" {
  source             = "./modules/securitygroups/ec2"
  aws_vpc_main_id    = module.vpc.aws_vpc_main_id
  alb_security_group = module.securitygroups_alb.alb_sg
  enable_ssh_access  = var.user-config.enable_ssh_access

  Environment = var.Environment
  ManagedBy   = var.ManagedBy
}

# Security groups for RDS
module "securitygroups_rds" {
  source          = "./modules/securitygroups/rds"
  aws_vpc_main_id = module.vpc.aws_vpc_main_id

  Environment = var.Environment
  ManagedBy   = var.ManagedBy
}

# Security groups for ALB
module "securitygroups_alb" {
  source          = "./modules/securitygroups/alb"
  aws_vpc_main_id = module.vpc.aws_vpc_main_id

  Environment = var.Environment
  ManagedBy   = var.ManagedBy
}
