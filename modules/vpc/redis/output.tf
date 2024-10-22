output "aws_elasticache_subnet_group_redis_subnet_group" {
  description = "Outputs the name of the Redis subnet group for ElastiCache"
  value       = aws_elasticache_subnet_group.redis_subnet_group.name
}
