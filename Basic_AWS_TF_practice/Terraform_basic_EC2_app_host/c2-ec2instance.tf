# Resource: EC2 Instance
resource "aws_instance" "myec2vm" {
  ami = "ami-04db49c0fb2215364"
  instance_type = "t3.micro"
  user_data = file("${path.module}/app1-install.sh")
  tags = {
    "Source" = "Terraform"
  }
}