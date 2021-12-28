# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "ap-south-1"
}

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instnace Type"
  type        = string
  default     = "t3.medium"
}

# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key Pair that need to be associated with EC2 Instance"
  type        = string
  default     = "create-windows-ec2-instance-key" # please create and save the keys with same name you create in AWS
}

variable "additional_tags" {
  default     = {
    Name = "My-windows-instance"
  }
  description = "Additional resource tags"
  type        = map(string)
}