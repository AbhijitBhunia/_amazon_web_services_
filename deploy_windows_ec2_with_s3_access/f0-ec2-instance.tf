resource "aws_instance" "windows_server" {
  ami                    = module.global_account_settings.WINDOWS_AMI_ID
  instance_type          = module.global_account_settings.generic_instance_type
  key_name               = aws_key_pair.ec2-key-pair.key_name
  vpc_security_group_ids = [aws_security_group.Windows_server_vpc_web.id]
  tags = merge({
    "project" = "WindowsServerTCSProject1"
    },
    module.global_account_settings.tags
  )
}