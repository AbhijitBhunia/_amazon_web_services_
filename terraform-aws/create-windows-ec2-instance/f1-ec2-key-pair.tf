resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2-key-pair" {
  key_name   = var.instance_keypair
  public_key = tls_private_key.this.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.this.private_key_pem
  filename = "${path.module}/privet-key/create_ec2_in_every_AZ_in_region_key.pem"
}

resource "local_file" "windows_credentials" {
  content  = rsadecrypt(aws_instance.windows_instance.password_data, tls_private_key.this.private_key_pem)
  filename = "${path.module}/privet-key/windows-admin-password.txt"
}
