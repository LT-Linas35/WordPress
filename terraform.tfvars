/* Commented out variables should be passed through TerraForm Cloud or other external secret management tools */

region      = "eu-west-1" // The AWS region to deploy resources in.
Environment = ""          // Customize this tag to reflect the environment (e.g., "dev", "prod").
ManagedBy   = "Terraform" // Helps track which tool is managing this resource.

user-config = {
  rds_username            = ""   // Username for the database (managed through TerraForm Cloud).
  rds_password            = ""   // Password for the database (managed through TerraForm Cloud).
  rds_skip_final_snapshot = true // Skip final snapshot when deleting the RDS instance.

  SERVER_ADMIN_EMAIL = "" // Email address for the server administrator.

  WP_TITLE          = ""    // The title of the WordPress site.
  WP_ADMIN_USER     = ""    // Username for the WordPress admin (pass through TerraForm Cloud).
  WP_ADMIN_PASSWORD = ""    // Password for the WordPress admin (pass through TerraForm Cloud).
  WP_ADMIN_EMAIL    = ""    // Email address for the WordPress admin.
  WP_DEBUG          = false // true/false WordPress debug mode.

  enable_ssh_access = false // Change to true if you want to open SSH port (you can change it later)
}

/* WordPress EC2 Instance Configuration */
wordpress_ec2 = {
  ami                         = "ami-07d4917b6f95f5c2a" // AMI ID for the WordPress EC2 instance. (Red Hat-based)
  instance_type               = "t2.medium"             // Type of EC2 instance to launch.
  instance_name               = "WordPress EC2"         // Name tag for the EC2 instance.
  key_name                    = ""                      // Key pair name for SSH access to the instance.
  associate_public_ip_address = true                    // Whether to assign a public IP address.
  volume_type                 = "gp3"                   // Type of EBS volume attached to the instance.
  volume_size                 = "10"                    // Size of the EBS volume in GiB.
}

##################################################################################################################
#                                       No need to change anything                                               #  
##################################################################################################################
/* WordPress wp-config.php Settings */
wp_config = {

  /* WordPress Settings */
  WP_DB_NAME         = "wordpress" // WordPress database name.
  WP_DB_CHARSET      = "utf8"      // Character set to use for the WordPress database.
  WP_DB_TABLE_PREFIX = "wp_"       // Prefix for the WordPress database tables.

  /* Redis Settings */
  WP_REDIS_PREFIX       = "wordpress" // Redis key prefix for WordPress caching.
  WP_REDIS_DATABASE     = 0           // Redis database index to use.
  WP_REDIS_TIMEOUT      = 1           // Redis connection timeout (in seconds).
  WP_REDIS_READ_TIMEOUT = 1           // Redis read timeout (in seconds).
}

##########################################################################################

/* RDS Configuration for WordPress Database */
rds = {
  allocated_storage    = 20                 // Allocated storage for RDS (in GiB).
  db_name              = "wordpress"        // Name of the RDS database.
  engine               = "mysql"            // Database engine (MySQL).
  engine_version       = "8.0"              // Version of MySQL engine.
  instance_class       = "db.t4g.micro"     // Instance class (e.g., db.t4g.micro).
  parameter_group_name = "default.mysql8.0" // Parameter group for the MySQL engine.
  publicly_accessible  = false              // Make RDS instance private.
}

##########################################################################################

/* Application Load Balancer (ALB) Configuration */
alb = {
  aws_lb_name                                = "alb"               // Name of the Application Load Balancer.
  aws_lb_internal                            = false               // Whether the load balancer is internal or internet-facing.
  aws_lb_load_balancer_type                  = "application"       // Type of load balancer (application).
  aws_lb_tag_name                            = "WordPress-alb"     // Tag name for the ALB.
  aws_lb_target_group_http_to_wordpress_name = "http-to-wordpress" // Target group name for HTTP traffic to WordPress.
  aws_lb_enable_deletion_protection          = false               // Enable/disable deletion protection for the ALB.

  aws_lb_target_group_http_to_wordpress_port                = 80                  // Port for HTTP traffic to WordPress.
  aws_lb_target_group_http_to_wordpress_protocol            = "HTTP"              // Protocol for the target group (HTTP).
  aws_lb_target_group_http_to_wordpress_path                = "/"                 // Path for health checks.
  aws_lb_target_group_http_to_wordpress_interval            = 30                  // Interval for health checks (in seconds).
  aws_lb_target_group_http_to_wordpress_timeout             = 5                   // Timeout for health checks (in seconds).
  aws_lb_target_group_http_to_wordpress_healthy_threshold   = 3                   // Number of successes required to mark as healthy.
  aws_lb_target_group_http_to_wordpress_unhealthy_threshold = 2                   // Number of failures required to mark as unhealthy.
  aws_lb_target_group_http_to_wordpress_matcher             = "200"               // Status code for a healthy check.
  aws_lb_target_group_http_to_wordpress_tag_name            = "http-to-wordpress" // Tag name for the target group.

  aws_lb_listener_http_listener_port                  = 80        // Listener port for HTTP.
  aws_lb_listener_http_listener_protocol              = "HTTP"    // Listener protocol.
  aws_lb_listener_http_listener_type                  = "forward" // Listener action type.
  aws_lb_target_group_attachment_wordpress_attachment = 80        // Port for target group attachment.
}

