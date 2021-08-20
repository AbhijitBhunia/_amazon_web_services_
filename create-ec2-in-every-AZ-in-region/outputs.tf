# Terraform Output Values
# Filtered Output: Exclude Unsupported Availability Zones
output "All_available_AZ_with_required_instance" {
  value = {
  for az, details in data.aws_ec2_instance_type_offerings.my_ins_type:
  az => details.instance_types if length(details.instance_types) != 0 }
}

# Filtered Output: with Keys Function - Which gets keys from a Map
# This will return the list of availability zones supported for a instance type
output "All_available_AZ_for_instance" {
  value = keys({for az, details in data.aws_ec2_instance_type_offerings.my_ins_type:
  az => details.instance_types if length(details.instance_types) != 0 })
}

# EC2 Instance Public IP with TOSET
output "instance-arn" {
  description = "EC2 Instance ARN"
  value = toset([for instance in aws_instance.myec2vm: instance.arn])
}

output "instance_public-ip" {
  description = "EC2 Instance Public IP"
  value = toset([for instance in aws_instance.myec2vm: instance.public_ip])
}

# EC2 Instance Public DNS with TOMAP
output "instance_public-dns" {
  value = tomap({for az, instance in aws_instance.myec2vm: az => instance.public_dns})
}

output "root-block-device" {
  description = "EC2 Instance Public IP"
  value = toset([for instance in aws_instance.myec2vm: instance.root_block_device.0.volume_id])
}

output "SSH-security-group-id" {
  description = "SSH security group arns"
  value = aws_security_group.vpc-ssh.id
}

output "SSH-security-group-arn" {
  description = "SSH security group arns"
  value = aws_security_group.vpc-ssh.arn
}

output "web-security-group-id" {
  description = "SSH security group arns"
  value = aws_security_group.vpc-web.id
}

output "web-security-group-arn" {
  description = "SSH security group arns"
  value = aws_security_group.vpc-web.arn
}

/*
# Additional Important Note about OUTPUTS when for_each used
1. The [*] and .* operators are intended for use with lists only. 
2. Because this resource uses for_each rather than count, 
its value in other expressions is a toset or a map, not a list.
3. With that said, we can use Function "toset" and loop with "for" 
to get the output for a list
4. For maps, we can directly use for loop to get the output and if we 
want to handle type conversion we can use "tomap" function too 
*/

