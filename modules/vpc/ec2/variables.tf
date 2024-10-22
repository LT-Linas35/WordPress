variable "aws_vpc_main_id" {
  description = "The ID of the main  WordPress VPC"
  type        = string
}

variable "aws_subnet_wordpress_cidr_block" {
  description = "CIDR block for WordPress subnet"
  type        = string
}

variable "aws_subnet_wordpress_name" {
  description = "Name for WordPress main subnet"
  type        = string
}

variable "aws_route_table_wordpress_cidr_block" {
  description = "CIDR block for WordPress route table"
  type        = string
}

variable "aws_subnet_wordpress_map_public_ip_on_launch" {
  description = "Boolean indicating if public IP should be mapped on launch for WordPress subnet"
  type        = bool
}

variable "aws_subnet_wordpress_aws_internet_gateway_gw_name" {
  description = "Name for the Internet Gateway associated with WordPress subnet"
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

variable "aws_route_table_wordpress_name" {
  description = "The name tag for the AWS route table used for the WordPress infrastructure"
  type        = string
}

