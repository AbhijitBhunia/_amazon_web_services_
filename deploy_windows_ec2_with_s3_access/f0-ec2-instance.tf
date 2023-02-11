resource "aws_instance" "windows_server" {
  ami                    = module.global_account_settings.WINDOWS_AMI_ID
  instance_type          = module.global_account_settings.generic_instance_type
  key_name               = aws_key_pair.ec2-key-pair.key_name
  vpc_security_group_ids = [aws_security_group.Windows_server_vpc_web.id]
  iam_instance_profile   = aws_iam_instance_profile.windows_server_profile.name
  user_data              = file("${path.module}/f-app1-install.ps1")
  tags = merge({
    "project" = "WindowsServerProject1"
    },
    module.global_account_settings.tags
  )
}