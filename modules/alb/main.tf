# Application Load Balancer
resource "aws_lb" "alb" {
  name               = var.aws_lb_name               # Name for the Application Load Balancer
  internal           = var.aws_lb_internal           # Boolean to specify if the Load Balancer is internal or internet-facing
  load_balancer_type = var.aws_lb_load_balancer_type # Type of Load Balancer (e.g., application, network)
  security_groups    = [var.alb_security_group]      # Security groups associated with the Load Balancer
  subnets = [
    var.aws_subnet_alb_subnet_az1_id, # Subnet ID for Availability Zone 1
    var.aws_subnet_alb_subnet_az2_id  # Subnet ID for Availability Zone 2
  ]

  enable_deletion_protection = var.aws_lb_enable_deletion_protection # Boolean to enable or disable deletion protection

  tags = {
    Name        = var.aws_lb_tag_name # Tag name for identifying the Load Balancer
    Environment = var.Environment     # You can customize this tag to reflect the environment
    ManagedBy   = var.ManagedBy       # Helps to track which tool is managing this resource
  }
}

# Target Group
resource "aws_lb_target_group" "http-to-wordpress" {
  name     = var.aws_lb_target_group_http_to_wordpress_name     # Name for the target group
  port     = var.aws_lb_target_group_http_to_wordpress_port     # Port for the target group to listen on
  protocol = var.aws_lb_target_group_http_to_wordpress_protocol # Protocol for the target group (e.g., HTTP, HTTPS)
  vpc_id   = var.aws_vpc_main_id                                # VPC ID where the target group resides

  # Health check configuration for the target group
  health_check {
    path                = var.aws_lb_target_group_http_to_wordpress_path                # Health check path (e.g., /)
    interval            = var.aws_lb_target_group_http_to_wordpress_interval            # Interval between health checks (in seconds)
    timeout             = var.aws_lb_target_group_http_to_wordpress_timeout             # Timeout for each health check attempt (in seconds)
    healthy_threshold   = var.aws_lb_target_group_http_to_wordpress_healthy_threshold   # Number of successful checks before considering the target healthy
    unhealthy_threshold = var.aws_lb_target_group_http_to_wordpress_unhealthy_threshold # Number of failed checks before considering the target unhealthy
    matcher             = var.aws_lb_target_group_http_to_wordpress_matcher             # HTTP code to use when checking for a healthy response
  }

  tags = {
    Name        = var.aws_lb_target_group_http_to_wordpress_tag_name # Tag name for identifying the target group
    Environment = var.Environment                                    # You can customize this tag to reflect the environment
    ManagedBy   = var.ManagedBy                                      # Helps to track which tool is managing this resource
  }
}

# Listener
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn                             # ARN of the Load Balancer to attach the listener to
  port              = var.aws_lb_listener_http_listener_port     # Port for the listener (e.g., 80 for HTTP)
  protocol          = var.aws_lb_listener_http_listener_protocol # Protocol for the listener (e.g., HTTP, HTTPS)

  default_action {
    type             = var.aws_lb_listener_http_listener_type    # Action type (e.g., forward)
    target_group_arn = aws_lb_target_group.http-to-wordpress.arn # ARN of the target group to forward requests to
  }
}

# Target Group Attachment
resource "aws_lb_target_group_attachment" "wordpress_attachment" {
  target_group_arn = aws_lb_target_group.http-to-wordpress.arn               # ARN of the target group to attach the instance to
  target_id        = var.aws_instance_wordpress_id                           # ID of the instance to attach to the target group
  port             = var.aws_lb_target_group_attachment_wordpress_attachment # Port on which the target is listening
}
