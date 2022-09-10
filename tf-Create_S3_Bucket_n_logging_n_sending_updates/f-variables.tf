# Default Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "ap-south-1"
}

variable "contact_person" {
  description = "creater/owner for the scripts and resources"
  type        = string
  default     = "vijayrmourya@gmail.com"
}

variable "aws_user_profile" {
  type    = string
  default = "vjmourya1"
}

variable "bucket_name" {
  type = list(string)
  default = ["s3.bucket.for.practice"]
}

variable "bucket_versioning" {
  type = string
  default = "Enabled"
}