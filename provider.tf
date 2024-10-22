# AWS provider configuration
# It is highly recommended to store sensitive data such as access_key and secret_key
# in environment variables or use an AWS credentials file for security purposes.
provider "aws" {
  region     = var.region
}
