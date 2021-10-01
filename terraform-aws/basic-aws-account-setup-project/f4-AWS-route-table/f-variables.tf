# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "ap-south-1"
}

/*Subnet parameters*/
variable "private-subnet-CIDRs" {
  type = list(string)
  default = ["172.0.0.0/18","172.0.128.0/18"]
}

variable "public-subnet-CIDRs" {
  type = list(string)
  default = ["172.0.64.0/18","172.0.192.0/18"]
}

variable "Availability_Zones" {
  type = list(string)
  default = ["ap-south-1a","ap-south-1b"]
}

//Name tags
variable "private-subnet-name-A" {
  default = {
    Name = "Environment-setup-common-private-subnet-A"
  }
}

variable "private-subnet-name-B" {
  default = {
    Name = "Environment-setup-common-private-subnet-B"
  }
}

variable "public-subnet-name-A" {
  default = {
    Name = "Environment-setup-common-public-subnet-A"
  }
}

variable "public-subnet-name-B" {
  default = {
    Name = "Environment-setup-common-public-subnet-B"
  }
}
//****************
/*Subnet parameters*/