##########################################################################################

/* VPC Configuration for the Infrastructure */
vpc = {
  aws_vpc_main_cidr_block = "10.0.0.0/16"        // CIDR block for the main VPC.
  aws_vpc_main_name       = "WordPress main VPC" // Name for the VPC.

  /* ALB Subnet Configuration */
  alb_subnet_az1_cidr_block              = "10.0.6.0/24"    // CIDR block for ALB subnet in Availability Zone 1.
  alb_subnet_az1_availability_zone       = "eu-west-1a"     // Availability Zone for the subnet.
  alb_subnet_az1_map_public_ip_on_launch = true             // Assign public IP addresses on launch.
  alb_subnet_az1_name                    = "ALB Subnet AZ1" // Name for the subnet.

  alb_subnet_az2_cidr_block              = "10.0.7.0/24"    // CIDR block for ALB subnet in Availability Zone 2.
  alb_subnet_az2_availability_zone       = "eu-west-1b"     // Availability Zone for the subnet.
  alb_subnet_az2_map_public_ip_on_launch = true             // Assign public IP addresses on launch.
  alb_subnet_az2_name                    = "ALB Subnet AZ2" // Name for the subnet.

  /* Redis Subnet Configuration */
  aws_subnet_redis_cidr_block                     = "10.0.3.0/24"        // CIDR block for Redis.
  aws_subnet_redis_name                           = "Redis main subnet"  // Name for Redis subnet.
  aws_elasticache_subnet_group_redis_subnet_group = "redis-subnet-group" // Redis subnet group name.

  /* RDS Subnet Configuration */
  aws_subnet_rds1_cidr_block        = "10.0.4.0/24"     // CIDR block for RDS subnet 1.
  aws_subnet_rds1_availability_zone = "eu-west-1a"      // Availability Zone for the subnet.
  aws_subnet_rds1_name              = "RDS main subnet" // Name for RDS subnet.

  aws_subnet_rds2_cidr_block        = "10.0.5.0/24"     // CIDR block for RDS subnet 2.
  aws_subnet_rds2_availability_zone = "eu-west-1b"      // Availability Zone for the subnet.
  aws_subnet_rds2_name              = "RDS main subnet" // Name for RDS subnet.

  aws_db_subnet_group_db_subnet_group_name        = "wordpress-rds-subnet-group" // Subnet group name for RDS.
  aws_db_subnet_group_db_subnet_group_description = "Subnet group for RDS"       // Description for the RDS subnet group.

  /* WordPress Subnet Configuration */
  aws_subnet_wordpress_cidr_block              = "10.0.1.0/24"           // CIDR block for WordPress subnet.
  aws_subnet_wordpress_map_public_ip_on_launch = true                    // Assign public IP addresses on launch.
  aws_subnet_wordpress_name                    = "WordPress main subnet" // Name for WordPress subnet.

  /* Route Table Configuration */
  aws_route_table_wordpress_cidr_block              = "0.0.0.0/0" // CIDR block for route table.
  aws_subnet_wordpress_aws_internet_gateway_gw_name = "main"      // Name for the Internet Gateway.
}

##########################################################################################

/* Redis Configuration for Caching */
redis = {
  cluster_id                         = "wordpress-redis" // Redis cluster ID.
  engine                             = "redis"           // Cache engine (Redis).
  node_type                          = "cache.t4g.micro" // Redis node type.
  num_cache_nodes                    = 1                 // Number of Redis cache nodes.
  parameter_group_name               = "default.redis7"  // Redis parameter group for version 7.
  port                               = 6379              // Redis port.
  aws_elasticache_cluster_redis_name = "redis"           // Name for the Redis cluster.
}

