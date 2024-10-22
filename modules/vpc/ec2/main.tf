# AWS Subnet for WordPress
resource "aws_subnet" "wordpress" {
  vpc_id                  = var.aws_vpc_main_id                              # The ID of the VPC where this subnet will be created.
  cidr_block              = var.aws_subnet_wordpress_cidr_block              # The CIDR block for the WordPress subnet.
  map_public_ip_on_launch = var.aws_subnet_wordpress_map_public_ip_on_launch # Whether to map a public IP address on launch.

  tags = {
    Name        = var.aws_subnet_wordpress_name # The name tag for the subnet.
    Environment = var.Environment               # You can customize this tag to reflect the environment
    ManagedBy   = var.ManagedBy                 # Helps to track which tool is managing this resource
  }
}

# Route Table Association for WordPress Subnet
resource "aws_route_table_association" "association" {
  subnet_id      = aws_subnet.wordpress.id      # The ID of the subnet to associate with the route table.
  route_table_id = aws_route_table.wordpress.id # The ID of the route table to associate with the subnet.
}

# Route Table for WordPress Subnet
resource "aws_route_table" "wordpress" {
  vpc_id = var.aws_vpc_main_id # The ID of the VPC where this route table will be created.

  route {
    cidr_block = var.aws_route_table_wordpress_cidr_block # The CIDR block for the route.
    gateway_id = aws_internet_gateway.gw.id               # The ID of the internet gateway for routing internet traffic.
  }

  tags = {
    Name        = var.aws_route_table_wordpress_name # The name tag for the AWS route table used for the WordPress infrastructure
    Environment = var.Environment                    # You can customize this tag to reflect the environment
    ManagedBy   = var.ManagedBy                      # Helps to track which tool is managing this resource
  }
}

# Internet Gateway for WordPress VPC
resource "aws_internet_gateway" "gw" {
  vpc_id = var.aws_vpc_main_id # The ID of the VPC where this internet gateway will be created.

  tags = {
    Name        = var.aws_subnet_wordpress_aws_internet_gateway_gw_name # The name tag for the internet gateway.
    Environment = var.Environment                                       # You can customize this tag to reflect the environment
    ManagedBy   = var.ManagedBy                                         # Helps to track which tool is managing this resource
  }
}
