# Input Variables
# AWS Region

output "contact_person" {
  description = "creater/owner for the scripts and resources"
  value       = "vijayrmourya@gmail.com"
}

output "default_instance_type" {
  description = "EC2 Instnace Type"
  value       = "t2.micro"
}

output "default_UBUNTU_AMI_ID" {
  value = "ami-07ffb2f4d65357b42"
}

output "default_WINDOWS_AMI_ID" {
  value = "ami-077d687accca02dc1"
}

output "PERSONAL_SERVER_IP" {
  value = data.http.myip.response_body
}