# AWS Subnet for ALB in Availability Zone 1
resource "aws_subnet" "alb_subnet_az1" {
  vpc_id                  = var.aws_vpc_main_id                        # The ID of the VPC where this subnet will be created.
  cidr_block              = var.alb_subnet_az1_cidr_block              # The CIDR block for the subnet in Availability Zone 1.
  availability_zone       = var.alb_subnet_az1_availability_zone       # The Availability Zone for the subnet.
  map_public_ip_on_launch = var.alb_subnet_az1_map_public_ip_on_launch # Whether to map a public IP address on launch.

  tags = {
    Name        = var.alb_subnet_az1_name # The name tag for the subnet.
    Environment = var.Environment         # You can customize this tag to reflect the environment
    ManagedBy   = var.ManagedBy           # Helps to track which tool is managing this resource
  }
}

# AWS Subnet for ALB in Availability Zone 2
resource "aws_subnet" "alb_subnet_az2" {
  vpc_id                  = var.aws_vpc_main_id                        # The ID of the VPC where this subnet will be created.
  cidr_block              = var.alb_subnet_az2_cidr_block              # The CIDR block for the subnet in Availability Zone 2.
  availability_zone       = var.alb_subnet_az2_availability_zone       # The Availability Zone for the subnet.
  map_public_ip_on_launch = var.alb_subnet_az2_map_public_ip_on_launch # Whether to map a public IP address on launch.

  tags = {
    Name        = var.alb_subnet_az2_name # The name tag for the subnet.
    Environment = var.Environment         # You can customize this tag to reflect the environment
    ManagedBy   = var.ManagedBy           # Helps to track which tool is managing this resource
  }
}

# Route Table Association for ALB Subnet in Availability Zone 1
resource "aws_route_table_association" "alb_route_assoc_az1" {
  subnet_id      = aws_subnet.alb_subnet_az1.id     # The ID of the subnet to associate with the route table.
  route_table_id = var.aws_route_table_wordpress_id # The ID of the route table to associate with the subnet.
}

# Route Table Association for ALB Subnet in Availability Zone 2
resource "aws_route_table_association" "alb_route_assoc_az2" {
  subnet_id      = aws_subnet.alb_subnet_az2.id     # The ID of the subnet to associate with the route table.
  route_table_id = var.aws_route_table_wordpress_id # The ID of the route table to associate with the subnet.
}
