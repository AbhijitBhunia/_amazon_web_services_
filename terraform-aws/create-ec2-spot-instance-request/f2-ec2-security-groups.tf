# Create Security Group - SSH Traffic
resource "aws_security_group" "vpc_ssh" {
  name        = "vpc-ssh"
  description = "Security group for SSH traffic"
  tags        = module.global_account_settings.tags
  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] /*just for practice purpose*/
  }
  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] /*just for practice purpose*/
  }
}

# Create Security Group - Web Traffic
resource "aws_security_group" "vpc_web" {
  name        = "vpc-web"
  description = "Security group for web traffic"
  tags        = module.global_account_settings.tags
  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] /*just for practice purpose*/
  }
  ingress {
    description = "Allow Port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] /*just for practice purpose*/
  }
  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] /*just for practice purpose*/
  }
}
