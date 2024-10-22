output "rds_sg" {
  description = "Outputs the RDS security group"
  value       = aws_security_group.rds_sg
}
