# AWS Security Group for EC2 instance
# This security group allows inbound traffic on ports 22 (SSH) and 80 (HTTP)
# and permits all outbound traffic. Inbound traffic is restricted to 
# specific IP address ranges using CIDR blocks.

resource "aws_security_group" "ec2" {
  description = "Allow inbound SSH (port 22) and HTTP (port 80) traffic, allow all outbound traffic"
  vpc_id      = var.aws_vpc_main_id

  # Ingress rule to allow SSH traffic (port 22) from a specific IP range
  dynamic "ingress" {
    for_each = var.enable_ssh_access ? [1] : []
    content {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # Replace with a specific IP range for security
    }
  }

  # Ingress rule to allow HTTP traffic (port 80) from any IP
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp" # Protocol is set to TCP for HTTP
    security_groups = [var.alb_security_group]
  }

  # Egress rule to allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"] # Allow outbound traffic to any destination
  }

  # Tags for easy identification and management
  tags = {
    Name        = "ec2_security_group"
    Environment = var.Environment # You can customize this tag to reflect the environment
    ManagedBy   = var.ManagedBy   # Helps to track which tool is managing this resource
  }
}
