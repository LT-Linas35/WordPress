# AWS Region

variable "user-config" {
  type = object({
    SERVER_ADMIN_EMAIL      = string
    rds_username            = string
    rds_password            = string
    rds_skip_final_snapshot = bool
    enable_ssh_access       = bool
    WP_TITLE                = string
    WP_ADMIN_USER           = string
    WP_ADMIN_PASSWORD       = string
    WP_ADMIN_EMAIL          = string
    WP_DEBUG                = bool
  })
}

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

# Environment Tag
variable "Environment" {
  description = "this tag to reflect the environment, e.g., Development, Staging, or Production"
  type        = string
}

# Managed By Tag
variable "ManagedBy" {
  description = "Helps to track which tool is managing this resource, e.g., Terraform"
  type        = string
}


# Application Load Balancer Configuration
variable "alb" {
  description = "Configuration details for the Application Load Balancer (ALB)"
  type = object({
    aws_lb_name                                               = string
    aws_lb_internal                                           = bool
    aws_lb_load_balancer_type                                 = string
    aws_lb_tag_name                                           = string
    aws_lb_enable_deletion_protection                         = bool
    aws_lb_target_group_http_to_wordpress_name                = string
    aws_lb_target_group_http_to_wordpress_port                = number
    aws_lb_target_group_http_to_wordpress_protocol            = string
    aws_lb_target_group_http_to_wordpress_path                = string
    aws_lb_target_group_http_to_wordpress_interval            = number
    aws_lb_target_group_http_to_wordpress_timeout             = number
    aws_lb_target_group_http_to_wordpress_healthy_threshold   = number
    aws_lb_target_group_http_to_wordpress_unhealthy_threshold = number
    aws_lb_target_group_http_to_wordpress_matcher             = string
    aws_lb_target_group_http_to_wordpress_tag_name            = string
    aws_lb_listener_http_listener_port                        = number
    aws_lb_listener_http_listener_protocol                    = string
    aws_lb_listener_http_listener_type                        = string
    aws_lb_target_group_attachment_wordpress_attachment       = number
  })
}

# VPC and Subnet Configuration
variable "vpc" {
  description = "Configuration details for the VPC, subnets, and route tables"
  type = object({
    aws_vpc_main_cidr_block                           = string
    aws_vpc_main_name                                 = string
    aws_subnet_wordpress_aws_internet_gateway_gw_name = string
    alb_subnet_az1_cidr_block                         = string
    alb_subnet_az1_availability_zone                  = string
    alb_subnet_az1_map_public_ip_on_launch            = bool
    alb_subnet_az1_name                               = string
    alb_subnet_az2_cidr_block                         = string
    alb_subnet_az2_availability_zone                  = string
    alb_subnet_az2_map_public_ip_on_launch            = bool
    alb_subnet_az2_name                               = string
    aws_subnet_redis_cidr_block                       = string
    aws_subnet_redis_name                             = string
    aws_elasticache_subnet_group_redis_subnet_group   = string
    aws_subnet_rds1_cidr_block                        = string
    aws_subnet_rds1_availability_zone                 = string
    aws_subnet_rds1_name                              = string
    aws_subnet_rds2_cidr_block                        = string
    aws_subnet_rds2_availability_zone                 = string
    aws_subnet_rds2_name                              = string
    aws_db_subnet_group_db_subnet_group_name          = string
    aws_db_subnet_group_db_subnet_group_description   = string
    aws_subnet_wordpress_cidr_block                   = string
    aws_subnet_wordpress_map_public_ip_on_launch      = bool
    aws_subnet_wordpress_name                         = string
    aws_route_table_wordpress_cidr_block              = string
  })
}

# WordPress EC2 Instance Configuration
variable "wordpress_ec2" {
  description = "Configuration for WordPress EC2 instance"
  type = object({
    ami                         = string
    instance_name               = string
    instance_type               = string
    key_name                    = string
    associate_public_ip_address = bool
    volume_type                 = string
    volume_size                 = number
  })
}

# RDS Database Instance Configuration
variable "rds" {
  description = "Configuration for the RDS database instance"
  type = object({
    allocated_storage    = number
    db_name              = string
    engine               = string
    engine_version       = string
    instance_class       = string
    parameter_group_name = string
    publicly_accessible  = bool
  })
}

# Redis Cache Cluster Configuration
variable "redis" {
  description = "Configuration for the Redis cache cluster"
  type = object({
    cluster_id                         = string
    engine                             = string
    node_type                          = string
    num_cache_nodes                    = number
    parameter_group_name               = string
    port                               = number
    aws_elasticache_cluster_redis_name = string
  })
}

# WordPress wp-config.php Settings
variable "wp_config" {
  description = "Configuration for WordPress wp-config.php settings"
  type = object({
    WP_DB_NAME         = string
    WP_DB_CHARSET      = string
    WP_DB_TABLE_PREFIX = string

    WP_REDIS_PREFIX       = string
    WP_REDIS_DATABASE     = number
    WP_REDIS_TIMEOUT      = number
    WP_REDIS_READ_TIMEOUT = number
  })
}

