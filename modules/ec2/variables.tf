variable "subnet_id" {
  description = "The ID of the subnet where the EC2 instance will be launched."
  type        = string
}

variable "wordpress_sg" {
  description = "Security group for the WordPress instance."
  type        = string
}

variable "ami" {
  description = "The AMI ID to use for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance (e.g., t2.medium, t2.micro)."
  type        = string
}

variable "key_name" {
  description = "The key pair name to access the EC2 instance via SSH."
  type        = string
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance."
  type        = bool
}

variable "instance_name" {
  description = "Tag name for the EC2 instance."
  type        = string
}

variable "volume_size" {
  description = "The size of the EBS volume attached to the instance, in GiB."
  type        = number
}

variable "volume_type" {
  description = "The type of the EBS volume (e.g., gp2, io1, standard)."
  type        = string
}

######################### wp-config.php variables ###############################

variable "WP_DB_NAME" {
  description = "The name of the WordPress database."
  type        = string
}

variable "WP_DB_CHARSET" {
  description = "The character set to use for the WordPress database."
  type        = string
}

variable "WP_DB_TABLE_PREFIX" {
  description = "The prefix for the WordPress database tables."
  type        = string
}

variable "WP_REDIS_PREFIX" {
  description = "The prefix to use for Redis keys in WordPress."
  type        = string
}

variable "WP_REDIS_DATABASE" {
  description = "The Redis database number to use for WordPress."
  type        = number
}

variable "WP_REDIS_TIMEOUT" {
  description = "The timeout value (in seconds) for Redis connections in WordPress."
  type        = number
}

variable "WP_REDIS_READ_TIMEOUT" {
  description = "The read timeout value (in seconds) for Redis connections in WordPress."
  type        = number
}

variable "WP_DEBUG" {
  description = "Whether WordPress debugging mode is enabled."
  type        = bool
}

variable "WP_DB_USERNAME" {
  description = "The username for connecting to the WordPress database."
  type        = string
}

variable "WP_DB_PASSWORD" {
  description = "The password for connecting to the WordPress database."
  type        = string
}

variable "WP_DB_ENDPOINT" {
  description = "The endpoint (hostname or IP) for the WordPress database."
  type        = string
}

variable "WP_TITLE" {
  description = "The title of the WordPress site."
  type        = string
}

variable "WP_ADMIN_USER" {
  description = "The username for the WordPress admin account."
  type        = string
}

variable "WP_ADMIN_PASSWORD" {
  description = "The password for the WordPress admin account."
  type        = string
}

variable "WP_ADMIN_EMAIL" {
  description = "The email address for the WordPress admin account."
  type        = string
}

variable "WP_REDIS_ENDPOINT" {
  description = "The endpoint (hostname or IP) for the Redis database."
  type        = string
}

variable "WP_REDIS_PORT" {
  description = "The port for the Redis database."
  type        = string
}

variable "SERVER_ADMIN_EMAIL" {
  description = "Email address of the server administrator"
  type        = string
}

variable "Environment" {
  description = "You can customize this tag to reflect the environment"
  type        = string
}

variable "ManagedBy" {
  description = "Helps to track which tool is managing this resource"
  type        = string
}

variable "ALB_DNS_NAME" {
  description = "The DNS name of the Application Load Balancer (ALB)."
  type        = string
}