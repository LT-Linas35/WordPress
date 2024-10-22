# **WordPress Deployment**

## Overview of the Code Structure
This repository is organized to facilitate the deployment of WordPress on AWS using Terraform. The main components are:

1. **Modules Directory**: Contains reusable modules, all of which are fully documented for ease of use. The modules include:
   - **VPC**: Provisions the Virtual Private Cloud for the infrastructure.
   - **EC2**: Sets up the EC2 instances for hosting WordPress.
   - **RDS**: Configures the Relational Database Service for WordPress data storage.
   - **Redis**: Deploys an Elasticache Redis cluster for caching purposes.
   - **ALB**: Sets up the Application Load Balancer for managing incoming traffic.
   - **SecurityGroups**: Configures security groups for controlling access to different components.

2. **Scripts Directory**: Contains the `wordpress.sh` script that is executed during the creation of the WordPress EC2 instance. This script installs and configures WordPress and is compatible with Red Hat-based systems.

3. **Terraform.tfvars File**: Defines the input variables that customize the deployment. These include region, instance type, environment tags, and WordPress-specific configurations.

4. **Main Terraform File**: The root module that brings together all the infrastructure components, calling different modules and linking them through variables and outputs.

5. **Outputs File**: Contains outputs to display important information after deployment, such as the URL of the WordPress site and SSH access details.

6. **README.md**: Documentation that guides users on how to deploy and configure WordPress, customize variables, and troubleshoot common issues.



## Deployment Steps:
- **Step 1:** Clone the repository
  ```sh
  git clone <repository-link>
  ```
- **Step 2:** Change directory to the WordPress deployment folder
  ```sh
  cd WordPress
  ```
- **Step 3:** Edit the `terraform.tfvars` file with your custom configuration
- **Step 4:** Initialize Terraform
  ```sh
  terraform init
  ```
- **Step 5:** Review the execution plan
  ```sh
  terraform plan
  ```
- **Step 6:** Apply the changes to create infrastructure
  ```sh
  terraform apply
  ```
- **Step 7:** Access the WordPress site
  ```sh
  http://${module.alb.alb_adress}
  ```
- **Step 8:** If SSH access is enabled, use the command below to connect to your instance
  ```sh
  ssh -i KEY.pem ${module.ec2.aws_instance_wordpress_public_ip}
  ```




### **Deployment Output**

- **WordPress Site URL:**
  ```
  ###############################################################

    http://${module.alb.alb_adress}

  ###############################################################
  ```

- **WordPress Admin Site URL:**
  ```
  ###############################################################

    http://${module.alb.alb_adress}/wp-admin

  ###############################################################
  ```

- **SSH Access (if enabled in debug):**
  ```
  ###############################################################

    ssh -i KEY.pem ${module.ec2.aws_instance_wordpress_public_ip}

  ###############################################################
  ```




# Terraform Deployment Configuration

This documentation provides a detailed overview of the Terraform configuration options used to deploy AWS-based infrastructure, including EC2 instances, RDS databases, and other necessary resources for a WordPress environment.

## General Settings

### `region`
- **Value**: `"eu-west-1"`
- **Description**: Defines the AWS region where resources will be deployed. For example, `eu-west-1` represents an AWS data center in Ireland.

### `Environment`
- **Value**: `"test"`
- **Description**: A customizable tag to indicate the environment where the deployment is happening, such as `dev`, `test`, or `prod`. This helps to distinguish between different stages of deployment.

### `ManagedBy`
- **Value**: `"Terraform"`
- **Description**: Helps track which tool is managing the resources. This tag is useful for maintaining infrastructure and indicating that Terraform is used for resource provisioning.

## User Configuration (`user-config`)

### `rds_username`
- **Value**: `""`
- **Description**: The username for the RDS database instance. It is recommended to manage this value securely, such as through Terraform Cloud or a similar secret management tool.

### `rds_password`
- **Value**: `""`
- **Description**: The password for the RDS database instance. This should also be managed securely via Terraform Cloud or an external secret management tool.

### `rds_skip_final_snapshot`
- **Value**: `true`
- **Description**: A boolean option to decide whether to skip the final snapshot when deleting the RDS instance. Setting this to `true` will delete the database immediately without taking a final backup.

### `SERVER_ADMIN_EMAIL`
- **Value**: `""`
- **Description**: The email address of the server administrator. This is used for any administrative contact or server configuration requirements.

### `WP_TITLE`
- **Value**: `""`
- **Description**: The title for the WordPress site. This will be displayed on the site and can be customized.

### `WP_ADMIN_USER`
- **Value**: `""`
- **Description**: The username for the WordPress admin user. This should be managed securely.

### `WP_ADMIN_PASSWORD`
- **Value**: `""`
- **Description**: The password for the WordPress admin user. Use Terraform Cloud or a similar tool to manage this value securely.

### `WP_ADMIN_EMAIL`
- **Value**: `""`
- **Description**: The email address of the WordPress admin. It is used for account recovery and receiving site notifications.

### `WP_DEBUG`
- **Value**: `false`
- **Description**: A boolean value that controls whether WordPress debug mode is enabled. Setting this to `true` can be useful during development for troubleshooting issues.

### `enable_ssh_access`
- **Value**: `true`
- **Description**: A boolean value that controls whether SSH access is allowed to the WordPress EC2 instance. Set it to `true` to open the SSH port and allow access. This setting can be modified later as needed.

## WordPress EC2 Instance Configuration (`wordpress_ec2`)

### `ami`
- **Value**: `"ami-07d4917b6f95f5c2a"`
- **Description**: The Amazon Machine Image (AMI) ID used to launch the WordPress EC2 instance. This AMI should contain a RedHat operating system and software stack for hosting WordPress.

### `instance_type`
- **Value**: `"t2.medium"`
- **Description**: Specifies the type of EC2 instance to be launched. The instance type determines the CPU, memory, and network performance characteristics of the instance.

### `instance_name`
- **Value**: `"WordPress EC2"`
- **Description**: The name tag assigned to the EC2 instance for easy identification.

### `key_name`
- **Value**: `""`
- **Description**: The key pair name that will be used to SSH into the EC2 instance. This should correspond to an existing SSH key that is registered in AWS.

### `associate_public_ip_address`
- **Value**: `true`
- **Description**: Specifies whether to associate a public IP address with the EC2 instance. A public IP is required to allow remote access over the internet.

### `volume_type`
- **Value**: `"gp3"`
- **Description**: The type of EBS volume attached to the instance. Common types are `gp2` or `gp3` for general-purpose SSD.

### `volume_size`
- **Value**: `"10"`
- **Description**: The size of the EBS volume in GiB that will be attached to the EC2 instance. This defines the storage capacity available for the instance.


