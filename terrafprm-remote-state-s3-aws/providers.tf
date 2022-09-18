terraform {
  required_version = ">= 1.1" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Provider Block
provider "aws" {
  profile                  = var.aws_user_profile
  region                   = module.variables.global_region
  shared_credentials_files = ["C:\\Users\\Administrator\\.aws\\credentials"]
  #  https://registry.terraform.io/providers/hashicorp/aws/latest/docs
  assume_role {
    role_arn = "arn:aws:iam::418887156176:role/sts-assumerole-tf"
    #    external_id  = "justassumedrole"
    session_name = "terraform_session"
  }
}

module "variables" {
  source = "../terraform-global-variable"
}