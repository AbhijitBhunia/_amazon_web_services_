module "global_account_settings" {
  source = "../tf-Global_Providers_Settings"
}

# Provider Block
provider "aws" {
  region  = var.aws_region
}