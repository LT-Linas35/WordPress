output "ec2_sg" {
  description = "ID of the security group associated with the EC2 instance"
  value       = aws_security_group.ec2.id
}
