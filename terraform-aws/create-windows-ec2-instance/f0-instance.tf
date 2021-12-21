resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2-key-pair" {
  key_name   = var.instance_keypair
  public_key = tls_private_key.this.public_key_openssh
}

resource "aws_security_group" "allow_RDP" {
  name        = "allow-rdp-for-windows"
  description = "allow inbound RDP"
  ingress {
    from_port   = 3389
    protocol    = "tcp"
    to_port     = 3389
    cidr_blocks = ["192.168.219.22/32"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "windows_instance" {
  depends_on             = [
    aws_security_group.allow_RDP,
    aws_key_pair.ec2-key-pair
  ]
  ami                    = "ami-09a62bf22e41143a4"
  instance_type          = "t2.medium"
  key_name               = aws_key_pair.ec2-key-pair.key_name
  get_password_data      = true
  vpc_security_group_ids = [
    aws_security_group.allow_RDP.id
  ]
  tags                   = merge(
  var.additional_tags,
  module.global_account_settings.tags
  )
  user_data              = <<EOF
mkdir C:\Vijay-Mourya -Force
New-Item C:Vijay-Mourya\System-Start-Up.txt -Force
Write-Output "System Startup Date-Time" >> C:Vijay-Mourya\System-Start-Up.txt
Write-Output (Get-Date -f yyyy-mm-dd_HH-mm-ss) >> C:Vijay-Mourya\System-Start-Up.txt
EOF
}
