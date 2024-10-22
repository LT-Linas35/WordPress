output "subnet_id" {
  description = "Outputs the ID of the WordPress subnet"
  value       = aws_subnet.wordpress.id
}

output "wordpress_routingtable_id" {
  description = "The ID of the WordPress route table."
  value       = aws_route_table.wordpress.id
}
