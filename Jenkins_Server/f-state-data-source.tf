data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "../../../safe-SEC_STORE/terraform_state_store/create-vpc-network-2-tier/terraform.tfstate"
  }
}