variable "aws_vpc_main_id" {
  description = "The ID of the main  WordPress VPC"
  type        = string
}

variable "aws_instance_wordpress_id" {
  description = "ID of the AWS EC2 instance running WordPress"
  type        = string
}

variable "alb_security_group" {
  description = "ID of the security group associated with the Application Load Balancer (ALB)"
  type        = string
}

variable "aws_subnet_alb_subnet_az1_id" {
  description = "ID of the first subnet for the Application Load Balancer (ALB) in Availability Zone 1"
  type        = string
}

variable "aws_subnet_alb_subnet_az2_id" {
  description = "ID of the second subnet for the Application Load Balancer (ALB) in Availability Zone 2"
  type        = string
}

variable "aws_lb_name" {
  description = "Name for the AWS Load Balancer"
  type        = string
}

variable "aws_lb_internal" {
  description = "Boolean indicating if the Load Balancer should be internal"
  type        = bool
}

variable "aws_lb_load_balancer_type" {
  description = "Type of Load Balancer (e.g., application, network)"
  type        = string
}

variable "aws_lb_tag_name" {
  description = "Tag name for the Load Balancer"
  type        = string
}

variable "aws_lb_target_group_http_to_wordpress_name" {
  description = "Name for the target group HTTP to WordPress"
  type        = string
}

variable "aws_lb_target_group_http_to_wordpress_port" {
  description = "Port for the target group HTTP to WordPress"
  type        = number
}

variable "aws_lb_target_group_http_to_wordpress_protocol" {
  description = "Protocol for the target group HTTP to WordPress"
  type        = string
}

variable "aws_lb_target_group_http_to_wordpress_path" {
  description = "Health check path for the target group HTTP to WordPress"
  type        = string
}

variable "aws_lb_target_group_http_to_wordpress_interval" {
  description = "Health check interval for the target group HTTP to WordPress"
  type        = number
}

variable "aws_lb_target_group_http_to_wordpress_timeout" {
  description = "Health check timeout for the target group HTTP to WordPress"
  type        = number
}

variable "aws_lb_target_group_http_to_wordpress_healthy_threshold" {
  description = "Healthy threshold for the target group HTTP to WordPress"
  type        = number
}

variable "aws_lb_target_group_http_to_wordpress_unhealthy_threshold" {
  description = "Unhealthy threshold for the target group HTTP to WordPress"
  type        = number
}

variable "aws_lb_target_group_http_to_wordpress_matcher" {
  description = "Matcher for the target group HTTP to WordPress"
  type        = string
}

variable "aws_lb_target_group_http_to_wordpress_tag_name" {
  description = "Tag name for the target group HTTP to WordPress"
  type        = string
}

variable "aws_lb_listener_http_listener_port" {
  description = "Port for the HTTP listener"
  type        = number
}

variable "aws_lb_listener_http_listener_protocol" {
  description = "Protocol for the HTTP listener"
  type        = string
}

variable "aws_lb_listener_http_listener_type" {
  description = "Type for the HTTP listener (e.g., forward)"
  type        = string
}

variable "aws_lb_target_group_attachment_wordpress_attachment" {
  description = "Port for the target group attachment to WordPress"
  type        = number
}

variable "aws_lb_enable_deletion_protection" {
  description = "Boolean indicating if deletion protection should be enabled for the Load Balancer"
  type        = bool
}

variable "Environment" {
  description = "You can customize this tag to reflect the environment"
  type        = string
}

variable "ManagedBy" {
  description = "Helps to track which tool is managing this resource"
  type        = string
}

