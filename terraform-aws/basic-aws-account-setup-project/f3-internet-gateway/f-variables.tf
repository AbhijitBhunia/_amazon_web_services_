# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "ap-south-1"
}

/*GW parameters*/


variable "IGW-tags" {
  default = {
    Name = "Environment-setup-internet-gateway"
  }
}

variable "EGW-tags" {
  default = {
    Name = "Environment-setup-egress-only-gateway"
  }
}
/*GW parameters*/