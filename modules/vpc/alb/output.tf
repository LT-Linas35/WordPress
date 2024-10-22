output "aws_subnet_alb_subnet_az1_id" {
  description = "Outputs the ID of the ALB subnet in Availability Zone 1"
  value       = aws_subnet.alb_subnet_az1.id
}

output "aws_subnet_alb_subnet_az2_id" {
  description = "Outputs the ID of the ALB subnet in Availability Zone 2"
  value       = aws_subnet.alb_subnet_az2.id
}
