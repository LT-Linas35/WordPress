variable "aws_vpc_main_id" {
  description = "The ID of the main  WordPress VPC"
  type        = string
}

variable "aws_route_table_wordpress_id" {
  description = "ID of the AWS route table for WordPress"
  type        = string
}


variable "alb_subnet_az1_cidr_block" {
  description = "CIDR block for ALB subnet in availability zone 1"
  type        = string
}

variable "alb_subnet_az1_availability_zone" {
  description = "Availability zone for ALB subnet in zone 1"
  type        = string
}

variable "alb_subnet_az1_map_public_ip_on_launch" {
  description = "Boolean indicating if public IP should be mapped on launch for ALB subnet 1"
  type        = bool
}

variable "alb_subnet_az1_name" {
  description = "Name for ALB subnet in availability zone 1"
  type        = string
}

variable "alb_subnet_az2_cidr_block" {
  description = "CIDR block for ALB subnet in availability zone 2"
  type        = string
}

variable "alb_subnet_az2_availability_zone" {
  description = "Availability zone for ALB subnet in zone 2"
  type        = string
}

variable "alb_subnet_az2_map_public_ip_on_launch" {
  description = "Boolean indicating if public IP should be mapped on launch for ALB subnet 2"
  type        = bool
}

variable "alb_subnet_az2_name" {
  description = "Name for ALB subnet in availability zone 2"
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
