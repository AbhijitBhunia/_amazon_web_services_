terraform {
  required_version = ">= 1.1" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "remote" {
    organization = "vjmouryaStateStore"
    workspaces {
      name = "aws-tf-base-setup"
    }
  }
}

# Provider Block
provider "aws" {
  region = var.aws_region
  #  https://registry.terraform.io/providers/hashicorp/aws/latest/docs
}