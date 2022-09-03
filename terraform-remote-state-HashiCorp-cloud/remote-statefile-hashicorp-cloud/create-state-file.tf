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
      name = "testing-tfstate-store"
    }
  }
}

# Provider Block
provider "aws" {
  #  profile                  = var.aws_user_profile
  shared_config_files      = ["C:\\Users\\Administrator\\.aws\\config"]
  shared_credentials_files = ["C:\\Users\\Administrator\\.aws\\credentials"]
  region                   = var.aws_region
  #  https://registry.terraform.io/providers/hashicorp/aws/latest/docs
}

resource "aws_s3_bucket" "s3_Bucket0" {
  bucket        = "testbucketvjmourya"
  force_destroy = true
}