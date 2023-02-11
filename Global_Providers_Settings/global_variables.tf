# Input Variables
# AWS Region
output "aws_region" {
  description = "Region in which AWS Resources to be created"
  value       = "ap-south-1"
}

output "contact_person" {
  description = "creater/owner for the scripts and resources"
  value       = "vijayrmourya@gmail.com"
}

output "aws_user_profile" {
  value   = "forawsuse2"
}

output "generic_instance_type" {
  description = "EC2 Instnace Type"
  value       = "t2.micro"
}

output "UBUNTU_AMI_ID" {
  value   = "ami-07ffb2f4d65357b42"
}

output "WINDOWS_AMI_ID" {
  value = "ami-077d687accca02dc1"
}

output "PERSONAL_SERVER_IP" {
  value = data.http.myip.response_body
}