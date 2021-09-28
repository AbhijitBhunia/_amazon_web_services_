module "project_provider_settings" {
  source = "../Providers_Settings"
}

# Provider Block
provider "aws" {
  profile = "vijay_aws_"
  region  = var.aws_region
}