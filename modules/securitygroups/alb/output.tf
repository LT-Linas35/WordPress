output "alb_sg" {
  description = "Outputs the ID of the ALB security group"
  value       = aws_security_group.alb_security_group.id
}
