resource "aws_subnet" "private-subnet-A" {
  depends_on = [module.vpc_settings]
  vpc_id     = module.vpc_settings.VPC_ID
  availability_zone = var.Availability_Zones[0]
  cidr_block = var.private-subnet-CIDRs[0]

  tags = merge(
          module.project_provider_settings.tags,
          var.private-subnet-name-A
  )
}

resource "aws_subnet" "private-subnet-B" {
  depends_on = [module.vpc_settings]
  vpc_id     = module.vpc_settings.VPC_ID
  availability_zone = var.Availability_Zones[1]
  cidr_block = var.private-subnet-CIDRs[1]

  tags = merge(
          module.project_provider_settings.tags,
          var.private-subnet-name-B
  )
}

resource "aws_subnet" "public-subnet-A" {
  depends_on = [module.vpc_settings]
  vpc_id     = module.vpc_settings.VPC_ID
  availability_zone = var.Availability_Zones[0]
  cidr_block = var.public-subnet-CIDRs[0]

  tags = merge(
          module.project_provider_settings.tags,
          var.public-subnet-name-A
  )
}

resource "aws_subnet" "public-subnet-B" {
  depends_on = [module.vpc_settings]
  vpc_id     = module.vpc_settings.VPC_ID
  availability_zone = var.Availability_Zones[1]
  cidr_block = var.public-subnet-CIDRs[1]

  tags = merge(
          module.project_provider_settings.tags,
          var.public-subnet-name-B
  )
}