# AWS RDS instance for WordPress
resource "aws_db_instance" "wordpress" {
  allocated_storage      = var.allocated_storage    # The amount of storage allocated for the RDS instance, in GiB.
  db_name                = var.db_name              # The name of the database to create in the RDS instance.
  engine                 = var.engine               # The type of database engine to use (e.g., mysql, postgres).
  engine_version         = var.engine_version       # The version of the database engine.
  instance_class         = var.instance_class       # The instance class to use (e.g., db.t2.micro).
  username               = var.username             # The master username for the database.
  password               = var.password             # The master password for the database.
  parameter_group_name   = var.parameter_group_name # The name of the parameter group to associate with the RDS instance.
  db_subnet_group_name   = var.db_subnet_group_name # The subnet group name for the RDS instance.
  skip_final_snapshot    = var.skip_final_snapshot  # Whether to skip the final snapshot when deleting the instance.
  publicly_accessible    = var.publicly_accessible  # Whether the database instance should be publicly accessible.
  vpc_security_group_ids = [var.rds_sg]             # The security group(s) to associate with the RDS instance.

  tags = {
    Name        = var.aws_db_instance_wordpress_name # The name tag for the AWS RDS instance used for the WordPress database
    Environment = var.Environment                    # You can customize this tag to reflect the environment
    ManagedBy   = var.ManagedBy                      # Helps to track which tool is managing this resource
  }
}
