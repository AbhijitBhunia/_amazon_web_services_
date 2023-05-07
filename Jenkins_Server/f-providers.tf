module "global_account_settings" {
  source = "../Global_Providers_Settings"
}

terraform {
  backend "local" {
    path = "../../../safe-SEC_STORE/terraform_state_store/Jenkins_Server/terraform.tfstate"
  }
}