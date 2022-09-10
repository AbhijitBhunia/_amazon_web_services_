terraform {
  backend "remote" {
    organization = "vjmouryaStateStore"
    workspaces {
      name = "testing-tfstate-store"
    }
  }
}