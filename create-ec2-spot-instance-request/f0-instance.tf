resource "aws_spot_instance_request" "Linux-Spot-Instance" {
  ami                    = "ami-0c1a7f89451184c8b"
  instance_type          = "t2.medium"
  key_name               = aws_key_pair.ec2-key-pair.key_name
  wait_for_fulfillment   = true
  spot_type              = "one-time"
  vpc_security_group_ids = [
    aws_security_group.vpc_web.id,
    aws_security_group.vpc_ssh.id
  ]
  tags                   = merge(
  var.additional_tags,
  module.global_account_settings.tags
  )
  user_data = file("${path.module}/f-User-data.sh")
}
