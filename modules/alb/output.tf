output "alb_adress" {
  description = "DNS name of the AWS Load Balancer (ALB)"
  value       = aws_lb.alb.dns_name
}
