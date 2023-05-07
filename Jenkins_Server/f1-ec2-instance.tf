# EC2 Instance
resource "aws_instance" "ec2_instances" {
  subnet_id              = data.terraform_remote_state.vpc.outputs.public_subnet_id
  ami                    = module.global_account_settings.default_UBUNTU_AMI_ID
  instance_type          = module.global_account_settings.default_instance_type
  user_data              = file("${path.module}/f-app1-install.sh")
  key_name               = aws_key_pair.ec2-key-pair.key_name
  vpc_security_group_ids = [aws_security_group.Jenskins_server_vpc_web.id]
  tags = merge({
    "Name" = "Jenkins_server"
    },
    module.global_account_settings.tags
  )
}
