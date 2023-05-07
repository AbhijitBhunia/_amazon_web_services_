output "server_ip" {
  value = aws_instance.test_server.public_ip
}