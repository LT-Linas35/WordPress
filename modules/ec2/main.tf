# AWS EC2 instance for hosting WordPress
resource "aws_instance" "wordpress" {
  ami                         = var.ami                               # Amazon Machine Image (AMI) ID for the WordPress instance
  instance_type               = var.instance_type                     # EC2 instance type (e.g., t2.micro)
  key_name                    = var.key_name                          # Name of the SSH key pair for accessing the instance
  subnet_id                   = var.subnet_id                         # ID of the subnet in which to launch the instance
  vpc_security_group_ids      = [var.wordpress_sg]                    # Security group IDs for the instance
  associate_public_ip_address = var.associate_public_ip_address       # Whether to associate a public IP address
  user_data                   = data.template_file.user_data.rendered # User data script to configure the instance on startup

  # Root block device configuration for the instance
  root_block_device {
    volume_size = var.volume_size # Size of the root volume in GiB
    volume_type = var.volume_type # Type of the root volume (e.g., gp2, gp3)
  }

  tags = {
    Name        = var.instance_name # Tag to identify the instance by name
    Environment = var.Environment   # You can customize this tag to reflect the environment
    ManagedBy   = var.ManagedBy     # Helps to track which tool is managing this resource
  }
}

# Template file for user data script to configure WordPress
# This script sets up WordPress and configures it based on provided variables

data "template_file" "user_data" {
  template = file("./scripts/wordpress.sh") # Path to the WordPress setup script
  vars = {
    WP_DB_NAME         = var.WP_DB_NAME         # Database name for WordPress
    WP_DB_CHARSET      = var.WP_DB_CHARSET      # Database character set for WordPress
    WP_DB_TABLE_PREFIX = var.WP_DB_TABLE_PREFIX # Table prefix for WordPress database tables
    WP_DB_USERNAME     = var.WP_DB_USERNAME     # Username for connecting to the WordPress database
    WP_DB_PASSWORD     = var.WP_DB_PASSWORD     # Password for the WordPress database user
    WP_DB_ENDPOINT     = var.WP_DB_ENDPOINT     # Endpoint for the WordPress database

    WP_REDIS_PREFIX       = var.WP_REDIS_PREFIX       # Prefix for Redis cache keys used by WordPress
    WP_REDIS_DATABASE     = var.WP_REDIS_DATABASE     # Redis database number to use for caching
    WP_REDIS_TIMEOUT      = var.WP_REDIS_TIMEOUT      # Timeout value for Redis connections
    WP_REDIS_READ_TIMEOUT = var.WP_REDIS_READ_TIMEOUT # Read timeout value for Redis connections
    WP_REDIS_PORT         = var.WP_REDIS_PORT         # Port on which Redis is running
    WP_REDIS_ENDPOINT     = var.WP_REDIS_ENDPOINT     # Endpoint for Redis

    WP_DEBUG          = var.WP_DEBUG          # Debug mode setting for WordPress
    WP_TITLE          = var.WP_TITLE          # Title for the WordPress site
    WP_ADMIN_USER     = var.WP_ADMIN_USER     # Username for the WordPress admin user
    WP_ADMIN_PASSWORD = var.WP_ADMIN_PASSWORD # Password for the WordPress admin user
    WP_ADMIN_EMAIL    = var.WP_ADMIN_EMAIL    # Email address for the WordPress admin user
    ALB_DNS_NAME      = var.ALB_DNS_NAME      # Primary domain name for the server

    SERVER_ADMIN_EMAIL = var.SERVER_ADMIN_EMAIL # Email address for the server administrator
  }
}
