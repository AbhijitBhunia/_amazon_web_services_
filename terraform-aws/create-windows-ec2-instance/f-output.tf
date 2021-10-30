output "Admin-password" {
  value = rsadecrypt(aws_instance.windows_instance.password_data, tls_private_key.this.private_key_pem)
}
