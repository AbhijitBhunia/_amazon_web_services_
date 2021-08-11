# Input Variables
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




//# AWS EC2 Instance Type
//variable "instance_type" {
//  description = "EC2 Instnace Type"
//  type        = string
//  default     = "t3.micro"
//}
//
//# AWS EC2 Instance Type - List
//variable "instance_type_list" {
//  description = "EC2 Instance Type"
//  type        = list(string)
//  default     = ["t3.micro", "t3.small", "t3.large"]
//}
//
//# AWS EC2 Instance Type - Map
//variable "instance_type_map" {
//  description = "EC2 Instance Type"
//  type        = map(string)
//  default = {
//    "dev"  = "t3.micro"
//    "qa"   = "t3.small"
//    "prod" = "t3.large"
//  }
//}
