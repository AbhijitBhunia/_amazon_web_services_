module "project_provider_settings" {
  source = "../Providers_Settings"
}

module "vpc_settings" {
  source = "../f1-AWS-VPC-setup"
}

module "subnets_settings" {
  source = "../f2-AWS-subnet-setup"
}