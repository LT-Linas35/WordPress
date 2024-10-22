# AWS Subnet for RDS1
resource "aws_subnet" "rds1" {
  vpc_id            = var.aws_vpc_main_id                   # The ID of the VPC where this subnet will be created.
  cidr_block        = var.aws_subnet_rds1_cidr_block        # The CIDR block for the RDS1 subnet.
  availability_zone = var.aws_subnet_rds1_availability_zone # The availability zone for the RDS1 subnet.

  tags = {
    Name        = var.aws_subnet_rds1_name # The name tag for the RDS1 subnet.
    Environment = var.Environment          # You can customize this tag to reflect the environment
    ManagedBy   = var.ManagedBy            # Helps to track which tool is managing this resource
  }
}

# AWS Subnet for RDS2
resource "aws_subnet" "rds2" {
  vpc_id            = var.aws_vpc_main_id                   # The ID of the VPC where this subnet will be created.
  cidr_block        = var.aws_subnet_rds2_cidr_block        # The CIDR block for the RDS2 subnet.
  availability_zone = var.aws_subnet_rds2_availability_zone # The availability zone for the RDS2 subnet.

  tags = {
    Name        = var.aws_subnet_rds2_name # The name tag for the RDS2 subnet.
    Environment = var.Environment          # You can customize this tag to reflect the environment
    ManagedBy   = var.ManagedBy            # Helps to track which tool is managing this resource
  }
}

# AWS DB Subnet Group for RDS
resource "aws_db_subnet_group" "db_subnet_group" {
  name        = var.aws_db_subnet_group_db_subnet_group_name        # The name of the DB subnet group.
  description = var.aws_db_subnet_group_db_subnet_group_description # The description of the DB subnet group.
  subnet_ids  = [aws_subnet.rds1.id, aws_subnet.rds2.id]            # The list of subnet IDs for the DB subnet group.

  tags = {
    Name        = var.aws_db_subnet_group_db_subnet_group_name
    Environment = var.Environment # You can customize this tag to reflect the environment
    ManagedBy   = var.ManagedBy   # Helps to track which tool is managing this resource
  }
}
