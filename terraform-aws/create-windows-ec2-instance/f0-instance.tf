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
  user_data              = file("${path.module}/f-User-data.sh")
}
