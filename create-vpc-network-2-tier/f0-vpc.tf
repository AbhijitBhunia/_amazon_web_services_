resource "aws_vpc" "terraform_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = merge({
    Name = "TerraformVPC"
    },
    module.global_account_settings.tags
  )
}

resource "aws_subnet" "terraform_public_subnet" {
  vpc_id                  = aws_vpc.terraform_vpc.id
  cidr_block              = var.public_subnet
  map_public_ip_on_launch = true

  tags = merge({
    Name = "TerraformSubnetPublic"
    },
    module.global_account_settings.tags
  )
}

resource "aws_subnet" "terraform_private_subnet" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = var.private_subnet

  tags = merge({
    Name = "TerraformSubnetPrivate"
    },
    module.global_account_settings.tags
  )
}

resource "aws_internet_gateway" "terraform_internet_gateway" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = merge({
    Name = "TerraformInternetGateway"
    },
    module.global_account_settings.tags
  )
}

resource "aws_route_table" "terraform_route_table_public" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = var.internet_cidr
    gateway_id = aws_internet_gateway.terraform_internet_gateway.id
  }

  tags = merge({
    Name = "TerraformRouteTablePublic"
    },
    module.global_account_settings.tags
  )
}

resource "aws_route_table" "terraform_route_table_private" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = merge({
    Name = "TerraformRouteTablePrivate"
    },
    module.global_account_settings.tags
  )
}

resource "aws_route_table_association" "private_subnet" {
  subnet_id      = aws_subnet.terraform_private_subnet.id
  route_table_id = aws_route_table.terraform_route_table_private.id
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.terraform_public_subnet.id
  route_table_id = aws_route_table.terraform_route_table_public.id
}