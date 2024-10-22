resource "aws_security_group" "rds_sg" {
  vpc_id = var.aws_vpc_main_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.1.0/24"]
  }

  tags = {
    Name        = "RDS Security Group"
    Environment = var.Environment # You can customize this tag to reflect the environment
    ManagedBy   = var.ManagedBy   # Helps to track which tool is managing this resource
  }
}
