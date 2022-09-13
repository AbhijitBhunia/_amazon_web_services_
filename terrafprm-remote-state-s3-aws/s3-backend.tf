terraform {
  backend "s3" {
    bucket  = "aws.workshop.backend.s3.state.store"
    key     = "__AWS__/terraform-remote-state-s3-aws/terraform.tfstate"
    region  = "ap-south-1"
    profile = "vjmourya1"
    #    role_arn                = "arn:aws:iam::418887156176:role/sts-assumerole-tf"
    shared_credentials_file = "C:\\Users\\Administrator\\.aws\\credentials"
  }
}
