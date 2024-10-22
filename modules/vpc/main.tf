# AWS VPC Configuration
resource "aws_vpc" "main" {
  cidr_block = var.aws_vpc_main_cidr_block # The CIDR block for the main VPC.

  tags = {
    Name        = var.aws_vpc_main_name # The name tag for the VPC.
    Environment = var.Environment       # You can customize this tag to reflect the environment
    ManagedBy   = var.ManagedBy         # Helps to track which tool is managing this resource
  }
}
