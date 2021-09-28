output "VPC-ARN" {
  value = module.vpc_settings.VPC_ARN
}

output "VPC-ID" {
  value = module.vpc_settings.VPC_ID
}

output "Public-subnet-A-ARN" {
  value = aws_subnet.private-subnet-A.arn
}

output "Public-subnet-A-ID" {
  value = aws_subnet.public-subnet-A.id
}

output "Public-subnet-B-ARN" {
  value = aws_subnet.private-subnet-B.arn
}

output "Public-subnet-B-ID" {
  value = aws_subnet.private-subnet-B.id
}

output "public-subnet-A-ARN" {
  value = aws_subnet.public-subnet-A.arn
}

output "public-subnet-A-ID" {
  value = aws_subnet.public-subnet-A.id
}

output "public-subnet-B-ARN" {
  value = aws_subnet.public-subnet-B.arn
}

output "public-subnet-B-ID" {
  value = aws_subnet.public-subnet-B.id
}
