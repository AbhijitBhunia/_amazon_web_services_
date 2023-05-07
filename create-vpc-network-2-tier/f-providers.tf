module "global_account_settings" {
  source = "../Global_Providers_Settings"
}

terraform {
  backend "local" {
    path = "../../../safe-SEC_STORE/terraform_state_store/create-vpc-network-2-tier/terraform.tfstate"
  }
}