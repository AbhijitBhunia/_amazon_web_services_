# Input Variables
# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key Pair that need to be associated with EC2 Instance"
  type        = string
  default     = "Jenkins_server_key"
  # please create and save the keys with same name you create in AWS
}
