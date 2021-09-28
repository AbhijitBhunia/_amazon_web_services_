# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "ap-south-1"
}

/*VPC parameters*/
variable "VPC_CIDR" {
//  (Required) The CIDR block for the VPC
  type = list(string)
  default = ["172.0.0.0/16"]
}

variable "instance_tenancy" {
//  (Optional) A tenancy option for instances launched into the VPC. Default is default, which makes your instances shared on the host. Using either of the other options (dedicated or host) costs at least $2/hr.
//  https://docs.aws.amazon.com/autoscaling/ec2/userguide/auto-scaling-dedicated-instances.html
  description = "Tenancy defines how EC2 instances are distributed across physical hardware and affects pricing."
  default = "default"
//  default = "dedicated"
//  default = "host"
//  To use a tenancy value of host, you must use a launch template.
}

variable "DNS_support" {
//  (Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults true.
//  https://docs.aws.amazon.com/vpc/latest/userguide/vpc-dns.html
  type = bool
  description = "Domain Name System (DNS) is a standard by which names used on the internet are resolved to their corresponding IP addresses."
  default = true
}

variable "DNS_hostnames" {
//  (Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false.
  type = bool
  default = false
}

variable "ClassicLink" {
//  (Optional) A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. See the ClassicLink documentation for more information. Defaults false.
//  ClassicLink is available to all users with accounts that support the EC2-Classic platform, and can be used with any EC2-Classic instance.
//  https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/vpc-classiclink.html
  type = bool
  description = "ClassicLink allows you to link EC2-Classic instances to a VPC in your account, within the same Region. If you associate the VPC security groups with a EC2-Classic instance, this enables communication between your EC2-Classic instance and instances in your VPC using private IPv4 addresses."
  default = false
}

variable "classiclink_dns_support" {
//  (Optional) A boolean flag to enable/disable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic.
  type = bool
  default = false
}

variable "generated_ipv6_cidr_block" {
//  (Optional) Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block. Default is false.
  type = bool
  default = false
}

variable "additional_vpc_tags" {
  default = {
    Name = "Environment-setup-common-VPC"
  }
}
/*VPC parameters*/