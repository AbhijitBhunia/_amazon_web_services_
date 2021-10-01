output "internet-gateway-ID" {
  value = aws_internet_gateway.simple-gateway.id
}

output "internet-gateway-ARN" {
  value = aws_internet_gateway.simple-gateway.arn
}

output "egress-only-gateway-ID" {
  value = aws_egress_only_internet_gateway.egress-only-gateway.id
}
