variable "aws_vpc_main_id" {
  description = "The ID of the main WordPress VPC"
  type        = string
}

variable "alb_security_group" {
  description = "The ID of the ALB security group"
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

variable "enable_ssh_access" {
  description = "Flag to enable SSH access (port 22)"
  type        = bool
}
