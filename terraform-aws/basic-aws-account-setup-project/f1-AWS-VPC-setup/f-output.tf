output "VPC_ARN" {
  value = aws_vpc.main.arn
}

output "VPC_ID" {
  value = aws_vpc.main.id
}

output "VPC-CIDR" {
  value = aws_vpc.main.cidr_block
}