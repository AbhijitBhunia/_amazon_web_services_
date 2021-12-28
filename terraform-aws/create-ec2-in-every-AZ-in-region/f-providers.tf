module "global_account_settings" {
  source = "../Global_Providers_Settings"
}

provider "aws" {
  region  = var.aws_region
}