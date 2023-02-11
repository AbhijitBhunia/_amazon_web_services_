# Create Security Group - Web Traffic
resource "aws_security_group" "Windows_server_vpc_web" {
  name        = "Windows-server-SG"
  description = "Security group for web traffic"
  ingress {
    description = "Allow all ip and ports inbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${chomp(module.global_account_settings.PERSONAL_SERVER_IP)}/32"]
  }
  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] /*just for practice purpose*/
  }
  tags = merge({
    "project" = "WindowsServerProject1"
    },
    module.global_account_settings.tags
  )
}
