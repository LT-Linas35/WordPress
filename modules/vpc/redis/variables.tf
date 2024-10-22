variable "aws_vpc_main_id" {
  description = "The ID of the main  WordPress VPC"
  type        = string
}

variable "aws_subnet_redis_cidr_block" {
  description = "CIDR block for Redis subnet"
  type        = string
}

variable "aws_subnet_redis_name" {
  description = "Name for Redis main subnet"
  type        = string
}

variable "aws_elasticache_subnet_group_redis_subnet_group" {
  description = "The name of the Redis subnet group"
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

variable "aws_elasticache_subnet_group_redis_subnet_group_name" {
  description = "The name tag for the AWS ElastiCache subnet group used for Redis"
  type        = string
}
