resource "aws_vpc" "terraform_vpc" {
  cidr_block       = "11.11.0.0/20"
  instance_tenancy = "default"

  tags = merge({
    Name = "TerraformVPC"
    },
    module.global_account_settings.tags
  )
}

resource "aws_subnet" "terraform_public_subnet" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = "11.11.0.0/22"

  tags = merge({
    Name = "TerraformSubnetPublic"
    },
    module.global_account_settings.tags
  )
}

resource "aws_subnet" "terraform_private_subnet" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = "11.11.4.0/22"

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
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_internet_gateway.id
  }

  tags = merge({
    Name = "TerraformRouteTablePublic"
    },
    module.global_account_settings.tags
  )
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.terraform_public_subnet.id
  route_table_id = aws_route_table.terraform_route_table_public.id
}