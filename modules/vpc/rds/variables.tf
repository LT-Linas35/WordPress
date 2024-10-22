variable "aws_vpc_main_id" {
  description = "The ID of the main  WordPress VPC"
  type        = string
}

variable "aws_subnet_rds1_cidr_block" {
  description = "CIDR block for RDS subnet 1"
  type        = string
}

variable "aws_subnet_rds1_availability_zone" {
  description = "Availability zone for RDS subnet 1"
  type        = string
}

variable "aws_subnet_rds1_name" {
  description = "Name for RDS subnet 1"
  type        = string
}

variable "aws_subnet_rds2_cidr_block" {
  description = "CIDR block for RDS subnet 2"
  type        = string
}

variable "aws_subnet_rds2_availability_zone" {
  description = "Availability zone for RDS subnet 2"
  type        = string
}

variable "aws_subnet_rds2_name" {
  description = "Name for RDS subnet 2"
  type        = string
}

variable "aws_db_subnet_group_db_subnet_group_name" {
  description = "Name for the RDS subnet group"
  type        = string
}

variable "aws_db_subnet_group_db_subnet_group_description" {
  description = "Description for the RDS subnet group"
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


