output "rds_endpoint" {
  description = "The endpoint for the RDS instance."
  value       = aws_db_instance.wordpress.endpoint
}
