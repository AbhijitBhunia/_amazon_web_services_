resource "aws_internet_gateway" "simple-gateway" {
  vpc_id = module.vpc_settings.VPC_ID

  tags = merge(
  module.project_provider_settings.tags,
  var.IGW-tags
  )
}

resource "aws_egress_only_internet_gateway" "egress-only-gateway" {
  vpc_id = module.vpc_settings.VPC_ID

  tags = merge(
  module.project_provider_settings.tags,
  var.EGW-tags
  )
}