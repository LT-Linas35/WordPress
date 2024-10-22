# AWS Subnet for Redis
resource "aws_subnet" "redis" {
  vpc_id     = var.aws_vpc_main_id             # The ID of the VPC where this subnet will be created.
  cidr_block = var.aws_subnet_redis_cidr_block # The CIDR block for the Redis subnet.

  tags = {
    Name        = var.aws_subnet_redis_name # The name tag for the Redis subnet.
    Environment = var.Environment           # You can customize this tag to reflect the environment
    ManagedBy   = var.ManagedBy             # Helps to track which tool is managing this resource
  }
}

# AWS ElastiCache Subnet Group for Redis
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = var.aws_elasticache_subnet_group_redis_subnet_group # The name of the Redis subnet group.
  subnet_ids = [aws_subnet.redis.id]                               # The list of subnet IDs for the Redis subnet group.

  tags = {
    Name        = var.aws_elasticache_subnet_group_redis_subnet_group_name # The name tag for the AWS ElastiCache subnet group used for Redis
    Environment = var.Environment                                          # You can customize this tag to reflect the environment
    ManagedBy   = var.ManagedBy                                            # Helps to track which tool is managing this resource
  }
}
