output "aws_security_group_redis_sg" {
  description = "Outputs the ID of the Redis security group"
  value       = aws_security_group.redis_sg.id
}
