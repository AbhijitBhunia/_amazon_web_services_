terraform {
  backend "s3" {
    bucket                  = "vjmouryatfstatebucket"
    key                     = "__AWS__/terrafprm-remote-state-s3-aws/terraform.tfstate"
    region                  = "ap-south-1"
    profile                 = "vjmourya1"
    shared_credentials_file = "C:\\Users\\Administrator\\.aws\\credentials"
  }
}
