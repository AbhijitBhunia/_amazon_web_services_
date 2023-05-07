output "server_ip" {
  value = aws_instance.ec2_instances.public_ip
}
