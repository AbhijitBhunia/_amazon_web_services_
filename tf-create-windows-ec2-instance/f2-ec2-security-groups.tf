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
