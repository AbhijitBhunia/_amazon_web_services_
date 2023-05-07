resource "aws_instance" "test_server" {
  ami                    = module.global_account_settings.default_UBUNTU_AMI_ID
  instance_type          = module.global_account_settings.default_instance_type
  key_name               = aws_key_pair.ec2-key-pair.key_name
  vpc_security_group_ids = [aws_security_group.ubuntu_server_vpc_web.id]
  user_data              = file("${path.module}/f-app1-install.sh")
  tags = merge({
    "project" = "WindowsServerProject1"
    },
    module.global_account_settings.tags
  )
}