output "Admin-password" {
  value = rsadecrypt(aws_instance.windows_instance.password_data, tls_private_key.tls-key.private_key_pem)
}
