module "global_account_settings" {
  source = "../Global_Providers_Settings"
}

provider "aws" {
  profile = var.aws_user_profile
  region  = var.aws_region
  #  https://registry.terraform.io/providers/hashicorp/aws/latest/docs
}