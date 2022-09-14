output "aws_region" {
  description = "Region in which AWS Resources to be created"
  value     = "ap-south-1"
}

output "contact_person" {
  description = "creater/owner for the scripts and resources"
  value     = "vijayrmourya@gmail.com"
}

output "global_profile" {
  description = "global user profile for terraform"
  value = "vjmourya1"
}

output "global_state_bucket_name" {
  description = "global state store bucket"
  value = "aws.workshop.backend.s3.state.store"
}