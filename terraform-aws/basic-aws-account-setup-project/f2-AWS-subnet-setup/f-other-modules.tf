module "project_provider_settings" {
  source = "../Providers_Settings"
}

module "vpc_settings" {
  source = "../f1-AWS-VPC-setup"
}