# Terraform Settings Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.21" # Optional but recommended in production
    }
  }
}

# Provider Block
provider "aws" {
  profile = "Terraform_User" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region  = "ap-south-1"
}

# Resource Block
resource "aws_instance" "ec2demo" {
  ami           = "ami-04db49c0fb2215364" # Amazon Linux in ap-south-1, update as per your region
  instance_type = "t2.micro"
  tags = {
    "Source" = "Terraform"
    "User" = "Vijayrmourya"
  }
}
