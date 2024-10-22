output "wordpress_adress" {
  description = "The URL address of the WordPress site behind the ALB"
  value       = <<EOT
####################################################################

    It may take up to 10 mins to set everything up

       http://${module.alb.alb_adress}

    Admin site

       http://${module.alb.alb_adress}/wp-admin

####################################################################
EOT
}

output "wordpress_ssh" {
  description = "The SSH address of the WordPress EC2 instance"
  value       = var.user-config.enable_ssh_access ? "#################################################################### \n     Debug is on ssh port opened        \n       ssh -i ${var.wordpress_ec2.key_name}.pem ec2-user@${module.ec2.aws_instance_wordpress_public_ip}\n\n####################################################################" : ""
}
