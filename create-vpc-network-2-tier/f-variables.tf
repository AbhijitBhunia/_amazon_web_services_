## Input Variables
# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key Pair that need to be associated with EC2 Instance"
  type        = string
  default     = "test_server_key"
  # please create and save the keys with same name you create in AWS
}

variable "vpc_cidr" {
  default = "11.11.0.0/20"
}

variable "public_subnet" {
  default = "11.11.0.0/22"
}

variable "private_subnet" {
  default = "11.11.4.0/22"
}

variable "internet_cidr" {
  default = "0.0.0.0/0"
}