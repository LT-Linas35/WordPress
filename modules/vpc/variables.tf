variable "aws_vpc_main_cidr_block" {
  description = "The CIDR block for the main VPC"
  type        = string
}

variable "aws_vpc_main_name" {
  description = "The name of the main VPC"
  type        = string
}

variable "Environment" {
  description = "You can customize this tag to reflect the environment"
  type        = string
}

variable "ManagedBy" {
  description = "Helps to track which tool is managing this resource"
  type        = string
}
