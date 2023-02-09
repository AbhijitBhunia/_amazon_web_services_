module "global_account_settings" {
  source = "../Global_Providers_Settings"
}

# Provider Block
provider "aws" {
  profile = module.global_account_settings.aws_user_profile
  region  = module.global_account_settings.aws_region
  #  https://registry.terraform.io/providers/hashicorp/aws/latest/docs
}
