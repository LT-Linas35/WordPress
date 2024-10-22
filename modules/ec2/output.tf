output "aws_instance_wordpress_id" {
  description = "Output the ID of the WordPress EC2 instance"
  value       = aws_instance.wordpress.id
}

output "aws_instance_wordpress_public_ip" {
  description = "Output the Public IP of the WordPress EC2 instance"
  value = aws_instance.wordpress.public_ip
}