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

variable "bucket_name" {
  default = "aws.workshop.backend.s3.state.store"
}

variable "bucket_versioning" {
  type    = string
  default = "Enabled"
}