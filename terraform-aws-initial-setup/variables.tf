module "variables" {
  source = "../terraform-global-variable"
}

variable "bucket_versioning" {
  type    = string
  default = "Enabled"
}