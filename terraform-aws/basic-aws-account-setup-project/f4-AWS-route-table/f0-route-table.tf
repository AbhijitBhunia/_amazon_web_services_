resource "aws_route_table" "primary-RT" {
  vpc_id = module.vpc_settings.VPC_ID

  route = [
    {
      cidr_block = "10.0.1.0/24"
      gateway_id = module.internet_gateway_settings.internet-gateway-ID
    },
    {
      ipv6_cidr_block        = "::/0"
      egress_only_gateway_id = module.internet_gateway_settings.egress-only-gateway-ID
    }
  ]

  tags = {
    Name = "example"
  }
}