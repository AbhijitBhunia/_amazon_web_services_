terraform {
  backend "remote" {
    organization = "vjmouryaStateStore"
    workspaces {
      name = "aws-tf-base-setup"
    }
  }
}